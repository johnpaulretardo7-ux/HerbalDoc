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
    final isFavorite = favoriteProvider.isFavorite(herb.id);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          favoriteProvider.toggleFavorite(herb.id);
        },
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(herb.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Hero(
                tag: 'herb_image_${herb.id}',
                child: Image.asset(
                  herb.imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withAlpha(102),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      herb.scientificName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context).textTheme.bodySmall?.color?.withAlpha(179),
                          ),
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      context,
                      title: 'Part Used',
                      content: herb.partUsed,
                      icon: Icons.spa_outlined,
                    ),
                    _buildSection(
                      context,
                      title: 'Fast Facts',
                      content: herb.facts,
                      icon: Icons.info_outline,
                    ),
                    _buildSection(
                      context,
                      title: 'Preparation',
                      content: herb.preparation,
                      icon: Icons.local_drink_outlined,
                    ),
                    if (herb.uses.isNotEmpty)
                      _buildSection(
                        context,
                        title: 'Common Uses',
                        isList: true,
                        listContent: herb.uses,
                        icon: Icons.healing_outlined,
                      ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {
    required String title,
    required IconData icon,
    String? content,
    bool isList = false,
    List<String>? listContent,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          isList
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: listContent!.map((item) => Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('•  ', style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color)),
                        Expanded(
                          child: Text(item, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5)),
                        ),
                      ],
                    ),
                  )).toList(),
                )
              : Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                    content ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
              ),
        ],
      ),
    );
  }
}
