import 'package:covid19_tracker/view/world_statistics.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String countryName, image;
  int totalCases, totalDeaths, active, critical, todayRecovered, test, totalRecovered;
  DetailsScreen({
    super.key,
    required this.countryName,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
    required this.totalRecovered
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.countryName
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                      CustomRowWidget(title: 'Total Cases', value: widget.totalCases.toString()),
                      CustomRowWidget(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                      CustomRowWidget(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                      CustomRowWidget(title: 'Active', value: widget.active.toString()),
                      CustomRowWidget(title: 'Critical', value: widget.critical.toString()),
                      CustomRowWidget(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      CustomRowWidget(title: 'Tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          )
        ],
      ),
    );
  }
}
