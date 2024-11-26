import 'package:event_app/global.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/widgets/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddToCalendar extends StatefulWidget {
  final Event data;

  AddToCalendar({required this.data});

  @override
  _AddToCalendarState createState() => _AddToCalendarState();
}

class _AddToCalendarState extends State<AddToCalendar> {
  bool isAllDay = false;
  String repeatOption = "Nigdy";
  String calendarOption = "Dom";
  String inviteesOption = "Brak";
  String alertOption = "W dniu wydarzenia (9.00)";
  String secondAlertOption = "Brak";

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Kalendarz imprez",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            floating: true,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 1,
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
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 20.0
                      : 80,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.data.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Divider(height: 30, thickness: 2),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    child: Text(
                      widget.data.location,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Wydarzenie całodniowe",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        CustomSwitch(
                          value: isAllDay,
                          onChanged: (bool value) {
                            setState(() {
                              isAllDay = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  _buildDatePickerRow("Początek", startDate, (date) {
                    setState(() {
                      startDate = date;
                    });
                  }),
                  const Divider(height: 30, thickness: 1),
                  _buildDatePickerRow("Koniec", endDate, (date) {
                    setState(() {
                      endDate = date;
                    });
                  }),
                  const Divider(height: 30, thickness: 1),
                  _buildDropdownRow("Powtarzaj", repeatOption, [
                    "Nigdy",
                    "Codziennie",
                    "Co tydzień",
                    "Co miesiąc"
                  ], (value) {
                    setState(() {
                      repeatOption = value!;
                    });
                  }, true),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  _buildDropdownRow(
                      "Kalendarz", calendarOption, ["Dom", "Praca"], (value) {
                    setState(() {
                      calendarOption = value!;
                    });
                  }, true),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  _buildDropdownRow(
                    "Zaproszeni",
                    inviteesOption,
                    ["Brak", "Jan Kowalski"],
                    (value) {
                      setState(() {
                        inviteesOption = value!;
                      });
                    },
                    false,
                  ),
                  const Divider(height: 30, thickness: 1),
                  _buildDropdownRow(
                    "Alert",
                    alertOption,
                    ["W dniu wydarzenia (9.00)", "1 dzień wcześniej"],
                    (value) {
                      setState(() {
                        alertOption = value!;
                      });
                    },
                    true,
                  ),
                  const Divider(height: 30, thickness: 1, color: Colors.black),
                  _buildDropdownRow(
                    "2. alert",
                    secondAlertOption,
                    ["Brak", "10 minut przed"],
                    (value) {
                      setState(() {
                        secondAlertOption = value!;
                      });
                    },
                    false,
                  ),
                  const Divider(height: 30, thickness: 1),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Anuluj",
                          style: TextStyle(color: mainDarkBlue, fontSize: 16),
                        ),
                      ),
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
                          "Dodaj",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerRow(
      String label, DateTime date, ValueChanged<DateTime> onDatePicked) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          onDatePicked(picked);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  "${date.day}.${date.month}.${date.year}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  MdiIcons.unfoldMoreHorizontal,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownRow(String label, String value, List<String> options,
      ValueChanged<String?> onChanged, bool isMain) {
    return Padding(
      padding: EdgeInsets.only(top: isMain ? 30.0 : 0, left: 20, right: 20),
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isMain ? FontWeight.w900 : FontWeight.w300,
              ),
            ),
            DropdownButton<String>(
              dropdownColor: Colors.white,
              alignment: AlignmentDirectional.topEnd,
              value: value,
              underline: Container(),
              icon: Icon(
                MdiIcons.unfoldMoreHorizontal,
                color: Colors.grey,
              ),
              items: options
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              option,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
