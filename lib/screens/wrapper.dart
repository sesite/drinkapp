import 'package:drinkapp/models/user.dart';
import 'package:drinkapp/screens/auth/Authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
