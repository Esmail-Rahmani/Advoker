import 'package:flutter/material.dart';
import 'package:ylc/models/data_models/user_model.dart';
import 'package:ylc/providers/advocate.dart';
import './advocate_item.dart';
class HorizontalListScrollable extends StatelessWidget {
  const HorizontalListScrollable({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<UserModel> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: list
                  .map((e) => Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8.0),
                child: AdvocateItem(e),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
