import 'package:drinkapp/models/drink.dart';
import 'package:drinkapp/screens/home/drinktile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinkList extends StatefulWidget {
  DrinkList({Key key}) : super(key: key);

  @override
  _DrinkListState createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  @override
  Widget build(BuildContext context) {
    final drinks = Provider.of<List<Drink>>(context) ?? [];

    return ListView.builder(
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          return DrinkTile(drink: drinks[index]);
        });
  }
}
