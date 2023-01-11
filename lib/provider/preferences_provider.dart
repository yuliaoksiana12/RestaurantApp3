import 'package:flutter/cupertino.dart';
import 'package:restapp/data/database/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  bool _isDailyRestaurantNotificationActive = false;
  bool get isDailyRestaurantNotificationActive =>
      _isDailyRestaurantNotificationActive;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantNotificationPreferences();
  }

  void _getDailyRestaurantNotificationPreferences() async {
    _isDailyRestaurantNotificationActive =
        await preferencesHelper.isDailyRestaurantNotificationActive;
    notifyListeners();
  }

  void enableDailyRestaurantNotification(bool value) {
    preferencesHelper.setDailyRestaurantNotification(value);
    _getDailyRestaurantNotificationPreferences();
  }
}
