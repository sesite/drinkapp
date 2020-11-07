import 'package:drinkapp/models/drink.dart';
import 'package:flutter/material.dart';

class DrinkTile extends StatelessWidget {
  const DrinkTile({Key key, this.drink}) : super(key: key);
  final Drink drink;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/coffee_cup.png'),
              radius: 28,
              backgroundColor: Colors.brown[drink.strength],
            ),
            title: Text(drink.name),
            subtitle: Text('Мне нужно ${drink.sugars} кубика сахара'),
          ),
        ),
      ),
    );
  }
}
