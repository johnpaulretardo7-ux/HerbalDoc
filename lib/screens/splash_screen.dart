import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:myapp/providers/herbs_provider.dart';
import 'package:myapp/screens/main_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _loadingMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    // Use WidgetsBinding to wait for the first frame to be rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDataAndNavigate();
    });
  }

  Future<void> _loadDataAndNavigate() async {
    // Check if the widget is still mounted before proceeding.
    if (!mounted) return;

    try {
      // Get providers before the async gap.
      final herbsProvider = Provider.of<HerbsProvider>(context, listen: false);
      final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);

      // Use Future.wait to load all necessary data concurrently.
      await Future.wait([
        herbsProvider.loadHerbs(),
        favoriteProvider.loadFavorites(),
      ]);

      // After the await, check if the widget is still mounted before using context.
      if (!mounted) return;

      // If data loading is successful, navigate to the main screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const MainScreen()),
      );
    } catch (e) {
      // After the await (in the catch block), check if the widget is still mounted.
      if (!mounted) return;
      
      // If there's an error, show it on the splash screen.
      setState(() {
        _loadingMessage = 'Failed to load data. Please restart the app.';
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade800,
                  Colors.green.shade600,
                  Colors.teal.shade400,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/herbal_logo.png', height: 180),
                  const SizedBox(height: 24),
                  Text(
                    'HerbalDoc',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 10.0, color: Colors.black.withAlpha(77))]
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your Pocket Guide to Herbal Plants',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 60),
                  const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  const SizedBox(height: 20),
                  Text(
                    _loadingMessage,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
