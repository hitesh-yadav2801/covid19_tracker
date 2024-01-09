import 'dart:convert';

import 'package:covid19_tracker/models/world_stats_model.dart';
import 'package:covid19_tracker/services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class ApiServices {

  Future<WorldStatsModel> getWorldStats() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApiUrl));

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        return WorldStatsModel.fromJson(data);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception('Error occurred while fetching world stats');
    }
  }

  Future<List<dynamic>> getCountriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesListUrl));

    try {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        return data;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception('Error occurred while fetching world stats');
    }
  }
}