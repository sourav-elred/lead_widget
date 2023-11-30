import 'package:flutter/material.dart';
import '../../viewModel/location_view_model.dart';
import 'confirmation_popup.dart';

class CustomAppbarWidget extends StatelessWidget with PreferredSizeWidget {
  const CustomAppbarWidget({
    super.key,
    required LocationViewModel locationViewModel,
  }) : _locationViewModel = locationViewModel;

  final LocationViewModel _locationViewModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          if ((_locationViewModel.currentGoogleLocation == null &&
                  _locationViewModel.editingController.text.isNotEmpty) &&
              _locationViewModel.currentlySelectedSuggestion != null) {
            buildConfirmationPopup(context);
            return;
          }
          if (_locationViewModel.initialGoogleLocation != null &&
              _locationViewModel.editingController.text.isEmpty) {
            buildConfirmationPopup(context);
            return;
          } else {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          }
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(color: Colors.grey, height: .2),
      ),
      backgroundColor: Colors.white,
      titleSpacing: 0,
      title: const Text(
        'Add Location',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(0, 50);
}
