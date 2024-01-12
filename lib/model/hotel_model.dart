import 'dart:convert';
import 'package:http/http.dart' as http;

class Hotel {
  final int id;
  final String name;
  final String adress;
  final int minimalPrice;
  final String priceForIt;
  final int rating;
  final String ratingName;
  final List<String> imageUrls;
  final String description;
  final List<String> peculiarities;


  Hotel({
    required this.id,
    required this.name,
    required this.adress,
    required this.minimalPrice,
    required this.priceForIt,
    required this.rating,
    required this.ratingName,
    required this.imageUrls,
    required this.description,
    required this.peculiarities,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    List<dynamic> imageUrlList = json['image_urls'];
    List<String> imageUrls = imageUrlList.map((url) => url.toString()).toList();

    List<dynamic> peculiaritiesList = json['about_the_hotel']['peculiarities'];
    List<String> peculiarities = peculiaritiesList.map((peculiarity) => peculiarity.toString()).toList();

    return Hotel(
      id: json['id'],
      name: json['name'],
      adress: json['adress'],
      minimalPrice: json['minimal_price'],
      priceForIt: json['price_for_it'],
      rating: json['rating'],
      ratingName: json['rating_name'],
      imageUrls: imageUrls,
      description: json['about_the_hotel']['description'],
      peculiarities: peculiarities,
    );
  }

  static Future<Hotel> fetchHotelData() async {
    var url = 'https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473'; 
    var response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      return Hotel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch hotel data');
    }
  }
}
