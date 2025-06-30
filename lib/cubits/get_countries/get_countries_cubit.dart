import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sports_app/data/models/countries_model.dart';
import 'package:sports_app/data/repos/countries_repo.dart';

part 'get_countries_state.dart';

class GetCountriesCubit extends Cubit<GetCountriesState> {
  final CountryRepo countryRepo;

  GetCountriesCubit(this.countryRepo) : super(GetCountriesInitial());

  Future<void> fetchCountries() async {
    emit(GetCountriesLoading());
    try {
      final countries = await countryRepo.getCountries();
      if (countries != null) {
        emit(GetCountriesSuccess(countries));
      } else {
        emit(GetCountriesError("No data found."));
      }
    } catch (e) {
      emit(GetCountriesError("Failed to load countries."));
    }
  }
}
