
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
        clipBehavior: Clip.antiAlias, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        shadowColor: Colors.black.withAlpha(51), // Deprecation fix
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: 'herb_image_${herb.id}',
                child: Image.asset(
                  herb.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.grass, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      herb.name,
                      textAlign: TextAlign.left, // Align text to the left
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2, 
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Consumer<FavoriteProvider>(
                    builder: (context, favoriteProvider, child) {
                       final isFavorite = favoriteProvider.isFavorite(herb.id);
                       return IconButton(
                         icon: Icon(
                           isFavorite ? Icons.favorite : Icons.favorite_border,
                           color: isFavorite ? Colors.redAccent : Colors.grey[400],
                         ),
                         onPressed: () {
                           favoriteProvider.toggleFavorite(herb.id);
                         },
                       );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
