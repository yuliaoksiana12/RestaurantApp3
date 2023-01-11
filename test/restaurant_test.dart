import 'package:flutter_test/flutter_test.dart';
import 'package:restapp/data/model/list_restaurant.dart';

var dummyData = {
  "error": false,
  "message": "success",
  "count": 20,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
    {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    }
  ]
};

void main() {
  test("Test From Json", () async {
    var errorResult = RestaurantResult.fromJson(dummyData).error;
    var messageResult = RestaurantResult.fromJson(dummyData).message;
    var countResult = RestaurantResult.fromJson(dummyData).count;

    expect(errorResult, false);
    expect(messageResult, "success");
    expect(countResult, 20);
  });
}
