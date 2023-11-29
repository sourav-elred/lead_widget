import 'package:flutter/material.dart';

class LocationChip extends StatelessWidget {
  const LocationChip({
    super.key,
    required this.text,
    this.width,
    required this.isSelected,
    this.onTap,
  });

  final String text;
  final double? width;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 30,
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0XFF147BFF) : null,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: isSelected ? const Color(0XFF147BFF) : Colors.white),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
