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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Tic Tac Toe'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) => Tile(index: index),
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
          log("here...");
          if(gameProvider.isPlayerWin){
            log("Winning ${gameProvider.isPlayerWin} ${gameProvider.winPlayer}...");
            showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
              return AlertDialog(
                title: Text('Winner!', style: TextStyle(color: Theme.of(context).primaryColor)),
                content: Text('${gameProvider.winPlayer} wins the game!', style: TextStyle(color: Theme.of(context).primaryColor)),
                actions: [
                  TextButton(
                    onPressed: ()=> gameProvider.clearBoard(context),
                    child: Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ],
              );
            });
          }
          else{
            if(gameProvider.board.where((element) => element.isNotEmpty).toList().length == 6){
              log("length ${gameProvider.board.where((element) => element.isNotEmpty).toList().length}");
              showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
                return AlertDialog(
                  backgroundColor: Colors.red.shade900,
                  title: const Text('Draw!', style: TextStyle(color: Colors.white)),
                  content: const Text('No One Win!', style: TextStyle(color: Colors.white)),
                  actions: [
                    TextButton(
                      onPressed: ()=> gameProvider.clearBoard(context),
                      child: const Text('OK', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                );
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
