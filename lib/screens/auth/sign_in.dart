import 'package:drinkapp/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Вход в приложение'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: RaisedButton(
              child: Text('Войти анонимно'),
              onPressed: () async {
                dynamic result = await _auth.signAnonym();
                if (result == null) {
                  print('Не смог войти анонимно');
                } else {
                  print('Вошел анонимно');
                  print(result.uid);
                }
              }),
        ),
      ),
    );
  }
}
