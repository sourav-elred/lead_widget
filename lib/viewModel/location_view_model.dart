import 'dart:convert';

import 'package:flutter/material.dart';
import '../constants/api_service_constants.dart';
import '../services/web_service.dart';

enum LocationType { currentLocation, remoteLocation, googleLocation }

class LocationViewModel extends ChangeNotifier {
  late TextEditingController editingController;
  LocationType currentlySelectedLocation = LocationType.currentLocation;
  String initialGoogleLocation = '';
  String? currentGoogleLocation;
  bool isButtonDisabled = false;
  bool suggestionSelected = false;
  bool shouldShowClearIcon = false;

  void initialize(TextEditingController controller) {
    editingController = controller;
    editingController.text = currentGoogleLocation ?? '';
    initialGoogleLocation = currentGoogleLocation ?? '';

    isButtonDisabled = false;
    suggestionSelected = false;
    editingController.addListener(doneButtonListner);
  }

  void toggleSelectedLocation(LocationType locationType) {
    currentlySelectedLocation = locationType;
    currentGoogleLocation = null;
    isButtonDisabled = false;
    suggestionSelected = false;
    notifyListeners();
  }

  List<dynamic> placesList = [];
  void getPlacesSuggestions() async {
    Uri uri = Uri.https(
      ApiServiceConstants.authority,
      ApiServiceConstants.unencodedPath,
      {
        "input": editingController.text,
        "key": ApiServiceConstants.apiKey,
      },
    );

    String? response = await WebService.fetchUrl(uri);
    if (response != null) {
      placesList = jsonDecode(response)['predictions'];
      notifyListeners();
    }
  }

  void doneButtonListner() {
    if (editingController.text.isNotEmpty) {
      isButtonDisabled = true;
      shouldShowClearIcon = true;
      notifyListeners();
    }
    if (editingController.text.isEmpty) {
      isButtonDisabled = false;
      shouldShowClearIcon = false;
      placesList.clear();
      notifyListeners();
    }
    getPlacesSuggestions();
  }

  void onCrossIconTap() {
    initialGoogleLocation = '';
    currentGoogleLocation = null;
    currentlySelectedLocation = LocationType.currentLocation;
    notifyListeners();
  }

  void onLocationSuggestionTap(String locationSuggestion) {
    editingController.text = locationSuggestion;
    isButtonDisabled = false;
    placesList.clear();
    suggestionSelected = true;
    notifyListeners();
  }

  void onClearIconTapInAddLocation() {
    editingController.clear();
    placesList.clear();
    notifyListeners();
  }

  void changeCurrentGoogleLocation() async {
    if (editingController.text.isEmpty) {
      currentGoogleLocation = null;
      currentlySelectedLocation = LocationType.currentLocation;
    } else {
      currentGoogleLocation = editingController.text;
      currentlySelectedLocation = LocationType.googleLocation;
    }
    placesList.clear();
    isButtonDisabled = false;
    notifyListeners();
  }
}
