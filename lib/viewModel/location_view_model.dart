import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lead_widget/services/web_service.dart';

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
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": editingController.text,
        "key": "AIzaSyAROpxxRmrXiah-FooutbY7rmY1m8HnucQ",
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
    // currentlySelectedLocation = LocationType.currentLocation;
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
