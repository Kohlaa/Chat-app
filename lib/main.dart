import 'package:chat/chat/chat_screen.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/add_room/add_room.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:chat/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoom.routeName : (context) => AddRoom(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
      initialRoute: userProvider.firebaseUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
    );
  }
}
