import 'package:flutter/cupertino.dart';

class Review {
  String text;
  int starts;

  Review({this.text, this.starts});
}

class Availability {
  String availableDays;
  String availableTimes;

  Availability({this.availableDays, this.availableTimes});
}

class Advocate with ChangeNotifier {
  final String id;
  final String name;
  String imageUrl;
  String location;
  List<String> areaOfLaw;
  int experience;
  bool isFavorite;
  List<String> categories;
  final String address;
  List<String> servicesCities;
  List<Review> reviews;
  List<Availability> availability;

  Advocate(
      {this.id,
      this.name,
      this.categories,
      this.imageUrl,
      this.location,
      this.areaOfLaw,
      this.experience,
      this.isFavorite = false,
      this.address,
      this.servicesCities,
      this.reviews,
      this.availability});

  void toggleFavoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
