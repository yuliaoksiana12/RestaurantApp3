import 'package:flutter/cupertino.dart';
import 'package:restapp/data/api/api_service.dart';
import 'package:restapp/data/model/search_restaurant.dart';
import 'package:restapp/utility/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    _state = ResultState.noData;
  }

  late RestaurantSearch _restaurantSearch;
  late ResultState _state;
  String _message = '';
  String _searchquerry = '';

  String get message => _message;

  RestaurantSearch get result => _restaurantSearch;

  ResultState get state => _state;

  Future<dynamic> _fetchAllSearchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchrestaurant = await apiService.searchRestaurant(_searchquerry);
      if (searchrestaurant.error == true && searchrestaurant.founded == 0) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = searchrestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }

  void changeSearchString(String searchString) {
    _searchquerry = searchString;
    notifyListeners();
    _fetchAllSearchRestaurant();
  }
}
