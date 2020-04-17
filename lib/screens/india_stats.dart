import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:covid_india_tracker/models/data_api.dart";
import "package:covid_india_tracker/services/data_fetcher.dart";
import "dart:async";

CovidIndiaStats _covidIndiaStats = new CovidIndiaStats();

class IndiaStats extends StatefulWidget {
  _IndiaStats createState() => _IndiaStats();
}

class _IndiaStats extends State<IndiaStats> {
  Future<CovidIndia> asIndiaStats;

  Future<CovidIndia> getIndiaStats() {
    return _covidIndiaStats.getStats();
  }

  @override
  void initState() {
    super.initState();
    asIndiaStats = getIndiaStats();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asIndiaStats,
      builder: (BuildContext context, AsyncSnapshot<CovidIndia> dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        int confirmedCases =
            int.parse(dataSnapshot.data.statewise[0].confirmed);
        int confirmedCasesDelta =
            int.parse(dataSnapshot.data.statewise[0].deltaconfirmed);
        int activeCases = int.parse(dataSnapshot.data.statewise[0].active);
        int recoveredCases =
            int.parse(dataSnapshot.data.statewise[0].recovered);
        int recoveredCasesDelta =
            int.parse(dataSnapshot.data.statewise[0].deltarecovered);
        int deceasedCases = int.parse(dataSnapshot.data.statewise[0].deaths);
        int deceasedCasesDelta =
            int.parse(dataSnapshot.data.statewise[0].deltadeaths);

        return ListView(
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
                height: 70,
                alignment: Alignment(0.001, 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "India CoViD-19 Stats",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 30),
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          asIndiaStats = getIndiaStats();
                        });
                      },
                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Confirmed",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              fontSize: 18)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "+$confirmedCasesDelta",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    ),
                    Text(
                      "$confirmedCases",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w300,
                          fontSize: 17),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Active",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 18)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      " ",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    ),
                    Text(
                      "$activeCases",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w300,
                          fontSize: 17),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Recovered",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w300,
                              fontSize: 18)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "+$recoveredCasesDelta",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    ),
                    Text(
                      "$recoveredCases",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w300,
                          fontSize: 17),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Deceased",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "+$deceasedCasesDelta",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    ),
                    Text(
                      "$deceasedCases",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 17),
                    )
                  ],
                )
              ],
            ),
            Container(
              height: 30.0,
              alignment: Alignment(0.005, 0.2),
              child: Text(
                "Last updated at : ${dataSnapshot.data.statewise[0].lastupdatedtime}",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
