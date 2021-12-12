import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  var docs = [
    {'text': 'hello', 'username': 'ali', 'userImage': 'null', 'isMe': true},
    {'text': 'hello', 'username': 'ali', 'userImage': 'null', 'isMe': false},
    {'text': 'hello', 'username': 'ali', 'userImage': 'null', 'isMe': false},
    {'text': 'hello', 'username': 'ali', 'userImage': 'null', 'isMe': true},
  ];

  void addMessage(doc){
    docs.add(doc);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: ListView.builder(
        itemCount: docs.length,
        reverse: true,
        itemBuilder: (ctx, index) => MessageBubble(
          docs[index]['text'],
          docs[index]['username'],
          docs[index]['userImage'],
          docs[index]['isMe'],
          key: ValueKey(docs[index]),
        ),
      ),
    );
  }
}
