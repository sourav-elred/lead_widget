import 'package:flutter/material.dart';

import '../widgets/bg_with_gradient_widget.dart';
import '../widgets/main_lead_location_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          BGWithGradient(),
          Center(child: MainLeadLocationWidget()),
        ],
      ),
    );
  }
}
