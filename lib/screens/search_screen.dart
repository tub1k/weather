import 'package:flutter/material.dart';
import 'package:weather/core/extensions/l10n_extensions.dart';
import 'package:weather/services/get_weather_service.dart';
import 'package:weather/widgets/bottom_navigation_bar.dart';
import 'package:weather/screens/detailed_city_info.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final SearchController _searchController = SearchController();
  final WeatherService _weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MainNavigationBar(currentIndex: 1),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(context.l10n.search),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SearchAnchor(
          searchController: _searchController,
          builder: (context, controller) {
            return SearchBar(
              controller: controller,
              hintText: context.l10n.searchTip,
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.openView();
                });
              },
              onChanged: (_) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.openView();
                });
              },
              leading: const Icon(Icons.search),
            );
          },
          suggestionsBuilder: (context, controller) async {
            if (controller.text.trim().isEmpty) return [];
            await Future.delayed(const Duration(milliseconds: 300));
            final query = controller.text;
            final suggestions = await _weatherService.getSuggestions(query);

            return suggestions.map(
              (city) => ListTile(
                title: Text(city.displayName),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  _searchController.closeView(controller.text);
                  Future.microtask(() {
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedCityInfo(
                            showName: city.displayName,
                            technicalName: city.query,
                          ),
                        ),
                      );
                    }
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
  // Future<void> _saveAndGoBack(String city) async {
  //   List<String> cities = PrefsService.getFavorites();
  //   if (!cities.contains(city)) {
  //     cities.add(city);
  //     await PrefsService.saveFavorites(cities);
  //   }
  //   await Future.delayed(const Duration(milliseconds: 100));

  //   if (mounted) {
  //     Navigator.of(context).pop();
  //   }
  // }
}
