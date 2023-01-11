import 'package:provider/provider.dart';
import 'package:restapp/data/api/api_service.dart';
import 'package:restapp/data/database/database_helper.dart';
import 'package:restapp/provider/database_provider.dart';
import 'package:restapp/provider/restaurant_provider.dart';
import 'package:restapp/utility/result_state.dart';
import 'package:restapp/widget/card_restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantlistPage extends StatelessWidget {
  const RestaurantlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => RestaurantProvider(apiService: ApiService())),
          ChangeNotifierProvider<DatabaseProvider>(
              create: (_) =>
                  DatabaseProvider(databaseHelper: DatabaseHelper())),
        ],
        child: Consumer<RestaurantProvider>(
          builder: (context, value, child) {
            if (value.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (value.state == ResultState.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = value.result.restaurants[index];
                    return CardRestaurant(restaurant: restaurant);
                  },
                );
              } else if (value.state == ResultState.error) {
                return Center(
                  child: Text(value.message.contains("Failed host lookup")
                      ? "Terjadi kesalahan koneksi tidak tersedia"
                      : "Terjadi kesalahan coba lagi nanti"),
                );
              } else {
                return const Material(child: Text(''));
              }
            }
          },
        ),
      ),
    );
  }
}
