import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:ylc/api/user_api.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/ui/advocates/custom_consultation.dart';

class AdvocatesBloc {
  final _advocates = BehaviorSubject<List<UserModel>>();
   final _advocatesSearch = BehaviorSubject<List<UserModel>>();

  Stream<List<UserModel>> get advocates => _advocates.stream;
  Stream<List<UserModel>> advocatesSearchedList;
  Stream<List<UserModel>> getAdvocatesSearchedList(String name) {
    _advocatesSearch.drain().then((value) {

      _advocates.forEach((element) {
        element.forEach((element1) {
          if(element1.name.contains(name)){
            _advocatesSearch.add(element);
          }
        });
      });

    });

     return _advocatesSearch.stream;
  }


  void init(String userId, String type) {
    if (type == null) {
      UserApi.getAllAdvocates(userId).then((event) {
        _advocates.add(event);
      });
    } else {
      UserApi.getAllAdvocatesWithFilter(userId, null, type, null).then((event) {
        _advocates.add(event);
      });
    }
  }

  void initWithData(
    String userId,
    ExperienceData data,
    String type,
    bool isVerified,
  ) {
    UserApi.getAllAdvocatesWithFilter(userId, data, type, isVerified)
        .then((event) {
      _advocates.add(event);
    });
  }

  Stream<UserModel> getAdvocateStream(String id) async* {
    _advocates.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          data.firstWhere((element) {
            if (element.id == id) {
              sink.add(element);
              return true;
            } else {
              return false;
            }
          });
        },
      ),
    );
  }
  //
  // search(String query){
  //   advocates.forEach((element) {
  //     element.forEach((element) {
  //       if(element.name.contains(query)){
  //         _advocatesSearch.add(element);
  //       }
  //     });
  //   });
  //
  // }
  //
  //
  // searchAdvocates(
  //     String userId,
  //     ExperienceData data,
  //     String type,
  //     bool isVerified,
  //     ) {
  //   UserApi.getAllAdvocatesWithFilter(userId, data, type, isVerified)
  //       .then((event) {
  //     _advocates.add(event);
  //   });
  // }


  void dispose() {
    _advocates.close();
  }
}
