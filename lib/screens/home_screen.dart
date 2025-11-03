import 'package:flutter/material.dart';
import 'notes_screen.dart';
import 'papers_screen.dart';
import 'mock_test_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PSP MedPrep'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _HomeTile(
              icon: Icons.book,
              title: 'Notes',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NotesScreen())),
            ),
            _HomeTile(
              icon: Icons.description,
              title: 'Past Papers',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PapersScreen())),
            ),
            _HomeTile(
              icon: Icons.quiz,
              title: 'Mock Tests',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MockTestScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HomeTile(
      {required this.icon, required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
