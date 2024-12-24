import 'package:flutter/material.dart';
import 'dart:async';

import 'round_results_screen.dart';
import 'package:alias_game/widgets/card.dart';


class RoundScreen extends StatefulWidget {
  const RoundScreen({super.key});

  @override
  State<RoundScreen> createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
  late Duration _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = Duration(minutes: 1, seconds: 30);
    _startTimer();
  }


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime -= Duration(seconds: 1);
        if (_remainingTime <= Duration.zero) {
          _timer?.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RoundResultScreen()),
          );
        }
      });
    });
  }


  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Раунд'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_formatTime(_remainingTime), style: TextStyle(fontSize: 48)),
            const WordsCard(),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _remainingTime = Duration.zero;
                });
              },
              child: Text("Завершить"))
          ],
        ),
      ),
    );
  }
}