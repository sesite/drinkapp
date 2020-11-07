import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinkapp/models/drink.dart';
import 'package:drinkapp/models/user.dart';

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

//userData from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }

  // слушаем поток snapshots коллекций drinks
  Stream<List<Drink>> get drinks {
    return drinksCollection.snapshots().map(_drinksListFromSnapshot);
  }

// слушаем поток snapshots коллекции по uid
  Stream<UserData> get userData {
    return drinksCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
