import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game_flutter/provider/game_provider.dart';

Widget winAlert(context, GameProvider gameProvider)=> AlertDialog(
  title: const Text('Winner!'),
  content: Text('${gameProvider.winPlayer} wins the game!'),
  actions: [
    TextButton(
      onPressed: (){
        gameProvider.clearBoard(context);
        Navigator.of(context).pop();
      },
      child: const Text('OK', style: TextStyle(color: Colors.black)),
    ),
  ],
);

Widget drawAlert(context, GameProvider gameProvider)=> AlertDialog(
  backgroundColor: Colors.amber,
  title: const Text('Draw!', style: TextStyle(color: Colors.white)),
  content: const Text('No One Win!', style: TextStyle(color: Colors.white)),
  actions: [
    TextButton(
      onPressed: (){
        gameProvider.clearBoard(context);
        Navigator.of(context).pop();
      },
      child: const Text('OK', style: TextStyle(color: Colors.white)),
    ),
  ],
);