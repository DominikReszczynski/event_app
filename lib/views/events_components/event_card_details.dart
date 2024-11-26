import 'package:event_app/global.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/views/events_components/popups/add_to_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCardDetails extends StatelessWidget {
  final Event data;
  const EventCardDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    void showCalendarPopup(BuildContext context, Event data) {
      showDialog(
        useSafeArea: false,
        context: context,
        builder: (BuildContext context) {
          return AddToCalendar(data: data);
        },
      );
    }

    List<Map<String, dynamic>> buttonsDataList = [
      {
        'title': "Dodaj do\nkalendarza",
        'icon': CupertinoIcons.calendar_badge_plus,
        'onPress': () {
          showCalendarPopup(context, data);
        }
      },
      {
        'title': "Udostępnij",
        'icon': MdiIcons.shareVariantOutline,
        'onPress': () {}
      },
      {
        'title': "Pokaż\nna mapie",
        'icon': MdiIcons.navigationOutline,
        'onPress': () {}
      },
      {'title': "Strona\nWWW", 'icon': MdiIcons.web, 'onPress': () {}}
    ];

    List<Map<String, dynamic>> eventInfoList = [
      {'title': 'Wykonawcy', 'list': data.contractors},
      {'title': 'Program', 'list': data.eventProgram}
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
              Text(
                data.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(data.secondTitle,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w400)),
              ),
              Text(
                '${DateFormat('dd.MM.yyyy').format(data.date)} r. | g. ${DateFormat('HH:mm').format(data.date)}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: mainDarkBlue),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 15),
                child: Text(
                  data.location,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                child: AspectRatio(
                  aspectRatio: MediaQuery.of(context).orientation ==
                          Orientation.portrait
                      ? 16 / 11
                      : 16 / 9, // Zmienione proporcje dla orientacji poziomej
                  child: Image.network(
                    data.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                                        color: mainGrey,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Icon(
                                      e['icon'],
                                      color: const Color.fromARGB(
                                          255, 218, 231, 232),
                                      size: 40,
                                    ),
                                  )),
                              Text(
                                e['title'],
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 11,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(children: [
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
                                        item,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ]),
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
                              data.isPaid
                                  ? MdiIcons.currencyUsd
                                  : MdiIcons.currencyUsdOff,
                              size: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            data.isPaid
                                ? "Wydazenie płatne"
                                : "Wydarzenie bezpłatne",
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(MdiIcons.facebook,
                                size: 40, color: mainDarkBlue)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(MdiIcons.instagram,
                                size: 40, color: mainDarkBlue))
                      ],
                    )
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
