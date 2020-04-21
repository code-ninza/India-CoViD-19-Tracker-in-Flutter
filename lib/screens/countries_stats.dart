import 'package:covid_india_tracker/services/get_countries.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

CountryStats _countryStats = new CountryStats();

class Countries extends StatefulWidget {
  _Countries createState() => _Countries();
}

class _Countries extends State<Countries> {
  Future<List<Country>> countriesStats;

  Future<List<Country>> getCountryStats() {
    return _countryStats.getCountryList();
  }

  @override
  void initState() {
    super.initState();
    countriesStats = getCountryStats();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xff212F3D),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Countries",
              style: GoogleFonts.montserrat(
                textStyle:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ),
            backgroundColor: Color(0xff17202a),
          ),
          body: FutureBuilder(
              future: countriesStats,
              builder: (BuildContext contex,
                  AsyncSnapshot<List<Country>> countrySnap) {
                if (countrySnap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        countriesStats = getCountryStats();
                      },
                    );
                  },
                ));
              })),
    );
  }
}
