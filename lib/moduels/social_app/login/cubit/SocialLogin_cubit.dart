import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'SocialLogin_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit () : super(SocialLoginIntialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  //late ShopLoginModel loginModel;
  bool isPasswordShown = true;
  IconData suffix = Icons.visibility_outlined;


  void userLogin({required String email , required String password}){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      //print(value.user!.email);
      emit(SocialLoginSuccessState(value.user!.uid));

    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ?  Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePasswordvisibilityState());
  }
}