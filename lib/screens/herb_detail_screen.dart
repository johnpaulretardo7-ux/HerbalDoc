import 'package:flutter/material.dart';
import 'package:myapp/models/herb.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class HerbDetailScreen extends StatelessWidget {
  final Herb herb;

  const HerbDetailScreen({super.key, required this.herb});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(herb);

    return Scaffold(
      appBar: AppBar(
        title: Text(herb.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              favoriteProvider.toggleFavorite(herb);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'herb_image_${herb.id}',
              child: Image.asset(
                herb.imageUrl,
                fit: BoxFit.cover,
                height: 300,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Colors.grey[200],
                    child: const Icon(Icons.grass, size: 100, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    herb.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    herb.scientificName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    context,
                    title: 'Part Used',
                    items: [herb.partUsed],
                    icon: Icons.spa_outlined,
                  ),
                  _buildSection(
                    context,
                    title: 'Fast Facts',
                    items: [herb.facts],
                    icon: Icons.info_outline,
                  ),
                  _buildSection(
                    context,
                    title: 'Preparation',
                    items: [herb.preparation],
                    icon: Icons.local_drink_outlined,
                  ),
                  if (herb.uses.isNotEmpty)
                    _buildSection(
                      context,
                      title: 'Common Uses',
                      items: herb.uses,
                      icon: Icons.healing_outlined,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title,
      required List<String> items,
      required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(width: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(fontSize: 16, color: Colors.black87)),
                  Expanded(
                    child: Text(item,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5)),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 20),
      ],
    );
  }
}
