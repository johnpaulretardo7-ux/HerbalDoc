
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
            ],
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                Text(
                  'About the Author',
                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/author_pic.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 24),
                _buildAuthorInfo(context, 'Name:', 'John Paul Retardo'),
                const SizedBox(height: 8),
                _buildAuthorInfo(context, 'Address:', 'Brgy. Bantad, Gumaca, Quezon'),
                const SizedBox(height: 8),
                _buildAuthorInfo(context, 'Age:', '20 years old'),
                const SizedBox(height: 8),
                _buildAuthorInfo(context, 'Course:', 'Bachelor of Science in Industrial Technology (BSIT)'),
                const SizedBox(height: 8),
                _buildAuthorInfo(context, 'Year Level:', '3rd Year'),
                const SizedBox(height: 24),
                Text(
                  '“Don’t stop when you are tired, stop when you are done.”',
                  style: textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textTheme.bodyLarge?.copyWith(height: 1.5),
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
