import 'package:drinkapp/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key key, this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Регистрация в приложение'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Войти'),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  validator: (value) => value.isEmpty ? 'Введите email' : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  validator: (value) => value.length < 6
                      ? 'Введите пароль не менее 6 символов'
                      : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Зарегистрируйтесь',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(email);
                        print(password);
                        dynamic result = await _auth.registerFromEmailPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Неверный email';
                          });
                        } else
                          print('регистрация успешна!' + result.toString());
                      }
                    }),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
