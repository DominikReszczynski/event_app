import 'package:event_app/global.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value; // Current value of the slider
  final double min; // Minimum value of the slider
  final double max; // Maximum value of the slider
  final ValueChanged<double> onChanged; // Callback for value changes

  const CustomSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  CustomSliderState createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider> {
  late double sliderWidth;
  late double thumbPosition;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        sliderWidth = constraints.maxWidth;

        // Calculate the position of the thumb based on the current value
        thumbPosition = (widget.value - widget.min) /
            (widget.max - widget.min) *
            sliderWidth;

        // Offset correction ensures the label stays aligned with the thumb
        double correction =
            10 - (widget.value - widget.min) / (widget.max - widget.min) * 20;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 80),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "0km", // Left label for the slider
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "100km", // Right label for the slider
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Slider component
                      SliderTheme(
                        data: SliderThemeData(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 10),
                          overlayShape: SliderComponentShape.noOverlay,
                        ),
                        child: Slider(
                          value: widget.value,
                          min: widget.min,
                          max: widget.max,
                          divisions: (widget.max - widget.min).toInt(),
                          activeColor: mainDarkBlue,
                          inactiveColor: Colors.grey[300],
                          onChanged: widget.onChanged,
                        ),
                      ),
                      // Label positioned dynamically with the thumb
                      Positioned(
                        left: thumbPosition -
                            40 +
                            correction, // Dynamic position for the label
                        top: 30, // Offset to position it below the slider
                        child: DistanceLabel(
                            label:
                                widget.value.toStringAsFixed(0)), // Label text
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}

// Widget displaying the distance label with a custom background and arrow pointer
class DistanceLabel extends StatelessWidget {
  final String label; // Text of the label

  const DistanceLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom arrow pointing to the slider thumb
        CustomPaint(
          size: const Size(10, 5),
          painter: ArrowPainter(),
        ),
        // Label container with styling
        Container(
          width: 80,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: mainGreen,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "$label km",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter for the arrow pointing to the slider thumb
class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = mainGreen;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Top center of the arrow
      ..lineTo(size.width, size.height) // Bottom right of the arrow
      ..lineTo(0, size.height) // Bottom left of the arrow
      ..close(); // Closes the path

    canvas.drawPath(path, paint); // Draws the arrow
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint as the arrow doesn't change dynamically
  }
}
