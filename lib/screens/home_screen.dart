import 'package:flutter/material.dart';
import 'package:myapp/models/herb.dart';
import 'package:myapp/providers/herbs_provider.dart';
import 'package:myapp/screens/herb_detail_screen.dart';
import 'package:myapp/widgets/herb_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Herb> _filteredHerbs = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final herbsProvider = Provider.of<HerbsProvider>(context, listen: false);
    if (_searchController.text.isEmpty) {
      _filteredHerbs = herbsProvider.herbs;
    }
  }

  void _onSearchChanged() {
    final herbsProvider = Provider.of<HerbsProvider>(context, listen: false);
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredHerbs = herbsProvider.herbs;
      } else {
        _filteredHerbs = herbsProvider.herbs.where((herb) {
          return herb.name.toLowerCase().contains(query) ||
              herb.scientificName.toLowerCase().contains(query) ||
              herb.facts.toLowerCase().contains(query) ||
              herb.preparation.toLowerCase().contains(query) ||
              herb.uses.any((use) => use.toLowerCase().contains(query));
        }).toList();
      }
    });
  }

  void _navigateToDetail(Herb herb) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HerbDetailScreen(herb: herb),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final herbsProvider = Provider.of<HerbsProvider>(context);

    if (herbsProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('HerbalDoc')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (herbsProvider.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('HerbalDoc')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 20),
                const Text(
                  'Oops, something went wrong!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  herbsProvider.error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Update filtered herbs only when the list is successfully loaded and not searching
    if (_searchController.text.isEmpty) {
      _filteredHerbs = herbsProvider.herbs;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HerbalDoc'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or symptom (e.g., ubo)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          Expanded(
            child: _filteredHerbs.isEmpty && _searchController.text.isNotEmpty
                ? Center(
                    child: Text(
                      'No herbs found matching your search.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _filteredHerbs.length,
                    itemBuilder: (context, index) {
                      final herb = _filteredHerbs[index];
                      return GestureDetector(
                        onTap: () => _navigateToDetail(herb),
                        child: HerbCard(herb: herb),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
