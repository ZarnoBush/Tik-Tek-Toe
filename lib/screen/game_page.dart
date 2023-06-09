import 'dart:async';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool oTurn = true;
  List<String> displayOX = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<int> matchedIndex = [];
  int attempts = 0;

  String resultDeclaration = '';
  int oScore = 0;
  int xScore = 0;
  int filledBox = 0;
  bool nobodyWins = false;

  static const maxSeconds = 30;
  int second = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (second > 0) {
          second--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    restartTimer();
    timer?.cancel();
  }

  void restartTimer() => second = maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Player O',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          oScore.toString(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Player X',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          xScore.toString(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white, width: 5),
                            color: matchedIndex.contains(index)
                                ? Colors.black
                                : Colors.blueAccent),
                        child: Center(
                          child: Text(
                            displayOX[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Column(
                children: [
                  Text(
                    resultDeclaration,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildTimer()
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && displayOX[index] == '') {
          displayOX[index] = 'O';
          filledBox++;
        } else if (!oTurn && displayOX[index] == '') {
          displayOX[index] = 'X';
          filledBox++;
        }
        oTurn = !oTurn;
        _checkingWinner();
      });
    }
  }

  void _checkingWinner() {
    // check 1st Row
    if (displayOX[0] == displayOX[1] &&
        displayOX[0] == displayOX[2] &&
        displayOX[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayOX[0] + ' Wins';
        matchedIndex.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayOX[0]);
      });
    }

    // check 2st Row
    if (displayOX[3] == displayOX[4] &&
        displayOX[3] == displayOX[5] &&
        displayOX[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayOX[3] + ' Wins';
        matchedIndex.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayOX[3]);
      });
    }

    // check 3st Row
    if (displayOX[6] == displayOX[7] &&
        displayOX[6] == displayOX[8] &&
        displayOX[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayOX[6] + ' Wins';
        matchedIndex.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayOX[6]);
      });
    }

    // check 1st Column
    if (displayOX[0] == displayOX[3] &&
        displayOX[0] == displayOX[6] &&
        displayOX[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayOX[0] + ' Wins';
        matchedIndex.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayOX[0]);
      });
    }

    // check 2st Column
    if (displayOX[1] == displayOX[4] &&
        displayOX[1] == displayOX[7] &&
        displayOX[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayOX[1] + ' Wins';
        matchedIndex.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayOX[1]);
      });
    }

    // check 3st Column
    if (displayOX[2] == displayOX[5] &&
        displayOX[2] == displayOX[8] &&
        displayOX[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayOX[2] + ' Wins';
        matchedIndex.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayOX[2]);
      });
    }

    // check 1st Cross
    if (displayOX[0] == displayOX[4] &&
        displayOX[0] == displayOX[8] &&
        displayOX[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayOX[0] + ' Wins';
        matchedIndex.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayOX[0]);
      });
    }

    // check 2st Cross
    if (displayOX[2] == displayOX[4] &&
        displayOX[2] == displayOX[6] &&
        displayOX[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayOX[2] + ' Wins';
        matchedIndex.addAll([2, 4, 6]);
        stopTimer();
        _updateScore(displayOX[2]);
      });
    }
    if (!nobodyWins && filledBox == 9) {
      resultDeclaration = 'Nobody Wins!';
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    nobodyWins = true;
  }

  void _clearBorde() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayOX[i] = '';
      }
      resultDeclaration = '';
    });
    filledBox = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - second / maxSeconds,
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  backgroundColor: Colors.blue,
                ),
                Center(
                  child: Text(
                    '$second',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              startTimer();
              _clearBorde();
              attempts++;
            },
            child: Text(
              attempts == 0 ? 'Start' : 'Play Again!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
          );
  }
}
