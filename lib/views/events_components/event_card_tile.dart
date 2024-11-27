import 'package:event_app/global.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCardTile extends StatefulWidget {
  final Event data; // Event data to be displayed in the card
  const EventCardTile({super.key, required this.data});

  @override
  State<EventCardTile> createState() => _EventCardTileState();
}

class _EventCardTileState extends State<EventCardTile> {
  bool isFavorite = false; // Tracks if the event is marked as a favorite

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Image.network(
                widget.data.imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Display the image when fully loaded
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null, // Show progress if available
                        color: Colors.blueAccent,
                        strokeWidth: 2.5,
                      ),
                    );
                  }
                },
                // Icon for loading error
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(color: mainGrey),
                    child: Center(
                      child: Icon(
                        MdiIcons.wifiRemove,
                        size: 50,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 5.0),
            // Title, location, date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        widget.data.title,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.data.abbreviatedLocalization,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(widget.data.date),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 5, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Favorite Icon
                  InkWell(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 239, 239, 239),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? mainGreen : Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: 3.90,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 239, 239, 239),
                      size: 20,
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
