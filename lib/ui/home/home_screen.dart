import 'package:chat/database/database_utils.dart';
import 'package:chat/ui/add_room/add_room.dart';
import 'package:chat/ui/add_room/room_widget.dart';
import 'package:chat/ui/home/home_navigator.dart';
import 'package:chat/ui/home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/room.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator {
  HomeViewModel viewModel = HomeViewModel();

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
                'Home',
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddRoom.routeName);
              },
              child: Icon(Icons.add),
            ),
            body: StreamBuilder<QuerySnapshot<Room>>(
              stream: DatabaseUtils.getRooms(),
              builder: (context, asyncSnapShot) {
                if (asyncSnapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else if (asyncSnapShot.hasError) {
                  return Text(asyncSnapShot.error.toString());
                } else {
                  var roomsList = asyncSnapShot.data?.docs
                          .map((doc) => doc.data())
                          .toList() ??
                      [];
                  return GridView.builder(
                    itemBuilder: (context, index) {
                      return RoomWidgit(
                        room: roomsList[index],
                      );
                    },
                    itemCount: roomsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
