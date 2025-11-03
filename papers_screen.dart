import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class PapersScreen extends StatelessWidget {
  const PapersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final papers = [
      'Biology Paper',
      'Chemistry Paper',
      'Physics Paper',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Past Papers')),
      body: ListView.builder(
        itemCount: papers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(papers[index]),
            leading: const Icon(Icons.description, color: Colors.blue),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PaperViewer(
                        title: papers[index],
                        path:
                            "")), // Replace with actual PDF path from assets later
              );
            },
          );
        },
      ),
    );
  }
}

class PaperViewer extends StatelessWidget {
  final String title;
  final String path;
  const PaperViewer({super.key, required this.title, required this.path});

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