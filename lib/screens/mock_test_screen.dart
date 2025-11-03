import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../utils/pdf_parser.dart';

class MockTestScreen extends StatefulWidget {
  const MockTestScreen({super.key});

  @override
  State<MockTestScreen> createState() => _MockTestScreenState();
}

class _MockTestScreenState extends State<MockTestScreen> {
  bool loading = false;
  List<Question> questions = [];
  int current = 0;
  Map<int, String> answers = {};

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    setState(() => loading = true);
    // Example placeholder path; later replace with actual pdf path
    questions = await PdfParser.extractQuestionsFromPdf('assets/mock_tests/flp1.pdf');
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    if (questions.isEmpty) {
      return const Scaffold(
          body: Center(child: Text('No mock tests found yet.')));
    }

    final q = questions[current];
    final selected = answers[current];

    return Scaffold(
      appBar: AppBar(title: Text('Mock Test (${current + 1}/${questions.length})')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(q.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...q.options.map((opt) => RadioListTile<String>(
                  title: Text(opt),
                  value: opt,
                  groupValue: selected,
                  onChanged: (val) {
                    setState(() => answers[current] = val!);
                  },
                )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (current > 0)
                  ElevatedButton(
                      onPressed: () => setState(() => current--),
                      child: const Text('Back')),
                if (current < questions.length - 1)
                  ElevatedButton(
                      onPressed: () => setState(() => current++),
                      child: const Text('Next')),
                if (current == questions.length - 1)
                  ElevatedButton(
                      onPressed: () {
                        int score = 0;
                        for (int i = 0; i < questions.length; i++) {
                          if (answers[i] == questions[i].correct) score++;
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ResultScreen(
                                    total: questions.length, correct: score)));
                      },
                      child: const Text('Submit')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
