import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapp/data/database/database_helper.dart';
import 'package:restapp/provider/database_provider.dart';
import 'package:restapp/utility/result_state.dart';
import 'package:restapp/widget/card_restaurant.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Favorite"),
        ),
        body: Consumer<DatabaseProvider>(
          builder: (context, value, child) {
            if (value.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.state == ResultState.hasData) {
              return ListView.builder(
                itemCount: value.favorite.length,
                itemBuilder: (context, index) {
                  var restaurant = value.favorite[index];
                  return CardRestaurant(restaurant: restaurant);
                },
              );
            } else if (value.state == ResultState.error) {
              return Center(
                child: Text(value.message.contains("Failed host lookup")
                    ? "Terjadi kesalahan koneksi tidak tersedia"
                    : "Terjadi kesalahan coba lagi nanti"),
              );
            } else if (value.state == ResultState.noData) {
              return const Center(
                child: Text("Favorite kosong"),
              );
            } else {
              return const Material(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
