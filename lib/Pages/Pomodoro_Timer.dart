import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int count = 1;
  int workTime = 25 * 60;
  int breakTime = 5 * 60;
  int timeLeft = 25 * 60;
  bool isBreak = false;
  bool timerStarted = false; // Track if the timer has started
  Timer? timer; // Timer object

  void OnSave() {
    setState(() {
      count++;
    });
  }

  void OnSavedec() {
    setState(() {
      if (count > 1) {
        count--;
      }
    });
  }

  void startTimer() {
    setState(() {
      timerStarted = true;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          if (!isBreak) {
            timeLeft = breakTime;
            isBreak = true;
          } else {
            timeLeft = workTime;
            isBreak = false;

            if (count > 1) {
              count--;
            } else {
              timer.cancel();
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer if the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.black; // Default background color

    if (timerStarted) {
      backgroundColor = isBreak ? Colors.blue : Colors.green; // Green when working, blue during break
    }

    return Scaffold(
      backgroundColor: backgroundColor, // Set the background color
      body: timerStarted
          ? Center(
              child: Text(
                "${(timeLeft ~/ 60).toString().padLeft(2, '0')}:${(timeLeft % 60).toString().padLeft(2, '0')}",
                style: TextStyle(fontSize: 96, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No. of Cycles",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: OnSave,
                      child: Text("+"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      count.toString(),
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: OnSavedec,
                      child: Text("-"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  isBreak ? "Break Time" : "Work Time",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "${(timeLeft ~/ 60).toString().padLeft(2, '0')}:${(timeLeft % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: startTimer,
                  child: Text("Start"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    minimumSize: const Size(120, 40),
                  ),
                ),
              ],
            ),
    );
  }
}
