import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/models/herb.dart';
import 'package:myapp/screens/herb_detail_screen.dart';
import 'package:myapp/widgets/herb_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Herb> _herbs = [];
  List<Herb> _filteredHerbs = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHerbs();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadHerbs() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/herbs.json');
      final data = json.decode(response);
      setState(() {
        _herbs = (data['herbs'] as List).map((i) => Herb.fromJson(i)).toList();
        _filteredHerbs = _herbs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load herb data: $e')),
        );
      }
    }
  }

  List<Herb> _searchHerbs(String query, List<Herb> allHerbs) {
    final lower = query.toLowerCase();
    if (lower.isEmpty) {
      return allHerbs;
    }
    return allHerbs.where((herb) {
      return herb.name.toLowerCase().contains(lower) ||
          herb.scientificName.toLowerCase().contains(lower) ||
          herb.description.toLowerCase().contains(lower) ||
          herb.healthBenefits
              .any((benefit) => benefit.toLowerCase().contains(lower)) ||
          herb.usage.any((use) => use.toLowerCase().contains(lower));
    }).toList();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredHerbs = _searchHerbs(_searchController.text, _herbs);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('HerbalDoc'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                  child: _filteredHerbs.isEmpty
                      ? Center(
                          child: Text(
                            'No herbs found.',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      : GridView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
