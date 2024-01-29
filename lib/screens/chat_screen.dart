import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final _store = FirebaseFirestore.instance;
User? logginedInUser;
 
class ChatScreen extends StatefulWidget {
  static const String id = 'Chat screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String? message;
  final messageTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        logginedInUser = user;
        print(logginedInUser?.email);
        print(message);
      }
    } catch (e) {
      print(e);
    }
  } 

  void getSteam() async {
    await for (var messager in _store.collection('messages').snapshots()) {
      for (var message in messager.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                getSteam();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageSteam(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    
                    onPressed: () {
                      messageTextController.clear();
                      _store.collection('messages').add({
                        'text': message,
                        'sender': logginedInUser?.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageSteam extends StatelessWidget {
  const MessageSteam({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _store.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages!) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final String? currentUser = logginedInUser!.email;

          // if (currentUser == logginedInUser) {}

          final messageBubble = MessageBubble(
            messageSender: messageSender,
            messageText: messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            
            shrinkWrap: true,
            
            
            children:  messageBubbles,
          
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.messageSender,
      required this.messageText,
      required this.isMe});
  final String messageText;
  final String messageSender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$messageSender', style: TextStyle(fontSize: 12)),
          Material(
            elevation: 7,
            borderRadius:isMe ? BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20)) :  BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
            color: isMe ? Colors.lightBlueAccent : Colors. white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                '$messageText',
                style: TextStyle(fontSize: 20, color:isMe ?Colors.white : Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
