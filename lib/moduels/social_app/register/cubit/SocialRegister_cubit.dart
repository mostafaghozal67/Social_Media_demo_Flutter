import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/models/social_app/social_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'SocialRegister_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{

  SocialRegisterCubit () : super(SocialRegisterIntialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = true;

  // late ShopLoginModel shopLoginModel;

  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;
    emit(SocialChangePasswordvisibilityState());
  }
  
  void userRegister({required String name,required String email,required String password,required String phone}){
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          //print(value.user!.email);
          //print(value.user!.uid);
          userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
          //emit(SocialRegisterSuccessState());

    }).catchError((error){
      emit(SocialRegisterErrorState());
    });
  }

  void userCreate({required String name,required String email,required String phone,required String uId}){
    
    SocialUserModel model = SocialUserModel(
        name : name,
        email : email,
        phone : phone,
        uId : uId,
        isEmailVerified : false,
        image: "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1707843816~exp=1707844416~hmac=d25da03df684b593d1baea7381bb6376ad501664031838c83675af243152f65a",
        cover: "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1707843816~exp=1707844416~hmac=d25da03df684b593d1baea7381bb6376ad501664031838c83675af243152f65a",
        bio: "Write Your Bio ..");

    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)  {

      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error){
      //print(error.toString());
      emit(SocialCreateUserErrorState());
    });

  }




}
