import 'package:event_app/global.dart';
import 'package:event_app/widgets/distance_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  FiltersScreenState createState() => FiltersScreenState();
}

class FiltersScreenState extends State<FiltersScreen> {
  // Filter categories and their state
  final Map<String, bool> baseFilters = {
    "Kultura": false,
    "Oświata": false,
    "Ochrona zdrowia": false,
    "Sport": false,
    "Turystyka": false,
    "Gospodarka": false,
    "Ekologia": false,
    "Fundusze Europejskie": false,
  };

  final Map<String, bool> categoryFilters = {
    "Sztuki wizualne": false,
    "Muzyka": false,
    "Muzeum": false,
    "Teatr": false,
    "Kino": false,
  };

  final Map<String, bool> typeOfEventFilters = {
    "Warsztaty": false,
    "Targi": false,
    "Pikniki": false,
    "Kongresy": false,
    "Koncerty": false,
    "Spektakle": false,
    "Wystawy": false,
    "Konferencje": false,
    "Rajdy": false,
  };

  final Map<String, bool> ageFilters = {
    "Dla dzieci": false,
    "Dla seniora": false,
  };

  double distance = 50; // Distance filter value

  // Track expanded sections
  bool isCategoryExpanded = false;
  bool isEventTypeExpanded = false;
  bool isAgeExpanded = false;

  // Reset all filters to their default state
  void clearAllFilters() {
    setState(() {
      baseFilters.updateAll((key, value) => false);
      categoryFilters.updateAll((key, value) => false);
      typeOfEventFilters.updateAll((key, value) => false);
      ageFilters.updateAll((key, value) => false);
      distance = 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Filtruj",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            backgroundColor: Colors.white,
            floating: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                CupertinoIcons.clear,
                color: mainDarkBlue,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 20.0
                        : 80,
                vertical: 22),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Expandable filter sections
                  _buildExpandableSection("Kategorie", isCategoryExpanded, () {
                    setState(() {
                      isCategoryExpanded = !isCategoryExpanded;
                    });
                  }, categoryFilters),
                  _buildFilterSection(baseFilters, true),
                  _buildExpandableSection(
                      "Rodzaj wydarzenia", isEventTypeExpanded, () {
                    setState(() {
                      isEventTypeExpanded = !isEventTypeExpanded;
                    });
                  }, typeOfEventFilters),
                  _buildExpandableSection("Według wieku", isAgeExpanded, () {
                    setState(() {
                      isAgeExpanded = !isAgeExpanded;
                    });
                  }, ageFilters),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Szukaj w odległości od swojej lokalizacji",
                          style: TextStyle(color: Colors.grey),
                        ),
                        CustomSlider(
                          value: distance, // Current slider value
                          min: 0,
                          max: 100,
                          onChanged: (newValue) {
                            setState(() {
                              distance = newValue;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Clear all filters button
                      TextButton(
                        onPressed: () {
                          clearAllFilters();
                        },
                        child: const Text(
                          "Wyczyść",
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                      // Show results button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainDarkBlue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Text(
                          "Pokaż wyniki (24)", // Placeholder for results count
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build a section for non-expandable filters
  Widget _buildFilterSection(Map<String, bool> filters, bool addLastDivider) {
    final entries = filters.entries.toList(); // Convert map to list
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...entries.asMap().entries.map((entry) {
          final index = entry.key;
          final mapEntry = entry.value;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: CheckboxListTile(
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    mapEntry.key, // Filter title
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  value: mapEntry.value,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      filters[mapEntry.key] = value!;
                    });
                  },
                ),
              ),
              if (index != entries.length - 1 || addLastDivider)
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
            ],
          );
        }),
      ],
    );
  }

  // Build an expandable filter section with a toggle
  Widget _buildExpandableSection(String title, bool isExpanded,
      VoidCallback toggleExpanded, Map<String, bool> filters) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: InkWell(
            onTap: toggleExpanded,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up // Expanded state icon
                          : Icons.keyboard_arrow_down, // Collapsed state icon
                      color: mainDarkBlue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: _buildFilterSection(filters, false), // Nested filters
          ),
        const Divider(
          color: Color.fromARGB(255, 150, 190, 220),
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
