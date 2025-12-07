
import 'package:flutter/material.dart';
import 'package:myapp/models/herb.dart';
import 'package:myapp/providers/herbs_provider.dart';
import 'package:myapp/widgets/featured_herb_card.dart';
import 'package:myapp/widgets/herb_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final herbsProvider = Provider.of<HerbsProvider>(context);
    final List<Herb> allHerbs = herbsProvider.herbs;

    final List<Herb> filteredHerbs = _searchQuery.isEmpty
        ? allHerbs
        : allHerbs.where((herb) {
            return herb.name.toLowerCase().contains(_searchQuery) ||
                herb.scientificName.toLowerCase().contains(_searchQuery) ||
                herb.uses.any((use) => use.toLowerCase().contains(_searchQuery));
          }).toList();

    final Herb? featuredHerb = allHerbs.isNotEmpty ? allHerbs[0] : null;

    if (herbsProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (herbsProvider.error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 20),
                Text(
                  'Oops, something went wrong!',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  herbsProvider.error!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green[800],
            pinned: true,
            floating: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              title: Text(
                'HerbalDoc',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              background: Container(
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
                child: Image.asset(
                  'assets/images/herbal_logo.png', 
                  fit: BoxFit.cover,
                  color: Colors.black.withAlpha(26),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: TextField(
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search for herbs or symptoms...',
                  prefixIcon: Icon(Icons.search, color: Colors.green[800]),
                  filled: true,
                  fillColor: Colors.white.withAlpha(230),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
              ),
            ),
          ),
          if (featuredHerb != null && _searchQuery.isEmpty)
            SliverToBoxAdapter(
              child: FeaturedHerbCard(herb: featuredHerb),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Text(
                _searchQuery.isEmpty ? 'All Herbs' : 'Search Results',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.green[900]),
              ),
            ),
          ),
          filteredHerbs.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No herbs found.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return HerbCard(herb: filteredHerbs[index]);
                      },
                      childCount: filteredHerbs.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
