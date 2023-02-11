import 'package:chat/ui/add_room/add_room.dart';
import 'package:chat/ui/home/home_navigator.dart';
import 'package:chat/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          )
        ],
      ),
    );
  }
}
