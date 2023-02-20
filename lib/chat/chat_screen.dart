import 'package:chat/chat/chat_navigator.dart';
import 'package:chat/chat/chat_screen_view_model.dart';
import 'package:chat/model/room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();

  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          color: Colors.white,
        ),
        Image.asset('assets/images/main_background.png',
            fit: BoxFit.fill, width: double.infinity),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              title: Text(
                args.title,
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 32),
              // width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              hintText: 'Type a message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12)),
                              )),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text('Send'),
                              SizedBox(width: 10),
                              Icon(Icons.send_outlined)
                            ],
                          ))
                    ],
                  )
                ],
              ),
            )),
      ]),
    );
  }
}
