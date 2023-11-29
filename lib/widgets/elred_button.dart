import 'package:flutter/material.dart';
import 'package:lead_widget/viewModel/location_view_model.dart';
import 'package:provider/provider.dart';

class ElRedButton extends StatelessWidget {
  const ElRedButton({
    super.key,
    required this.text,
    this.onTap,
    this.invert = false,
  });

  final String text;
  final VoidCallback? onTap;
  final bool invert;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        height: 48,
        decoration: ShapeDecoration(
          color: onTap == null
              ? const Color(0xFFFDEAEB)
              : invert
                  ? Colors.white
                  : const Color(0xFFE72D38),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: invert
                    ? Colors.black
                    : onTap == null
                        ? const Color(0xFFFDEAEB)
                        : const Color(0xFFE72D38)),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: invert ? Colors.black : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
