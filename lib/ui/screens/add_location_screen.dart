import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lead_widget/ui/screens/main_screen.dart';
import '../../viewModel/location_view_model.dart';
import '../widgets/add_location_textfield.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/elred_button.dart';
import '../widgets/suggestion_dropdown_widget.dart';
import 'package:provider/provider.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  late final LocationViewModel _locationViewModel;

  @override
  void initState() {
    super.initState();
    _locationViewModel = context.read<LocationViewModel>();
    _locationViewModel.initialize(TextEditingController());
  }

  @override
  void dispose() {
    _locationViewModel.editingController.dispose();
    _locationViewModel.placesList.clear();
    super.dispose();
  }

  void onDoneButtonTap(LocationViewModel value, BuildContext context) {
    if (value.initialGoogleLocation == null &&
        value.editingController.text.isEmpty) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();

      return;
    } else {
      value.changeCurrentGoogleLocation();
      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationVM = context.watch<LocationViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarWidget(locationViewModel: _locationViewModel),
      body: Column(
        children: [
          const AddLocationTextField(),
          if (!locationVM.shouldShowNoResultFound) ...[
            const SuggestionDropdownWidget(),
          ] else ...[
            const Text('No Result found'),
            const Spacer(),
          ],
          Consumer<LocationViewModel>(builder: (context, value, child) {
            return ElRedButton(
              text: 'Done',
              onTap: value.isButtonDisabled
                  ? null
                  : () => onDoneButtonTap(value, context),
            );
          }),
        ],
      ),
    );
  }
}
