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
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              final provider =
                  Provider.of<FavoriteProvider>(context, listen: false);
              provider.toggleFavorite(herb);
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
                  const SizedBox(height: 16),
                  Text(
                    herb.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                  if (herb.healthBenefits.isNotEmpty)
                    _buildSection(
                      context,
                      title: 'Health Benefits',
                      items: herb.healthBenefits,
                      icon: Icons.healing,
                    ),
                  if (herb.usage.isNotEmpty)
                    _buildSection(
                      context,
                      title: 'Usage',
                      items: herb.usage,
                      icon: Icons.auto_awesome_mosaic_outlined,
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
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 32.0, bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(item,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}
