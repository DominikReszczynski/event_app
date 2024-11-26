import 'package:event_app/global.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double sliderWidth;
  late double thumbPosition;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        sliderWidth = constraints.maxWidth;

        // Obliczanie pozycji "thumb" na podstawie wartości
        thumbPosition = (widget.value - widget.min) /
            (widget.max - widget.min) *
            (sliderWidth + 0);

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
                          "0km",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "100km",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
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
                      Positioned(
                        left:
                            thumbPosition - 40, // -40 = szerokość kontenera / 2
                        top: 30,
                        child: DistanceLabel(
                            label: widget.value.toStringAsFixed(0)),
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

class DistanceLabel extends StatelessWidget {
  final String label;

  const DistanceLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          size: const Size(10, 5),
          painter: ArrowPainter(),
        ),
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

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = mainGreen;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
