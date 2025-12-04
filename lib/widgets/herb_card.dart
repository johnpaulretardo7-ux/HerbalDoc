import 'package:flutter/material.dart';
import 'package:myapp/models/herb.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:myapp/screens/herb_detail_screen.dart';
import 'package:provider/provider.dart';

class HerbCard extends StatelessWidget {
  final Herb herb;

  const HerbCard({super.key, required this.herb});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(herb);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HerbDetailScreen(herb: herb),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: 'herb_image_${herb.id}',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15.0)),
                        child: Image.asset(
                          herb.imageUrl,
                          fit: BoxFit.cover,
                          // Show a placeholder if the image fails to load
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.grass,
                                  size: 50, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          final provider = Provider.of<FavoriteProvider>(
                              context,
                              listen: false);
                          provider.toggleFavorite(herb);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                herb.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
