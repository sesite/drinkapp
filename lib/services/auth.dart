import 'package:drinkapp/models/user.dart';
import 'package:drinkapp/services/database.dart';
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
  Future signFromEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Регистрация по эл.почте и паролю
  Future registerFromEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('auth reg ' + _userFromFirebaseUser(result.user).toString());

      //при успешной регистрации создаем коллекцию в базе данных
      await DatabaseService(uid: result.user.uid)
          .updateUserData('0', result.user.email, 100);

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print('auth not reg ' + e.toString());
      return null;
    }
  }

  //Выход User
  Future logOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
