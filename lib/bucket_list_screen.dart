import 'package:flutter/material.dart';

import 'destination.dart';
import 'flag_image.dart';

// Lab 4 Task 3: Bucket List Screen
class BucketListScreen extends StatelessWidget {
  final List<Destination> savedDestinations;

  const BucketListScreen({super.key, required this.savedDestinations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bucket List')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: savedDestinations.length,
          itemBuilder: (context, index) {
            final d = savedDestinations[index];
            return Card(
              child: ListTile(
                leading: FlagImage(url: d.flagUrl),
                title: Text(d.name),
                subtitle: Text(
                  'Capital: ${d.capital} | Region: ${d.region} | Pop: ${d.population}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}