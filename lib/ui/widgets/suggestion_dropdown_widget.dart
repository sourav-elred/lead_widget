import 'dart:developer';

import 'package:flutter/material.dart';
import '../../viewModel/location_view_model.dart';
import 'package:provider/provider.dart';

class SuggestionDropdownWidget extends StatelessWidget {
  const SuggestionDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationViewModel>(
      builder: (context, value, child) {
        log('value.shouldShowNoResultFound: ${value.shouldShowNoResultFound}');
        return Expanded(
          child: ListView.builder(
            itemCount: value.placesList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                value.onLocationSuggestionTap(value.placesList[index]);
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: ListTile(
                title: Text(
                  value.placesList[index].description,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
