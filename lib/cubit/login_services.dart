

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flut_task/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginServices extends Cubit<LoginState>{

  late FirebaseAuth app;
LoginServices(): super(LoginInitialState()){
  _init();
}
  _init() async{
    app =await FirebaseAuth.instance;
  }
  signOut() async{
    await app.signOut();
  }
  login(String emailAddress,String password) async{
    //UserCredential credential;
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      emit(LoginLoadedState(credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(LoginErrorState("No user found for that email."));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        emit(LoginErrorState("Wrong password provided for that user."));
      }
    }

  }
  register(String emailAddress,String password,String userName) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      ).then((newUser) {
        newUser.user?.updateDisplayName(userName);
        emit(LoginLoadedState(newUser));
      });



    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(LoginErrorState("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(LoginErrorState("The account already exists for that email."));
      }
    } catch (e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    }
  }
}