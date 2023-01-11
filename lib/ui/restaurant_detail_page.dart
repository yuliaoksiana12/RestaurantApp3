import 'package:provider/provider.dart';
import 'package:restapp/data/api/api_service.dart';
import 'package:restapp/provider/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:restapp/utility/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: ChangeNotifierProvider<DetailRestaurantProvider>(
        create: (_) =>
            DetailRestaurantProvider(apiService: ApiService(), id: id),
        child: Consumer<DetailRestaurantProvider>(
            builder: (context, value, child) {
          if (value.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.state == ResultState.noData) {
            return const Center(
                child: Text("Terjadi kesalahan, Data tidak ditemukan"));
          } else if (value.state == ResultState.hasData) {
            var restaurant = value.result.restaurant;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}')),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const Divider(color: Colors.grey),
                        Text(
                          restaurant.description,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Divider(color: Colors.grey),
                        Text(
                          restaurant.city,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const Divider(color: Colors.grey),
                        Text(
                          restaurant.pictureId,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const Divider(color: Colors.grey),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          restaurant.address,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(
                            height: 30,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurant.menus.foods.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    color: Colors.lightGreenAccent,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 7.0,
                                      ),
                                      child: Text(
                                        restaurant.menus.foods[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  );
                                })),
                        SizedBox(
                            height: 30,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurant.menus.drinks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    color: Colors.lightGreenAccent,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 7.0,
                                      ),
                                      child: Text(
                                        restaurant.menus.drinks[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  );
                                })),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (value.state == ResultState.error) {
            return Center(
              child: Text(value.message.contains("Failed host lookup")
                  ? "Terjadi kesalahan koneksi tidak tersedia"
                  : "Terjadi kesalahan coba lagi nanti"),
            );
          } else {
            return const Center(child: Text("Terjadi kesalahan"));
          }
        }),
      ),
    );
  }
}
