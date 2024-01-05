import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;

  int _time = 0;
  bool _isRunning = false; // 실행중 여부

  final List<String> _lapTimes = [];

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    _isRunning = false;
    _timer?.cancel();
    _lapTimes.clear();
    _time = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100; // 몫. milliseconds
    String hundredth = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Column(children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$sec',
              style: const TextStyle(fontSize: 50),
            ),
            Text(
              hundredth,
            ),
          ],
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: ListView(
            children: const [
              Center(child: Text('111')),
              Center(child: Text('111')),
              Text('111'),
              Text('111'),
              Text('111'),
              Text('111'),
              Text('111'),
              Text('121'),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                setState(() {
                  _reset();
                });
              },
              child: const Icon(Icons.refresh),
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                setState(() {
                  _clickButton();
                });
              },
              child: _isRunning
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
            ),
            FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ]),
    );
  }
}
