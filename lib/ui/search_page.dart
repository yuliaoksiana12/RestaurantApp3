import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapp/data/api/api_service.dart';
import 'package:restapp/provider/search_provider.dart';
import 'package:restapp/utility/result_state.dart';
import 'package:restapp/widget/card_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Consumer(
                  builder: (context, value, child) => TextField(
                    cursorColor: Colors.black,
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    onSubmitted: (value) =>
                        Provider.of<SearchRestaurantProvider>(context,
                                listen: false)
                            .changeSearchString(_controller.text),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<SearchRestaurantProvider>(
                  builder: (context, value, child) {
                    if (value.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (value.state == ResultState.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.result.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = value.result.restaurants[index];
                          return CardRestaurant(restaurant: restaurant);
                        },
                      );
                    } else if (value.state == ResultState.noData) {
                      return const Center(
                        child: Text("Kata kunci tidak ditemukan"),
                      );
                    } else if (value.state == ResultState.error) {
                      return Center(
                        child: Text(value.message.contains("Failed host lookup")
                            ? "Terjadi kesalahan koneksi tidak tersedia"
                            : "Terjadi kesalahan coba lagi nanti"),
                      );
                    } else {
                      return const Center(
                        child: Text(""),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
