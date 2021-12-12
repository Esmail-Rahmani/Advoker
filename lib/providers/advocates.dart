
import 'advocate.dart';
import 'package:flutter/material.dart';

class Advocates with ChangeNotifier{
    List<Advocate> _list = [
      Advocate(
          id: 'a1',
          name: 'Ahmad',
          location: 'vasco goa',
          categories: ['c1','c2','c3'],
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkVwMa866UsjdiQgSk4aHCNiYEr1cVui9mZw&usqp=CAU',
          areaOfLaw: ['civil low', 'criminal low'],
          experience: 1,
          address: 'zuarinagar goa',
          servicesCities: ['vasco', 'Panji'],
          reviews: [
            Review(text: 'good', starts: 3),
            Review(text: 'good', starts: 3),
            Review(text: 'good', starts: 4)
          ],
          availability: [
            Availability(
                availableDays: "Monday - Friday", availableTimes: " 8am - 2pm"),
          ]),
      Advocate(
          id: 'a2',
          name: 'Esmail',
          location: 'vasco goa',
          categories: ['c1','c2','c3','c7'],
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkVwMa866UsjdiQgSk4aHCNiYEr1cVui9mZw&usqp=CAU',
          areaOfLaw: ['civil low', 'criminal low'],
          experience: 1,
          address: 'zuarinagar goa',
          servicesCities: ['vasco', 'Panji'],
          reviews: [
            Review(text: 'good', starts: 3),
            Review(text: 'good', starts: 3),
            Review(text: 'good', starts: 4)
          ],
          availability: [
            Availability(
                availableDays: "Monday - Friday", availableTimes: " 8am - 2pm"),
          ]),
      Advocate(
          id: 'a3',
          name: 'Raj',
          location: 'vasco goa',
          categories: ['c1','c2','c3','c3','c4'],
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkVwMa866UsjdiQgSk4aHCNiYEr1cVui9mZw&usqp=CAU',
          areaOfLaw: ['civil low', 'criminal low'],
          experience: 1,
          address: 'zuarinagar goa',
          servicesCities: ['vasco', 'Panji'],
          reviews: [
            Review(text: 'good', starts: 3),
            Review(text: 'good', starts: 3),
            Review(text: 'good', starts: 4)
          ],
          availability: [
            Availability(
                availableDays: "Monday - Friday", availableTimes: " 8am - 2pm"),
          ]),
      Advocate(
          id: 'a4',
          name: 'Ali',
          location: 'vasco goa',
          categories: ['c1','c2','c3'],
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkVwMa866UsjdiQgSk4aHCNiYEr1cVui9mZw&usqp=CAU',
          areaOfLaw: ['civil low', 'criminal low'],
          experience: 1,
          address: 'zuarinagar goa',
          servicesCities: ['vasco', 'Panji'],
          reviews: [
            Review(text: 'good', starts: 3),
            Review(text: 'good', starts: 3),
            Review(text: 'good', starts: 4)
          ],
          availability: [
            Availability(
                availableDays: "Monday - Friday", availableTimes: " 8am - 2pm"),
          ])
    ];

    List<Advocate> get favoriteItems {
      return _list.where((element) => element.isFavorite).toList();
    }
    List<Advocate> advocateListByCategoryId(String id) {
      return _list.where((element) => element.categories.contains(id)).toList();
    }
    // top 10 an near by lists

    List<Advocate> get list {
      return [..._list];
    }
    Advocate findById(String id) {
      return list.firstWhere((element) => element.id == id);
    }
}