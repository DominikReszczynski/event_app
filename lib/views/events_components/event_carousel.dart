import 'package:event_app/global.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCarousel extends StatelessWidget {
  final List<String>
      images; // List of image URLs to be displayed in the carousel
  const EventCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Return the image once fully loaded
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                            color: Colors.blueAccent,
                            strokeWidth: 2.5,
                          ),
                        );
                      }
                    },
                    // Placeholder for errors when loading the image
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        width: 300,
                        decoration: const BoxDecoration(color: mainGrey),
                        child: Center(
                          child: Icon(MdiIcons.wifiRemove,
                              size: 50, color: Colors.red),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
