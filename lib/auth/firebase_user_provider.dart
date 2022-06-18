import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SwimStoryFirebaseUser {
  SwimStoryFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

SwimStoryFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SwimStoryFirebaseUser> swimStoryFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<SwimStoryFirebaseUser>(
        (user) => currentUser = SwimStoryFirebaseUser(user));
