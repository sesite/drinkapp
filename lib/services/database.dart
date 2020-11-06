import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkapp/models/drink.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //ссылка на коллекцию
  final CollectionReference drinksCollection =
      FirebaseFirestore.instance.collection('drinks');

  //обновить/создать коллекцию связанную по uid с User
  Future updateUserData(String sugars, String name, int strength) async {
    return await drinksCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

//drinks list from snapshots
  List<Drink> _drinksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Drink(
        name: doc.data()['name'] ?? '',
        sugars: doc.data()['sugars'] ?? '0',
        strength: doc.data()['strength'] ?? 0,
      );
    }).toList();
  }

  // слушаем поток snapshots коллекций drinks
  Stream<List<Drink>> get drinks {
    return drinksCollection.snapshots().map(_drinksListFromSnapshot);
  }
}
