import 'package:event_app/global.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/views/events_components/popups/add_to_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCardDetails extends StatefulWidget {
  final Event data; // Event data to display
  const EventCardDetails({super.key, required this.data});

  @override
  EventCardDetailsState createState() => EventCardDetailsState();
}

class EventCardDetailsState extends State<EventCardDetails> {
  @override
  Widget build(BuildContext context) {
    // Displays a popup to add the event to the calendar
    void showCalendarPopup(BuildContext context, Event data) {
      showDialog(
        useSafeArea: false,
        context: context,
        builder: (BuildContext context) {
          return AddToCalendar(data: data);
        },
      );
    }

    // List of action buttons
    List<Map<String, dynamic>> buttonsDataList = [
      {
        'title': "Dodaj do\nkalendarza",
        'icon': MdiIcons.calendarPlusOutline,
        'onPress': () {
          showCalendarPopup(context, widget.data);
        }
      },
      {
        'title': "Udostępnij",
        'icon': MdiIcons.shareVariantOutline,
        'onPress': () {} // Placeholder for sharing functionality
      },
      {
        'title': "Pokaż\nna mapie",
        'icon': MdiIcons.navigationVariantOutline,
        'onPress': () {} // Placeholder for map functionality
      },
      {
        'title': "Strona\nWWW",
        'icon': MdiIcons.web,
        'onPress': () {} // Placeholder for web link
      }
    ];

    // List of additional event information (e.g., performers or program)
    List<Map<String, dynamic>> eventInfoList = [
      {'title': 'Wykonawcy', 'list': widget.data.contractors},
      {'title': 'Program', 'list': widget.data.eventProgram}
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: false,
              leading: IconButton(
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: mainDarkBlue,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 20.0
                      : 80,
              vertical: 0),
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              // Event title
              Text(
                widget.data.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              // Event subtitle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  widget.data.secondTitle,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w400),
                ),
              ),
              // Date
              Text(
                '${DateFormat('dd.MM.yyyy').format(widget.data.date)} r. | g. ${DateFormat('HH:mm').format(widget.data.date)}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: mainDarkBlue), // Date and time of the event
              ),
              // Location
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 15),
                child: Text(
                  widget.data.location,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ),
              // Img
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                child: AspectRatio(
                  aspectRatio:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 16 / 12
                          : 16 / 9,
                  child: Image.network(
                    widget.data.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Display the image after loading
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null, // Show loading progress
                            color: Colors.blueAccent,
                            strokeWidth: 2.5,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(color: mainGrey),
                        child: Center(
                          child: Icon(
                            MdiIcons.wifiRemove, // Icon for failed image load
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...buttonsDataList.map((e) => Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  e['onPress']();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 218, 231,
                                        232), // Button background
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    e['icon'], // Button icon
                                    color: mainGreen,
                                    size: 40,
                                  ),
                                ),
                              ),
                              Text(
                                e['title'], // Button title
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 11,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              // Event description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    ...eventInfoList.map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${e['title']}:',
                            style: const TextStyle(fontSize: 14),
                          ),
                          ...e['list'].map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 4, bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: 4,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item, // List item
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.8),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              widget.data.isPaid
                                  ? MdiIcons.currencyUsd // Paid event icon
                                  : MdiIcons.currencyUsdOff, // Free event icon
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.data.isPaid
                                ? "Wydarzenie płatne" // Paid text
                                : "Wydarzenie bezpłatne", // Free text
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    // Social media
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            MdiIcons.facebook,
                            size: 40,
                            color: mainDarkBlue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            MdiIcons.instagram,
                            size: 40,
                            color: mainDarkBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
