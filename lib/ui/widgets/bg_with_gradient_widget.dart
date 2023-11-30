import 'package:flutter/material.dart';
import '../../constants/assets_constants.dart';

class BGWithGradient extends StatelessWidget {
  const BGWithGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(AssetsConstants.leadBackground),
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
