import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/assets_constants.dart';
import '../screens/add_location_screen.dart';
import '../../viewModel/location_view_model.dart';
import 'package:provider/provider.dart';

class AddLocationField extends StatelessWidget {
  const AddLocationField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationViewModel>(
      builder: (context, value, child) => Container(
        height: 40,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(59),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              if (value.currentlySelectedLocation !=
                  LocationType.googleLocation)
                SvgPicture.asset(AssetsConstants.searchIcon),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddLocationScreen(),
                    ));
                  },
                  child: Text(
                    value.currentGoogleLocation ?? 'Add location',
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (value.currentGoogleLocation != null)
                InkWell(
                  onTap: value.onCrossIconTap,
                  child: const Icon(Icons.cancel, color: Colors.white),
                )
            ],
          ),
        ),
      ),
    );
  }
}
