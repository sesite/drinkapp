import 'package:drinkapp/screens/auth/Authenticate.dart';
import 'package:flutter/material.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Authenticate(),
    );
  }
}
