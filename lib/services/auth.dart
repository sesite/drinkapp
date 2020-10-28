import 'package:drinkapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //создаем user основанного на FirebaseUser (User)
  UserApp _userFromFirebaseUser(User user) {
    return user != null ? UserApp(uid: user.uid) : null;
  }

//Слушаем поток изменения состояния User
  Stream<UserApp> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Анонимный вход
  Future signAnonym() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      //User user = result.user;
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //Вход по эл.почте и паролю

}
