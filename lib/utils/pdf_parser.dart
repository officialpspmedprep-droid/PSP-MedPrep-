import 'package:pdf_text/pdf_text.dart';

class Question {
  String text;
  List<String> options;
  String correct;

  Question({required this.text, required this.options, required this.correct});
}

class PdfParser {
  static Future<List<Question>> extractQuestionsFromPdf(String assetPath) async {
    try {
      PDFDoc doc = await PDFDoc.fromAsset(assetPath);
      String text = await doc.text;

      final lines = text.split('\n');
      final List<Question> questions = [];
      String? qText;
      List<String> opts = [];
      String correct = '';

      for (var line in lines) {
        if (line.trim().isEmpty) continue;
        if (line.startsWith(RegExp(r'\d+[\).]'))) {
          if (qText != null && opts.isNotEmpty) {
            questions.add(Question(text: qText, options: opts, correct: correct));
            opts = [];
          }
          qText = line;
        } else if (line.startsWith(RegExp(r'[A-Da-d][\).]'))) {
          opts.add(line);
        } else if (line.toLowerCase().contains('answer')) {
          correct = line.split(':').last.trim();
        }
      }

      if (qText != null && opts.isNotEmpty) {
        questions.add(Question(text: qText, options: opts, correct: correct));
      }

      return questions;
    } catch (e) {
      print('Error reading PDF: $e');
      return [];
    }
  }
}
