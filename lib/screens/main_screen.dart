import 'package:flutter/material.dart';
import 'package:lead_widget/viewModel/location_view_model.dart';
import 'package:lead_widget/widgets/add_location_field_widget.dart';
import 'package:lead_widget/widgets/bg_with_gradient_widget.dart';
import 'package:lead_widget/widgets/location_chip_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final LocationViewModel _locationViewModel;

  @override
  void initState() {
    super.initState();
    _locationViewModel = context.read<LocationViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BGWithGradient(),
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Consumer<LocationViewModel>(
                        builder: (context, value, child) {
                      return Row(
                        children: [
                          LocationChip(
                            text: 'at Mumbai',
                            isSelected: value.currentlySelectedLocation ==
                                LocationType.currentLocation,
                            onTap: () {
                              value.toggleSelectedLocation(
                                LocationType.currentLocation,
                              );
                            },
                          ),
                          const SizedBox(width: 12),
                          LocationChip(
                            text: 'Remote',
                            width: 85,
                            isSelected: value.currentlySelectedLocation ==
                                LocationType.remoteLocation,
                            onTap: () {
                              value.toggleSelectedLocation(
                                LocationType.remoteLocation,
                              );
                            },
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 22),
                    const Text(
                      'Search other locations',
                      style: TextStyle(
                        color: Color(0xFFEBEBEB),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFFEAECF2),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'at',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(child: AddLocationField()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
