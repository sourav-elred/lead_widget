import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lead_widget/models/location_model.dart';
import 'package:lead_widget/models/suggestion_model.dart';
import '../constants/api_service_constants.dart';
import '../services/web_service.dart';

enum LocationType { currentLocation, remoteLocation, googleLocation }

class LocationViewModel extends ChangeNotifier {
  late TextEditingController editingController;
  LocationType currentlySelectedLocation = LocationType.currentLocation;
  late Location? initialGoogleLocation;
  Location? currentGoogleLocation;
  bool isButtonDisabled = false;
  Suggestion? currentlySelectedSuggestion;
  bool shouldShowClearIcon = false;
  bool shouldShowNoResultFound = false;

  void initialize(TextEditingController controller) {
    editingController = controller;
    editingController.text = currentGoogleLocation?.fullAddress ?? '';
    initialGoogleLocation = currentGoogleLocation;
    isButtonDisabled = false;
    currentlySelectedSuggestion = null;
    editingController.addListener(doneButtonListner);
  }

  void toggleSelectedLocation(LocationType locationType) {
    currentlySelectedLocation = locationType;
    currentGoogleLocation = null;
    isButtonDisabled = false;
    currentlySelectedSuggestion = null;
    notifyListeners();
  }

  List<Suggestion> placesList = [];
  void getPlacesSuggestions() async {
    Uri uri = Uri.https(
      ApiServiceConstants.authority,
      ApiServiceConstants.placesPredictionPath,
      {
        "input": editingController.text,
        "key": ApiServiceConstants.apiKey,
      },
    );

    dynamic response = await WebService.fetchUrl(uri);
    if (response != null) {
      placesList = jsonDecode(response)['predictions']
          .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
          .toList();
      log('placesList: $placesList');
      if (placesList.isEmpty) {
        shouldShowNoResultFound = true;
      } else {
        shouldShowNoResultFound = false;
      }

      log('shouldShowNoResultFound == > $shouldShowNoResultFound');

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
    if (currentlySelectedSuggestion != null) {
      isButtonDisabled = false;
      shouldShowClearIcon = true;
      notifyListeners();
    }
  }

  void onCrossIconTap() {
    initialGoogleLocation = null;
    currentGoogleLocation = null;
    currentlySelectedLocation = LocationType.currentLocation;
    notifyListeners();
  }

  void onLocationSuggestionTap(Suggestion locationSuggestion) {
    editingController.text = locationSuggestion.description;
    isButtonDisabled = false;
    placesList.clear();
    currentlySelectedSuggestion = locationSuggestion;
    notifyListeners();
  }

  void onClearIconTapInAddLocation() {
    editingController.clear();
    placesList.clear();
    currentlySelectedSuggestion = null;
    shouldShowNoResultFound = false;
    notifyListeners();
  }

  void changeCurrentGoogleLocation() async {
    if (currentlySelectedSuggestion != null) {
      final locationData =
          await fetchLocationData(currentlySelectedSuggestion!.placeId);
      currentGoogleLocation = locationData;
      log('location ==> ${locationData.toString()}');
      currentlySelectedLocation = LocationType.googleLocation;
    } else {
      currentGoogleLocation = null;
      currentlySelectedLocation = LocationType.currentLocation;
    }
    placesList.clear();
    isButtonDisabled = false;
    notifyListeners();
  }

  Future<Location?> fetchLocationData(String placeId) async {
    try {
      Uri uri = Uri.https(
        ApiServiceConstants.authority,
        ApiServiceConstants.placesDetailsPath,
        {
          "place_id": placeId,
          "key": ApiServiceConstants.apiKey,
        },
      );

      dynamic response = await WebService.fetchUrl(uri);
      if (response != null) {
        final data = jsonDecode(response)['result'];

        return Location(
          data['address_components'][0]['long_name'],
          data['address_components'][3]['long_name'],
          data['geometry']['location']['lat'],
          data['geometry']['location']['lng'],
          data['address_components'][4]['long_name'],
          data['formatted_address'],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
