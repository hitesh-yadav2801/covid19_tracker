import 'package:covid19_tracker/services/api_services.dart';
import 'package:covid19_tracker/view/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
              ),
              Flexible(
                child: FutureBuilder(
                  future: apiServices.getCountriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index){
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(height: 10, width: 90, color: Colors.white,),
                                    subtitle: Container(height: 10, width: 90, color: Colors.white,),
                                    leading: Container(height: 50, width: 50, color: Colors.white,),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            String countryName = snapshot.data![index]['country'];
                            var countryData = snapshot.data![index];
                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailsScreen(
                                        countryName: countryData['country'],
                                        image: countryData['countryInfo']['flag'],
                                        totalCases: countryData['cases'],
                                        totalRecovered: countryData['recovered'],
                                        totalDeaths: countryData['deaths'],
                                        active: countryData['active'],
                                        critical: countryData['critical'],
                                        todayRecovered: countryData['todayRecovered'],
                                        test: countryData['tests'],
                                      )));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country'].toString()),
                                      subtitle: Text('Cases: ${snapshot.data![index]['cases']}'),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag'],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else if (countryName.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailsScreen(
                                        countryName: countryData['country'],
                                        image: countryData['countryInfo']['flag'],
                                        totalCases: countryData['cases'],
                                        totalRecovered: countryData['recovered'],
                                        totalDeaths: countryData['deaths'],
                                        active: countryData['active'],
                                        critical: countryData['critical'],
                                        todayRecovered: countryData['todayRecovered'],
                                        test: countryData['tests'],
                                      )));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country'].toString()),
                                      subtitle: Text('Cases: ${snapshot.data![index]['cases']}'),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag'],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }
                      );
                    }
                  }
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
