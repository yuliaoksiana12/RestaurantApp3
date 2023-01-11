import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapp/data/database/preferences_helper.dart';
import 'package:restapp/provider/preferences_provider.dart';
import 'package:restapp/provider/scheduling_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance()),
          ),
        )
      ],
      child: Consumer2<PreferencesProvider, SchedulingProvider>(
        builder: (context, value, value2, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Settings"),
            ),
            body: ListTile(
              title: const Text("Restaurant Notification"),
              trailing: Switch.adaptive(
                  value: value.isDailyRestaurantNotificationActive,
                  onChanged: (value3) async {
                    value2.scheduledRestaurant(value3);
                    value.enableDailyRestaurantNotification(value3);
                  }),
            ),
          );
        },
      ),
    );
  }
}
