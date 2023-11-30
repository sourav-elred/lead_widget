import 'package:flutter/material.dart';
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

  void onDoneButtonTap(LocationViewModel value) {
    if (value.initialGoogleLocation.isEmpty &&
        value.editingController.text.isEmpty) {
      Navigator.of(context).pop();
      return;
    } else {
      value.changeCurrentGoogleLocation();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarWidget(locationViewModel: _locationViewModel),
      body: Column(
        children: [
          const AddLocationTextField(),
          const SuggestionDropdownWidget(),
          Consumer<LocationViewModel>(builder: (context, value, child) {
            return ElRedButton(
              text: 'Done',
              onTap:
                  value.isButtonDisabled ? null : () => onDoneButtonTap(value),
            );
          }),
        ],
      ),
    );
  }
}
