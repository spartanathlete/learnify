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
    return GestureDetector(
      onTap: () => widget.onPress,
      child: Container(
        alignment: Alignment.center,
        height: widget.sizeConfig.pixSize.height / 13,
        width: widget.sizeConfig.pixSize.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: const Color(0xFF21899C),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Text(
          widget.value,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
