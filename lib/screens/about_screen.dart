
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About HerbalDoc'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Center(
            child: Column(
              children: [
                Image.asset('assets/images/herbal_logo.png', height: 100),
                const SizedBox(height: 16),
                Text(
                  'HerbalDoc',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Welcome to HerbalDoc, your comprehensive and user-friendly guide to the rich world of medicinal plants. Our mission is to bridge the gap between traditional herbal wisdom and modern scientific understanding, empowering you to make safe and informed health choices. Explore detailed profiles of various herbs, learn about their time-tested uses, and discover the preparations that have been passed down through generations. This app is intended for informational and educational purposes only and should not be considered a substitute for professional medical advice. Always consult with a qualified healthcare provider before using any herbal remedies.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Made by John Paul Retardo BSIT-CPT3',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
