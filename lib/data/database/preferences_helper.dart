import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyRestaurantNotification = 'DAILY_RESTAURANT_NOTIFICATION';

  Future<bool> get isDailyRestaurantNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurantNotification) ?? false;
  }

  void setDailyRestaurantNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurantNotification, value);
  }
}
