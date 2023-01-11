import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restapp/data/model/list_restaurant.dart';
import 'package:restapp/data/model/detail_restaurant.dart';
import 'package:restapp/data/model/search_restaurant.dart';

class ApiService {
  Future<RestaurantResult> listRestaurant() async {
    final response =
        await http.get(Uri.parse("https://restaurant-api.dicoding.dev/list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<DetailRestaurantResult> detailRestaurant(String id) async {
    final response = await http
        .get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    final response = await http
        .get(Uri.parse("https://restaurant-api.dicoding.dev/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<DetailRestaurantResult> reviewRestaurant() async {
    final response =
        await http.get(Uri.parse("https://restaurant-api.dicoding.dev/review"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
