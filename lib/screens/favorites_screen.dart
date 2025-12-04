import 'package:flutter/material.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:myapp/widgets/herb_card.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My List'),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          final favorites = favoriteProvider.favorites;
          if (favorites.isEmpty) {
            return const Center(
              child: Text('You have no favorite herbs yet.'),
            );
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final herb = favorites[index];
              return HerbCard(herb: herb);
            },
          );
        },
      ),
    );
  }
}
