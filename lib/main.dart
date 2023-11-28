import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game_flutter/provider/game_provider.dart';
import 'package:tic_tac_toe_game_flutter/widgets/win_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal.shade600
      ),
      home: ChangeNotifierProvider(
        create: (context) => GameProvider(),
        child: const TicTacToe(),
      ),
    );
  }
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    GameProvider gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Tic Tac Toe'),
        actions: [
          gameProvider.board.any((element) => element == 'Player1' || element == 'Player2')
              ? IconButton(onPressed: (){
                  gameProvider.clearBoard(context);
                },
                icon: const Icon(Icons.refresh))
              : const SizedBox()
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) => Tile(index: index),
              ),
            ),
            // const SizedBox(height: 40),
            Row(
              children: [
                const Text('Player1: ', style: TextStyle(fontSize: 20)),
                Row(
                  children: List.generate(gameProvider.board.where((element) => element == 'Player1').toList().length,
                          (index) => Icon(Icons.check_circle, size: 22,color: Theme.of(context).primaryColor,)),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Text('Player2: ', style: TextStyle(fontSize: 20)),
                Row(
                  children: List.generate(gameProvider.board.where((element) => element == 'Player2').toList().length,
                          (index) => const Icon(Icons.check_circle,size: 22, color: Colors.amber)),
                ),
              ],
            ),
            // const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  const Tile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);

    return GestureDetector(
      onTap: () {
        gameProvider.makeMove(index);
        Future.delayed(const Duration(milliseconds: 100),(){
          if(gameProvider.isPlayerWin){
            log("Winning ${gameProvider.isPlayerWin} ${gameProvider.winPlayer}...");
            showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
              return winAlert(context, gameProvider);
            });
          }
          else{
            if(gameProvider.board.where((element) => element.isNotEmpty).toList().length == 6){
              log("length ${gameProvider.board.where((element) => element.isNotEmpty).toList().length}");
              showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                return drawAlert(context, gameProvider);
              });
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: (gameProvider.board[index] == 'Player1')
              ? Theme.of(context).primaryColor
              : (gameProvider.board[index] == 'Player2')
              ? Colors.amber
              : Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 0.2),
        ),
        child: Center(
          child: Text(gameProvider.board[index],style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
