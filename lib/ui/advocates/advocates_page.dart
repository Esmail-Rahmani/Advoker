import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ylc/api/user_api.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/models/local/category_model.dart';
import 'package:ylc/ui/advocates/bloc/advocates_bloc.dart';
import 'package:ylc/ui/advocates/custom_consultation.dart';
import 'package:ylc/ui/profile/advocate_profile.dart';
import 'package:ylc/user_config.dart';
import 'package:ylc/utils/categoris_list.dart';
import 'package:ylc/values/strings.dart';
import 'package:ylc/widgets/loading_view.dart';
import 'package:ylc/widgets/navigaton_helper.dart';
import 'package:ylc/widgets/profile_image.dart';
import 'package:ylc/widgets/ui_widgets/category_advocates_item.dart';

class AdvocatePageData {
  final String type;
  final bool isVerified;
  final ExperienceData data;

  AdvocatePageData(this.type, this.isVerified, this.data);
}

class AdvocatesPage extends StatefulWidget {
  final CategoryModel model;
  final AdvocatePageData advocatePageData;

  const AdvocatesPage({
    Key key,
    this.model,
    this.advocatePageData,
  }) : super(key: key);

  @override
  _AdvocatesPageState createState() => _AdvocatesPageState();
}

class _AdvocatesPageState extends State<AdvocatesPage> {
  List<UserModel> advocates;

  List<UserModel> searchedAdvocates;
  bool isSearching = false;

  bool isLoading = false;

  String _currentLocation() {
    return '';
  }

  Future<void> getList() async {
    setState(() {
      isLoading = true;
    });
    if (widget.model != null) {
      var temp = widget.advocatePageData;
      UserApi.getAllAdvocatesWithFilter(
              AppConfig.userId, temp.data??null, temp.type, temp.isVerified)
          .then((value) {
        setState(() {
          advocates = value;
          isLoading = false;
        });
      });
    } else {
      UserApi.getAllAdvocates(
        AppConfig.userId,
      ).then((value) {
        setState(() {
          advocates = value;
          isLoading = false;
        });
      });
    }
  }

  @override
  void initState() {
    advocates = [];
    this.getList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(advocates.length);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.model?.title ?? Strings.advocates,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: "search",
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                child: TextField(
                  onChanged: (v) {
                    isSearching = true;
                        if (v.isEmpty || v == null) {
                          setState(() {
                            isSearching = false;
                          });
                        } else {
                          setState(() {
                            isSearching = true;
                          });
                          searchedAdvocates = [];
                          advocates.forEach((element) {
                            if (element.name.contains(v)) {
                              setState(() {
                                searchedAdvocates.add(element);
                              });
                            }
                          });
                        }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: Strings.whatAreYouLookingFor,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                ),
              ),
            ),
            // StreamBuilder<List<UserModel>>(
            //   stream: isSearching ? searchedAdvocates : bloc.advocates,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Center(
            //         child: Text(Strings.generalError),
            //       );
            //     }
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return LoadingIndicator();
            //     }
            //     if (snapshot.data == null || snapshot.data.isEmpty) {
            //       return Center(
            //         child: Text(Strings.noAdvocates),
            //       );
            //     }
            //     var data1 = snapshot.data;
            //     return
            advocates.contains(null) || advocates.length < 0 || isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ))
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: isSearching
                        ? searchedAdvocates.length
                        : advocates.length,
                    itemBuilder: (_, index) {
                      var user = isSearching
                          ? searchedAdvocates[index]
                          : advocates[index];
                      print(user.name);
                      return Container(
                        height: 150,
                        child: CategoryAdvocatesItem(
                          name: user.name,
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkVwMa866UsjdiQgSk4aHCNiYEr1cVui9mZw&usqp=CAU',
                          favorite: true,
                          reviews: 5,
                          experince: user.advocateDetails.experience ?? 1,
                          location:
                              user.additionalDetails.city ?? _currentLocation(),
                          id: user.id,
                        ),
                      );

                      // Card(
                      //   child: ListTile(
                      //     leading: ProfileImage.lightColor(
                      //       photo: user.photo,
                      //       radius: 22,
                      //     ),
                      //     title: Text(
                      //       user.name,
                      //       style: TextStyle(fontSize: 16),
                      //     ),
                      //     onTap: () {
                      //       navigateToPage(
                      //         context,
                      //         Provider<UserModel>.value(
                      //           value: user,
                      //           child: AdvocateProfile(),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.filter_alt),
      ),
    );
  }
}
