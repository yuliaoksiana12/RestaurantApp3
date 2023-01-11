import 'package:flutter/material.dart';
import 'package:restapp/data/model/detail_restaurant.dart';
import 'package:restapp/data/api/api_service.dart';
import 'package:restapp/utility/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchAllDetail();
  }

  late DetailRestaurantResult _detailrestaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantResult get result => _detailrestaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllDetail() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailrestaurantResult = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
