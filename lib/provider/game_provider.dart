
import 'dart:developer';

import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'Player1';
  String winPlayer = '';
  bool isPlayerWin = false;

  late BuildContext context;

  void makeMove(int index) {
    if (board[index] == '') {
      board[index] = currentPlayer;
      isPlayerWin = checkWinner(currentPlayer);
      log("Win $isPlayerWin");
      log("Win $winPlayer");
      togglePlayer();
      notifyListeners();
    }
  }

  void togglePlayer() {
    currentPlayer = (currentPlayer == 'Player1') ? 'Player2' : 'Player1';
  }
  bool checkWinner(String player) {
    bool win = false;
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == player &&
          board[i * 3 + 1] == player &&
          board[i * 3 + 2] == player) {
        log('$player wins horizontally!');
        win = true;
        winPlayer = player;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i] == player && board[i + 3] == player && board[i + 6] == player) {
        log('$player wins vertically!');
        win = true;
        winPlayer = player;
      }
    }

    // Check diagonals
    if (board[0] == player && board[4] == player && board[8] == player) {
      log('$player wins diagonally!');
      win = true;
      winPlayer = player;
    }
    else if (board[2] == player && board[4] == player && board[6] == player) {
      log('$player wins diagonally!');
      win = true;
      winPlayer = player;
    }

    return win;
  }
  void clearBoard(context){
    board = List.filled(9, '');
    currentPlayer = 'Player1';
    Navigator.of(context).pop();
    notifyListeners();
  }

}