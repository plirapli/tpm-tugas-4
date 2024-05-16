import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final _duration = const Duration();
  final _stopwatch = Stopwatch();
  String _time = "00:00:00";
  String _miliSecond = "00";
  bool _isRunning = false;

  @override
  void dispose() {
    super.dispose();
    _stopwatch.stop(); // stop stopwatch if dismount
  }

  void _startTimer() => Timer(_duration, _keepRunning);

  void _keepRunning() {
    if (_stopwatch.isRunning) {
      _startTimer();
    }
    String h = (_stopwatch.elapsed.inHours % 100).toString().padLeft(2, "0");
    String m = (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0");
    String s = (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    String ms = (_stopwatch.elapsed.inMilliseconds % 1000)
        .toString()
        .padLeft(3, "0")
        .substring(0, 2);
    // Check if stopwatch still mounted
    if (mounted) {
      setState(() {
        _time = "$h:$m:$s";
        _miliSecond = ms;
      });
    }
  }

  // start btn handler
  void _startStopwatch() {
    setState(() => _isRunning = true);
    _stopwatch.start();
    _startTimer();
  }

  // pause btn handler
  void _pauseStopwatch() {
    setState(() => _isRunning = false);
    _stopwatch.stop();
  }

  // reset btn handler
  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _time = "00:00:00";
      _miliSecond = "00";
    });
    _stopwatch.stop();
    _stopwatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 48),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _time,
              style: const TextStyle(
                fontSize: 64,
                height: 0.9,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 56,
              child: Text(
                ".$_miliSecond",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(padding: const EdgeInsets.all(32)),
                onPressed: _isRunning ? _pauseStopwatch : _startStopwatch,
                child: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black12,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(32),
              ),
              onPressed: _resetStopwatch,
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
