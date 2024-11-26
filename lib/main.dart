import 'package:event_app/bottom_bar.dart';
import 'package:event_app/global.dart';
import 'package:event_app/views/Slaskie.dart';
import 'package:event_app/views/events.dart';
import 'package:event_app/views/explore.dart';
import 'package:event_app/views/news.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<MainViews>(
        valueListenable: currentSite,
        builder: (context, currentSiteValue, child) {
          return _buildBody();
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  // Function building content based on currentSite
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
