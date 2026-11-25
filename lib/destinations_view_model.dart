import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db_helper.dart';
import 'destination.dart';

// Task 5: ViewModel that owns all the data + logic for DestinationsScreen
class DestinationsViewModel extends ChangeNotifier {
  // Task 2: SharedPreferencesAsync + key
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();
  static const _favKey = 'favorite_destinations';

  // State
  List<Destination> destinations = [];
  Set<String> favoriteNames = {};
  bool isLoading = false;
  String? error;

  bool _disposed = false;

  @override
  void notifyListeners() {
    // Avoid errors if a request finishes after the screen was closed
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  // Runs everything the screen needs on launch, in order:
  // favorites -> cache -> network
  Future<void> load() async {
    await loadFavorites();
    await loadCachedDestinations();
    await fetchDestinations();
  }

  // Task 2: read previously saved favorites (null on the very first launch)
  Future<void> loadFavorites() async {
    final List<String> saved = await _prefs.getStringList(_favKey) ?? [];
    favoriteNames = saved.toSet();
    notifyListeners();
  }

  // Task 4: show cached data first, but only if nothing is loaded yet
  Future<void> loadCachedDestinations() async {
    try {
      final List<Destination> cached = await DBHelper.getCachedDestinations();
      if (destinations.isEmpty && cached.isNotEmpty) {
        destinations = cached;
        notifyListeners();
      }
    } catch (e) {
      print('Error reading cache: $e');
    }
  }

  // Task 7 + Task 4: fetch from the network, then refresh the cache
  Future<void> fetchDestinations() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await Dio().get(
        'https://countries.dev/countries?fields=name,capital,region,population,alpha2Code',
      );
      final List rawList = response.data as List;
      final List<Destination> loadedDestinations = rawList
          .map((item) => Destination.fromJson(item as Map<String, dynamic>))
          .toList();

      destinations = loadedDestinations;

      // Refresh the cache (a cache failure must not count as a fetch failure)
      try {
        await DBHelper.cacheDestinations(loadedDestinations);
      } catch (e) {
        print('Error caching destinations: $e');
      }
    } catch (e) {
      print('Error fetching destinations: $e');
      error = 'Could not load destinations. Please check your connection.';
    }

    isLoading = false;
    notifyListeners();
  }

  // Task 1 + Task 2: toggle a favorite and persist it
  Future<void> toggleFavorite(String name) async {
    if (favoriteNames.contains(name)) {
      favoriteNames.remove(name);
    } else {
      favoriteNames.add(name);
    }
    notifyListeners();
    await _prefs.setStringList(_favKey, favoriteNames.toList());
  }
}