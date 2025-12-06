
import 'package:flutter/material.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:myapp/providers/herbs_provider.dart';
import 'package:myapp/widgets/herb_card.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final allHerbs = Provider.of<HerbsProvider>(context).herbs;
    final favoriteHerbs = allHerbs.where((herb) => favoriteProvider.isFavorite(herb.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My List'),
      ),
      body: favoriteHerbs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary.withAlpha(128),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your list is empty',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tap the heart on any herb to add it to your list.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(179),
                        ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: favoriteHerbs.length,
              itemBuilder: (context, index) {
                final herb = favoriteHerbs[index];
                return HerbCard(herb: herb);
              },
            ),
    );
  }
}
