// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

class BookRoom {
  final int id;
  final String hotelName;
  final String hotelAdress;
  final int horating;
  final String ratingName;
  final String departure;
  final String arrivalCountry;
  final String tourDateStart;
  final String tourDateStop;
  final int numberOfNights;
  final String room;
  final String nutrition;
  final int tourPrice;
  final int fuelCharge;
  final int serviceCharge;

  BookRoom({
    required this.id,
    required this.hotelName,
    required this.hotelAdress,
    required this.horating,
    required this.ratingName,
    required this.departure,
    required this.arrivalCountry,
    required this.tourDateStart,
    required this.tourDateStop,
    required this.numberOfNights,
    required this.room,
    required this.nutrition,
    required this.tourPrice,
    required this.fuelCharge,
    required this.serviceCharge,
  });

  factory BookRoom.fromJson(Map<String, dynamic> json) {
    return BookRoom(
      id: json['id'] as int,
      hotelName: json['hotel_name'] as String,
      hotelAdress: json['hotel_adress'] as String,
      horating: json['horating'] as int,
      ratingName: json['rating_name'] as String,
      departure: json['departure'] as String,
      arrivalCountry: json['arrival_country'] as String,
      tourDateStart: json['tour_date_start'] as String,
      tourDateStop: json['tour_date_stop'] as String,
      numberOfNights: json['number_of_nights'] as int,
      room: json['room'] as String,
      nutrition: json['nutrition'] as String,
      tourPrice: json['tour_price'] as int,
      fuelCharge: json['fuel_charge'] as int,
      serviceCharge: json['service_charge'] as int,
    );
  }

  static Future<BookRoom> fetchBookRoomData() async {
    var url = 'https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      return BookRoom.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch hotel data');
    }
  }
}
