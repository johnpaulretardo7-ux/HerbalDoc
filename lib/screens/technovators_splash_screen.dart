
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/splash_screen.dart';

class TechnovatorsSplashScreen extends StatefulWidget {
  const TechnovatorsSplashScreen({super.key});

  @override
  State<TechnovatorsSplashScreen> createState() => _TechnovatorsSplashScreenState();
}

class _TechnovatorsSplashScreenState extends State<TechnovatorsSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // Navigate after the animation + a short delay
    Timer(
      const Duration(seconds: 5), // Total time on this screen
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
              const Color(0xFF000033), // Dark Navy
              Colors.purple.shade900,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withAlpha(128),
                          blurRadius: 25.0,
                          spreadRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/technovators_logo.png',
                      height: 180.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Technovators 2025-26',
                  style: GoogleFonts.exo2(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                     shadows: [
                      const Shadow(
                        blurRadius: 10.0,
                        color: Colors.cyanAccent,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80),
               SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.cyan.withAlpha(51),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
