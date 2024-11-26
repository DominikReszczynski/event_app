import 'package:event_app/global.dart';
import 'package:flutter/material.dart';

// CustomSwitch is a reusable custom switch widget.
class CustomSwitch extends StatefulWidget {
  final bool value; // Current state of the switch
  final ValueChanged<bool> onChanged; // Callback when the switch is toggled

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 52.0,
        height: 30.0,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: widget.value ? mainGreen : Colors.grey,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Display the "check" icon when the switch is ON
            if (widget.value)
              const Positioned(
                right: 8,
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                ),
              ),

            // Display the "close" icon when the switch is OFF
            if (!widget.value)
              const Positioned(
                left: 8,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),

            // Circular thumb with dynamic alignment and icon
            AnimatedAlign(
              alignment:
                  widget.value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 24.0,
                height: 24.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    widget.value ? Icons.check : Icons.close,
                    size: 16.0,
                    color: widget.value ? mainGreen : Colors.grey, // Icon color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
