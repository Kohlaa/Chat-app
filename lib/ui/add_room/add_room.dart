import 'package:chat/ui/add_room/add_room_navigator.dart';
import 'package:chat/ui/add_room/add_room_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'room';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator {
  AddRoomViewModel viewModel = AddRoomViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
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
                'Add Room',
              ),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                children: [
                  Text('Create New Room',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
