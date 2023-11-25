import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.size,
    required this.controller,
    required this.hint,
    required this.textInputType,
    required this.icon,
    required this.validator,
  });

  final Size size;
  final TextEditingController controller;
  final String hint;
  final TextInputType textInputType;
  final IconData icon;
  final String? Function(String?) validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: widget.size.height / 12,
        child: TextFormField(
          obscureText: (widget.textInputType == TextInputType.visiblePassword)
              ? true
              : false,
          controller: widget.controller,
          style: const TextStyle(
            fontSize: 18.0,
            color: Color(0xFF151624),
          ),
          maxLines: 1,
          keyboardType: widget.textInputType,
          cursorColor: const Color(0xFF151624),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: const Color(0xFF151624).withOpacity(0.5),
            ),
            filled: true,
            fillColor: widget.controller.text.isEmpty
                ? const Color.fromRGBO(248, 247, 251, 1)
                : Colors.transparent,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: widget.controller.text.isEmpty
                      ? Colors.transparent
                      : const Color.fromRGBO(44, 185, 176, 1),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(44, 185, 176, 1),
                )),
            prefixIcon: Icon(
              widget.icon,
              color: widget.controller.text.isEmpty
                  ? const Color(0xFF151624).withOpacity(0.5)
                  : const Color.fromRGBO(44, 185, 176, 1),
              size: 16,
            ),
            // suffix: Container(
            //   alignment: Alignment.center,
            //   width: 24.0,
            //   height: 24.0,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(100.0),
            //     color: const Color.fromRGBO(44, 185, 176, 1),
            //   ),
            //   child: controller.text.isEmpty
            //       ? const Center()
            //       : const Icon(
            //           Icons.check,
            //           color: Colors.white,
            //           size: 13,
            //         ),
            // ),
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
