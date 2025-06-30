import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_app/cubits/get_countries/get_countries_cubit.dart';
import 'package:sports_app/data/google_sign_in_service.dart';
// import 'package:sports_app/data/models/countries_model.dart';
import 'package:sports_app/data/repos/countries_repo.dart';
import 'package:sports_app/screens/leagues_screen.dart';

import 'login_screen.dart';
import '../widgets/app_drawer.dart';

class CountriesScreen extends StatelessWidget {
  final User user;

  const CountriesScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCountriesCubit(CountryRepo())..fetchCountries(),
      child: Scaffold(
        backgroundColor: const Color(0xFF211C12),
        appBar: AppBar(
          backgroundColor: const Color(0xFF211C12),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Countries',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        drawer: AppDrawer(
          user: user,
          onLogout: () async {
            await GoogleSignInService.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          },
        ),
        body: BlocBuilder<GetCountriesCubit, GetCountriesState>(
          builder: (context, state) {
            if (state is GetCountriesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFF5C754)),
              );
            } else if (state is GetCountriesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (state is GetCountriesSuccess) {
              final countries = state.countries;

              return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return ListTile(
                    leading: Image.network(
                      'https://cors-anywhere.herokuapp.com/${country.countryLogo}',
                      width: 40,
                      height: 40,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.flag, color: Colors.white),
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => LeaguesScreen(
                                countryName: country.countryName,
                                user: user,
                              ),
                        ),
                      );
                    },

                    title: Text(
                      country.countryName,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                },
              );
            }

            // in case of initial state
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
