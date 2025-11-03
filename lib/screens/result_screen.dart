import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int total;
  final int correct;
  const ResultScreen({super.key, required this.total, required this.correct});

  @override
  Widget build(BuildContext context) {
    final double percent = (correct / total) * 100;
    return Scaffold(
      appBar: AppBar(title: const Text('Test Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You scored', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text('$correct / $total', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('${percent.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 24, color: Colors.blue)),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Tests'))
          ],
        ),
      ),
    );
  }
}
