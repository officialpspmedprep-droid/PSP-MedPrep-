import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = ['Biology', 'Chemistry', 'Physics', 'English + Reasoning'];

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subjects[index]),
            leading: const Icon(Icons.book, color: Colors.blue),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // TODO: Replace with dynamic list of PDFs per subject
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        NotePDFViewer(title: subjects[index], path: "")),
              );
            },
          );
        },
      ),
    );
  }
}

class NotePDFViewer extends StatelessWidget {
  final String title;
  final String path;
  const NotePDFViewer({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: path.isEmpty
          ? const Center(child: Text("PDF file not added yet"))
          : PDFView(filePath: File(path).path),
    );
  }
}