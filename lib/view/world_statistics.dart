import 'dart:async';

import 'package:covid19_tracker/models/world_stats_model.dart';
import 'package:covid19_tracker/services/api_services.dart';
import 'package:covid19_tracker/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatisticsScreen extends StatefulWidget {
  const WorldStatisticsScreen({super.key});

  @override
  State<WorldStatisticsScreen> createState() => _WorldStatisticsScreenState();
}

class _WorldStatisticsScreenState extends State<WorldStatisticsScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () {}
    );
  }

  final colorList = <Color>[
    const Color (0xff4285F4),
    const Color (0xff1aa260),
    const Color (0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              FutureBuilder(
                future: apiServices.getWorldStats(),
                builder: (context, AsyncSnapshot<WorldStatsModel>snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      )
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total' : double.parse(snapshot.data!.cases!.toString()),
                            'Recovered' : double.parse(snapshot.data!.recovered!.toString()),
                            'Deaths' : double.parse(snapshot.data!.deaths!.toString())
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                CustomRowWidget(title: 'Total', value: snapshot.data!.cases.toString()),
                                CustomRowWidget(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                CustomRowWidget(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                CustomRowWidget(title: 'Active', value: snapshot.data!.active.toString()),
                                CustomRowWidget(title: 'Critical', value: snapshot.data!.critical.toString()),
                                CustomRowWidget(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                CustomRowWidget(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CountriesListScreen())
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(
                              child: Text(
                                  'Track Countries'
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRowWidget extends StatelessWidget {
  String title, value;
  CustomRowWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider(),
        ],
      ),
    );
  }
}

