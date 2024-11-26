import 'package:event_app/data/events_data.dart';
import 'package:event_app/global.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/views/events_components/popups/event_card_details.dart';
import 'package:event_app/views/events_components/event_card_tile.dart';
import 'package:event_app/views/events_components/event_carousel.dart';
import 'package:event_app/views/events_components/popups/event_filters.dart';
import 'package:event_app/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  EventsViewState createState() => EventsViewState();
}

class EventsViewState extends State<EventsView> {
  bool searchBarIsVisible = false;

  // Shows the event details popup dialog.
  void showPopupDialog(BuildContext context, Event data) {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return EventCardDetails(data: data);
      },
    );
  }

  // Shows the filter popup dialog.
  void showFilterDialog(BuildContext context) {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return const FiltersScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: const Text(
                'Wydarzenia',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              floating: false,
              pinned: false,
              leading: IconButton(
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: mainDarkBlue,
                  size: 35,
                ),
                onPressed: () {
                  // Handle back navigation.
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  onPressed: () {
                    setState(() {
                      searchBarIsVisible =
                          !searchBarIsVisible; // Toggles search bar visibility.
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.slider_horizontal_3),
                  onPressed: () {
                    showFilterDialog(context); // Opens the filter dialog.
                  },
                ),
              ],
            ),
          ];
        },
        body: Column(
          children: [
            // Conditionally shows the search bar.
            if (searchBarIsVisible)
              const Padding(
                padding: EdgeInsets.all(10.0),
                // Displays the search bar.
                child: CustomSearchBar(),
              ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                children: [
                  // Displays carousel of images.
                  EventCarousel(
                    images: carouselImagesList,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 10.0
                          : 80,
                    ),
                    child: Column(
                      children: eventList
                          .map(
                            (e) => InkWell(
                              onTap: () => showPopupDialog(context, e),
                              child: EventCardTile(data: e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
