class CountryResponseModel {
  final String countryKey;
  final String countryName;
  final String countryLogo;

  CountryResponseModel({
    required this.countryKey,
    required this.countryName,
    required this.countryLogo,
  });

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) {
    return CountryResponseModel(
      countryKey: json['country_key'].toString(),
      countryName: json['country_name'] ?? '',
      countryLogo: json['country_logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_key': countryKey,
      'country_name': countryName,
      'country_logo': countryLogo,
    };
  }
}
