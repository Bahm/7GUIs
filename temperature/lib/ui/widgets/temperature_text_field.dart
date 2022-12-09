import 'package:flutter/material.dart';

class TemperatureTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final double width;

  const TemperatureTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.width = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
