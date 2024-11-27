import 'package:event_app/global.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/widgets/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddToCalendar extends StatefulWidget {
  final Event data; // Event data passed to the calendar form

  const AddToCalendar({super.key, required this.data});

  @override
  AddToCalendarState createState() => AddToCalendarState();
}

class AddToCalendarState extends State<AddToCalendar> {
  // Form state variables
  bool isAllDay = false; // Indicates if the event lasts all day
  String repeatOption = "Nigdy"; // Event repeat option
  String calendarOption = "Dom"; // Selected calendar
  String inviteesOption = "Brak"; // Selected invitees
  String alertOption = "W dniu wydarzenia (9.00)"; // First alert
  String secondAlertOption = "Brak"; // Second alert

  DateTime startDate = DateTime.now(); // Event start date
  DateTime endDate =
      DateTime.now().add(const Duration(days: 1)); // Event end date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // AppBar section with a back button
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
          // Main content section
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
                  // Event title
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
                  // Event location
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
                  const SizedBox(height: 20),
                  // All-day event toggle
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
                  const Divider(height: 20, thickness: 1, color: Colors.black),
                  // Start date picker
                  _buildDatePickerRow("Początek", startDate, (date) {
                    setState(() {
                      startDate = date;
                    });
                  }),
                  const Divider(height: 20, thickness: 1),
                  // End date picker
                  _buildDatePickerRow("Koniec", endDate, (date) {
                    setState(() {
                      endDate = date;
                    });
                  }),
                  const Divider(height: 20, thickness: 1),
                  // Repeat option dropdown
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
                  const Divider(height: 20, thickness: 1, color: Colors.black),
                  // Calendar selection dropdown
                  _buildDropdownRow(
                      "Kalendarz", calendarOption, ["Dom", "Praca"], (value) {
                    setState(() {
                      calendarOption = value!;
                    });
                  }, true),
                  const Divider(height: 20, thickness: 1, color: Colors.black),
                  // Invitees dropdown
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
                  const Divider(height: 20, thickness: 1),
                  // First alert dropdown
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
                  const Divider(height: 20, thickness: 1, color: Colors.black),
                  // Second alert dropdown
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
                  const Divider(height: 20, thickness: 1),
                  const SizedBox(height: 50),
                  // Buttons for cancel and add actions
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

  // Builds a date picker row for start/end date selection
  Widget _buildDatePickerRow(
      String label, DateTime date, ValueChanged<DateTime> onDatePicked) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date, // Current date as default
          firstDate: DateTime(2000), // Earliest selectable date
          lastDate: DateTime(2100), // Latest selectable date
        );
        if (picked != null) {
          onDatePicked(picked); // Updates the selected date
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label, // Label for the date picker
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  "${date.day}.${date.month}.${date.year}", // Display formatted date
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

  // Builds a dropdown row for selecting options
  Widget _buildDropdownRow(String label, String value, List<String> options,
      ValueChanged<String?> onChanged, bool isMain) {
    return Padding(
      padding: EdgeInsets.only(top: isMain ? 30.0 : 0, left: 20, right: 20),
      child: SizedBox(
        height: 22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label, // Label for the dropdown
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
                              option, // Dropdown item text
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
