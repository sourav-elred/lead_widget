class Location {
  Location(
    this.city,
    this.state,
    this.latitude,
    this.longitute,
    this.country,
    this.fullAddress,
  );

  final String city;
  final String state;
  final double latitude;
  final double longitute;
  final String country;
  final String fullAddress;

  @override
  String toString() {
    return 'Location(city: $city, state: $state, latitude: $latitude, longitute: $longitute, country: $country, fullAddress: $fullAddress)';
  }
}
