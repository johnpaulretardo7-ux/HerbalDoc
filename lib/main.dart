import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:myapp/widgets/bottom_nav_handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: MaterialApp(
        title: 'HerbalDoc',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2E7D32), // A deep, natural green
            brightness: Brightness.light,
            primary: const Color(0xFF2E7D32),
            secondary: const Color(0xFF8D6E63), // An earthy brown tone
            surface: const Color(0xFFF5F5DC), // A soft beige background
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: const Color(0xFF333333), // Dark charcoal for text
          ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: const Color(0xFF333333),
                  displayColor: const Color(0xFF333333),
                ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: Colors.black54,
          ),
          cardTheme: CardThemeData(
            elevation: 5,
            shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: const Color(0xFFE8F5E9), // Light green for cards
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: const Color(0xFFFFFFFF),
            selectedItemColor: const Color(0xFF2E7D32),
            unselectedItemColor: Colors.grey[600],
            type: BottomNavigationBarType.fixed,
            elevation: 8,
          ),
        ),
        home: const BottomNavHandler(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
