import 'package:flutter/material.dart';

class ChatListItem extends StatefulWidget {
  final bool isOnline;
  final String username;
  final bool hasProfile;
  final int unreadMessageNum;

  ChatListItem({
    this.isOnline,
    this.username,
    this.hasProfile,
    this.unreadMessageNum,
  });

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          // Navigator.pushNamed(context, ChatScreen.routeName);
        },
        child: Container(
          height: 48,
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: widget.hasProfile
                        ? NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA-03sad0NP5GoGFVZZ7HLa_F0mDwg7KXkGQ&usqp=CAU')
                        : null,
                    child: widget.hasProfile ? null : Text('T'),
                  ),
                  if (widget.isOnline)
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.green,
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name of user',
                      style: Theme.of(context).textTheme.headline6),
                  Text(
                    'Last message',
                    style: TextStyle(
                      color: widget.unreadMessageNum == 0
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    '12:30',
                    style: TextStyle(
                      color: widget.unreadMessageNum == 0
                          ? Colors.grey
                          : Colors.blue,
                    ),
                  ),
                  SizedBox(height: 6,),
                  if (widget.unreadMessageNum != 0)
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.blue,
                      child: Text(
                        widget.unreadMessageNum.toString(),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
