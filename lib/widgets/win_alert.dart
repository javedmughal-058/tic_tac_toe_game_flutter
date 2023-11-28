import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game_flutter/provider/game_provider.dart';

class WinnerDialog extends StatelessWidget {
  const WinnerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);

    return AlertDialog(
      title: const Text('Winner!'),
      content: Text('${gameProvider.winPlayer} wins the game!'),
      actions: [
        TextButton(
          onPressed: () {
            gameProvider.clearBoard(context);
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}