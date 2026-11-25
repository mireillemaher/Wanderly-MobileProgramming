import 'package:flutter/material.dart';

import 'bucket_list_screen.dart';
import 'destinations_view_model.dart';
import 'flag_image.dart';

// Task 7 + Lab 4 Tasks 1-5: Destinations Screen (logic lives in the ViewModel)
class DestinationsScreen extends StatefulWidget {
  const DestinationsScreen({super.key});

  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  // Task 5: create the ViewModel once
  final DestinationsViewModel viewModel = DestinationsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.load();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Destinations'),
        actions: [
          // Task 3: open the Bucket List with only the favorited destinations
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BucketListScreen(
                    savedDestinations: viewModel.destinations
                        .where((d) => viewModel.favoriteNames.contains(d.name))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            // Task 4.6: decide by the data first (live or cached)
            if (viewModel.destinations.isEmpty) {
              if (viewModel.error != null && !viewModel.isLoading) {
                return Center(child: Text(viewModel.error!));
              }
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: viewModel.destinations.length,
              itemBuilder: (context, index) {
                final d = viewModel.destinations[index];
                final bool isFavorite = viewModel.favoriteNames.contains(d.name);
                return Card(
                  child: ListTile(
                    leading: FlagImage(url: d.flagUrl),
                    title: Text(d.name),
                    subtitle: Text(
                      'Capital: ${d.capital} | Region: ${d.region} | Pop: ${d.population}',
                    ),
                    // Task 1: working favorite heart
                    trailing: GestureDetector(
                      onTap: () => viewModel.toggleFavorite(d.name),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite
                            ? const Color(0xFFC8741A)
                            : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}