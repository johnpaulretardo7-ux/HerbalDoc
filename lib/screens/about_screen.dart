
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About HerbalDoc'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        children: [
          Center(
            child: Column(
              children: [
                Image.asset('assets/images/herbal_logo.png', height: 100),
                const SizedBox(height: 20),
                Text(
                  'HerbalDoc',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version 1.0.0',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Using a Column for better paragraph spacing
          Column(
            children: [
              Text(
                'Hey there! Welcome to HerbalDoc.',
                style: textTheme.titleLarge?.copyWith(height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'This app was born from a deep respect for the power of nature and the timeless wisdom passed down through generations. Our goal is to help you explore the world of medicinal plants in a way that\'s modern, friendly, and easy to understand.',
                style: textTheme.bodyLarge?.copyWith(height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Dive in to discover different herbs, learn about their traditional uses, and see how they\'ve been prepared for centuries.',
                style: textTheme.bodyLarge?.copyWith(height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Just a friendly reminder: Your health is our top priority. This app is for informational purposes only. It\'s always best to chat with a doctor or a qualified healthcare professional before trying any herbal remedies.',
                style: textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Made by John Paul Retardo BSIT-CPT3',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
