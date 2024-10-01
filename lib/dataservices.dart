import 'package:flutter/services.dart';
import 'dart:convert';

class DataService {
  static List<Map<String, dynamic>> _destinations = [];
  static List<Map<String, dynamic>> _hotels = [];

  static Future<void> loadDataFromJson() async {
    if (_destinations.isNotEmpty && _hotels.isNotEmpty) {
      return;
    }

    final String destinationJson =
        await rootBundle.loadString('destination.json');
    final List<dynamic> decodedDestinations = json.decode(destinationJson);

    final String hotelJson = await rootBundle.loadString('hotel.json');
    final List<dynamic> decodedHotels = json.decode(hotelJson);

    _destinations = decodedDestinations
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
    _hotels =
        decodedHotels.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  static List<Map<String, dynamic>> get destinations {
    return _destinations;
  }

  static List<Map<String, dynamic>> get hotels {
    return _hotels;
  }
}
