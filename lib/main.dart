import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

void main() {
  runApp(const PSPMedPrepApp());
}

class PSPMedPrepApp extends StatelessWidget {
  const PSPMedPrepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSP MedPrep',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PdfController? _pdfController;
  String _pdfText = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    // Load PDF from assets
    final controller = PdfController(
      document: await PdfDocument.openAsset('assets/sample.pdf'), // replace with your PDF
    );

    // Extract text from first page
    final page = await controller.document.getPage(1);
    final text = await page.text;
    await page.close();

    setState(() {
      _pdfController = controller;
      _pdfText = text;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PSP MedPrep PDF Viewer'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: PdfView(
                    controller: _pdfController!,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey[200],
                  child: Text(
                    'Text from first page:\n$_pdfText',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
    );
  }
}
