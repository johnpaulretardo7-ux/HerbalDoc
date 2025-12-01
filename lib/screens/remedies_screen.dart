import 'package:flutter/material.dart';

class RemediesScreen extends StatelessWidget {
  const RemediesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remedies'),
      ),
      body: const Center(
        child: Text('Remedies Screen'),
      ),
    );
  }
}
