import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapp/data/model/list_restaurant.dart';
import 'package:restapp/provider/database_provider.dart';
import 'package:restapp/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.isFavorite(restaurant.id),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            var isFavorite = snapshot.data ?? false;
            return Material(
              color: Colors.white,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                    width: 100,
                  ),
                ),
                title: Text(
                  restaurant.name,
                ),
                subtitle: Text(restaurant.city),
                trailing: isFavorite
                    ? IconButton(
                        onPressed: () => value.removeFavorite(restaurant.id),
                        icon: const Icon(Icons.star, color: Colors.yellow),
                      )
                    : IconButton(
                        onPressed: () => value.addFavorite(restaurant),
                        icon: const Icon(Icons.star_border),
                      ),
                onTap: () => Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.routeName,
                  arguments: restaurant.id,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
