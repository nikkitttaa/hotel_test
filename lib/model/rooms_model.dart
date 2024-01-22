import 'dart:convert';
import 'package:http/http.dart' as http;

class Room {
  final int id;
  final String name;
  final int price;
  final String pricePer;
  final List<String> peculiarities;
  final List<String> imageUrls;

  Room({
    required this.id,
    required this.name,
    required this.price,
    required this.pricePer,
    required this.peculiarities,
    required this.imageUrls,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    List<String> peculiaritiesList = [];
    for (var peculiaritiesJson in json['peculiarities']) {
      peculiaritiesList.add(peculiaritiesJson as String);
    }

    List<dynamic> imageUrlList = json['image_urls'];
    List<String> imageUrls = imageUrlList.map((url) => url.toString()).toList();

    return Room(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      pricePer: json['price_per'] as String,
      peculiarities: peculiaritiesList,
      imageUrls: imageUrls,
    );
  }
}

Future<List<Room>> fetchRooms() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body)['rooms'];
    return jsonResponse.map((roomJson) => Room.fromJson(roomJson)).toList();
  } else {
    throw Exception('Failed to load rooms');
  }
}
