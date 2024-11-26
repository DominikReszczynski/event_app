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
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  bool searchBarIsVisible = false; // Ustawiona domyślnie na false

  void showPopupDialog(BuildContext context, Event data) {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return EventCardDetails(data: data);
      },
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (BuildContext context) {
          return FiltersScreen();
        });
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
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  onPressed: () {
                    setState(() {
                      searchBarIsVisible = !searchBarIsVisible;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.slider_horizontal_3),
                  onPressed: () {
                    showFilterDialog(context);
                  },
                ),
              ],
            ),
          ];
        },
        body: Column(
          children: [
            if (searchBarIsVisible)
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: CustomSearchBar(),
              ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                children: [
                  EventCarousel(
                    images: carouselImagesList,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 10.0
                            : 80),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
