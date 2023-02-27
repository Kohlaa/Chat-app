import 'dart:async';

import 'package:chat/firebase_errors.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/register/register_navigator.dart';
import 'package:chat/ui/register/register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/utils.dart' as Utils;
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  String firstName = '';

  String lastName = '';

  String userName = '';

  String email = '';

  String password = '';

  var formKey = GlobalKey<FormState>();
  RegisterViewModel viewModel = RegisterViewModel();

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
                'Create Account',
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'First Name'),
                        onChanged: (text) {
                          firstName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Last Name'),
                        onChanged: (text) {
                          lastName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'User Name'),
                        onChanged: (text) {
                          userName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (text) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text!);
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter email';
                          }
                          if (!emailValid) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        onChanged: (text) {
                          password = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          if (text.length < 6) {
                            return 'Password must be at least 6 chars.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: Text('Create Account'))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> validateForm() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.registerFirebaseAuth(
          email, password, firstName, lastName, userName);
    }
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    Utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    Utils.showMessage(message, context, 'Ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigateToHome(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.user = user;
    // TODO: implement navigateToHome
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }
}
