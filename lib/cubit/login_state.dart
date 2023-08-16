
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState{

}
//
class LoginInitialState extends LoginState{}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
}
class LoginLoadedState extends LoginState{
  UserCredential credential;
  LoginLoadedState(this.credential);
}


class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);
}
