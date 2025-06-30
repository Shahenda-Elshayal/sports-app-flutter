part of 'get_countries_cubit.dart';

@immutable
abstract class GetCountriesState {}

class GetCountriesInitial extends GetCountriesState {}

class GetCountriesLoading extends GetCountriesState {}

class GetCountriesSuccess extends GetCountriesState {
  final List<CountryResponseModel> countries;

  GetCountriesSuccess(this.countries);
}

class GetCountriesError extends GetCountriesState {
  final String message;

  GetCountriesError(this.message);
}
