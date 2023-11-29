import 'package:flutter/material.dart';

class BGWithGradient extends StatelessWidget {
  const BGWithGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/lead_bg.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(.3),
              Colors.black.withOpacity(.6),
            ],
          ),
        ),
      ),
    );
  }
}
