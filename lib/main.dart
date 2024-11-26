import 'package:event_app/bottom_bar.dart';
import 'package:event_app/global.dart';
import 'package:event_app/views/slaskie_view.dart';
import 'package:event_app/views/events_view.dart';
import 'package:event_app/views/explore_view.dart';
import 'package:event_app/views/news_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event App - Dominik Reszczyński',
      home: EventsScreen(),
    );
  }
}

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<MainViews>(
        valueListenable:
            currentSite, // Observing the global `currentSite` for changes.
        builder: (context, currentSiteValue, child) {
          return _buildBody(); // Dynamically build the screen based on the selected view.
        },
      ),
      bottomNavigationBar: const BottomBar(), // Custom bottom navigation bar.
    );
  }

  // Builds the appropriate content widget based on the currentSite value.
  Widget _buildBody() {
    switch (currentSite.value) {
      case MainViews.slask:
        return const SlaskieView();
      case MainViews.news:
        return const NewsView();
      case MainViews.events:
        return const EventsView();
      case MainViews.explore:
        return const ExploreView();
      default:
        return const Center(
            child: Text('Unknown section', style: TextStyle(fontSize: 24)));
    }
  }
}
