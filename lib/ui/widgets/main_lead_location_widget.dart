import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../viewModel/location_view_model.dart';
import 'add_location_field_widget.dart';
import 'location_chip_widget.dart';
import 'rounded_bordered_widget.dart';
import 'package:provider/provider.dart';

class MainLeadLocationWidget extends StatelessWidget {
  const MainLeadLocationWidget({super.key});

  static Future<void> openMap(double lat, double lng) async {
    final uri =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
                Consumer<LocationViewModel>(builder: (context, value, child) {
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
                  children: const [
                    RoundedBorderedWidget(text: 'at'),
                    SizedBox(width: 12),
                    Expanded(child: AddLocationField()),
                  ],
                ),
              ],
            ),
          ),
        ),
        Consumer<LocationViewModel>(builder: (context, value, child) {
          return Center(
            child: GestureDetector(
              onTap: () => openMap(value.currentGoogleLocation?.latitude ?? 0,
                  value.currentGoogleLocation?.longitute ?? 0),
              child: Text(
                value.currentGoogleLocation?.fullAddress ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }),
      ],
    );
  }
}
