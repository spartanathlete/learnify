import 'package:flutter/material.dart';
import 'package:learnify/utils/size_config.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.sizeConfig,
    required this.value,
    required this.onPress,
  });

  final SizeConfig sizeConfig;
  final String value;
  final void Function() onPress;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromARGB(255, 33, 194, 243), // Background color
        foregroundColor: Colors.white, // Text color
        elevation: 8, // Elevation (shadow)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Button border radius
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ), // Padding
      ),
      onPressed: widget.onPress,
      child: Text(widget.value),
      // icon: const Icon(Icons.login),
    );
  }
}
