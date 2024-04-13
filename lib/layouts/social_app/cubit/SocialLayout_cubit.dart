import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_project/layouts/social_app/cubit/SocialLayout_states.dart';
import 'package:first_project/models/social_app/message_model.dart';
import 'package:first_project/models/social_app/social_post_model.dart';
import 'package:first_project/models/social_app/social_user_model.dart';
import 'package:first_project/moduels/social_app/chats/social_chats_screen.dart';
import 'package:first_project/moduels/social_app/feeds/social_feeds_screen.dart';
import 'package:first_project/moduels/social_app/login/social_login_screen.dart';
import 'package:first_project/moduels/social_app/settings/social_settings_screen.dart';
import 'package:first_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../shared/network/local/cache_helper.dart';


class SocialCubit extends Cubit<SocialStates>{
  SocialCubit () : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex= 0;

  PostModel? postModel;

  List<Widget> screens = [
    FeedsScreen(),
    const ChatsScreen(),
    const SettingsScreen(),
  ];

  List<String> titels = [
    "Home",
    "Chats",
    "Settings"
  ];

  void changeBottomNav(int index){
    currentIndex = index;
    if(index == 1) {
      getAllUsers();
    }
    emit(SocialChangeBottomNavState());
  }

  SocialUserModel? socialUserModel;


  void getUserData(){

    emit(SocialGetUserLoadingState());
    //print(uId);
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      socialUserModel = SocialUserModel.fromjson(value.data()!);

      emit(SocialGetUserSuccessState());
    }).catchError((error){
      //print(error.toString());
      emit(SocialGetUserErrorState());
    });
  }


  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      //print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
      uploadProfileImage();

    } else {
      //print('No image selected.');
      emit(SocialProfileImagePickedErrorState());

    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      //print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
      uploadCoverImage();

    } else {
      //print('No image selected.');
      emit(SocialCoverImagePickedErrorState());

    }
  }


  String ? profileImageUrl ;

  void uploadProfileImage(){
    FirebaseStorage.instance.ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}") 
        .putFile(profileImage!) 
        .then((value) {
      value.ref.getDownloadURL().then((value) { 
        profileImageUrl = value;
        //print(profileImageUrl);
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error){
        emit(SocialUploadProfileImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String ? coverImageUrl ;

  void uploadCoverImage(){
    FirebaseStorage.instance.ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}") 
        .putFile(coverImage!) 
        .then((value) {
      value.ref.getDownloadURL().then((value) { 
        coverImageUrl = value;
        //print(coverImageUrl);
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({required String name ,required String bio , required String phone}){
    emit(SocialUserUpdateLoadingState());

    SocialUserModel userModel = SocialUserModel(
      name: name,
      email:socialUserModel!.email,
      phone: phone,
      uId: socialUserModel!.uId,
      isEmailVerified : socialUserModel!.isEmailVerified,
      image: profileImageUrl == null ?socialUserModel!.image : profileImageUrl,
      cover: coverImageUrl == null ? socialUserModel!.cover : coverImageUrl,
      bio: bio,);

    FirebaseFirestore.instance.collection('users').doc(socialUserModel!.uId).update(userModel.toMap()).then((value) {
      getUserData();
      //getPosts();
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      //print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
      uploadPostImage();

    } else {
      //print('No image selected.');
      emit(SocialPostImagePickedErrorState());

    }
  }

  String ? postImageUrl ;

  void uploadPostImage(){
    FirebaseStorage.instance.ref()
        .child("users/${Uri.file(postImage!.path).pathSegments.last}") 
        .putFile(postImage!) 
        .then((value) {
      value.ref.getDownloadURL().then((value) { 
        postImageUrl = value;
        //postImage = null;
        //print(coverImageUrl);
        emit(SocialUploadPostImageSuccessState());
      }).catchError((error){
        emit(SocialUploadPostImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void removePostImage(){
    postImage = null ;
    emit(SocialRemovePostImageState());
  }

  void createNewPost({required String dateTime, required String text}){

    emit(SocialCreatePostLoadingState());

    if(text != '' || postImage != null){ 
      PostModel postModel = PostModel(
          name: socialUserModel!.name!,
          uId: socialUserModel!.uId!,
          profileImage: socialUserModel!.image!,
          dateTime: dateTime,
          text: text,
          postImage: postImageUrl == null ? '' : postImageUrl );
      FirebaseFirestore.instance.collection('posts').add(postModel.toMap()).then((value) {
        //FirebaseFirestore.instance.collection(collectionPath)
        emit(SocialCreatePostSuccessState());
        removePostImage();
        postImageUrl = null; 
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });

    }
  }

  List<PostModel> postModelList =[];
  List<String> postId =[];
  List<int> likes = [];

  void getPosts(){
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) { 
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length); 
          postId.add(element.id);
          postModelList.add(PostModel.fromjson(element.data()));});
        });

      emit(SocialGetPostsSuccessState());
    }).catchError((error){
      emit(SocialGetPostsErrorState());
    });
  }



  void likePosts(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(socialUserModel!.uId).set({'like' : true}).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error){
      emit(SocialLikePostsErrorState());
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers(){{
    users = [] ;
    emit(SocialGetAllUsersLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != socialUserModel!.uId) {
          users.add(SocialUserModel.fromjson(element.data()));
        }
        emit(SocialGetPostsSuccessState());
      });


    }).catchError((error){
      emit(SocialGetAllUsersErrorState());
    });
  }
  }

  void sendMessage({required String mesg , required String receiverId, required String dateTime}){

    MessageModel messageModel = MessageModel(mesg: mesg,senderId: socialUserModel!.uId,receiverId: receiverId,dateTime: dateTime);
    FirebaseFirestore.instance.collection('users').doc(socialUserModel!.uId).collection('chats').doc(receiverId).collection('messages').add(messageModel.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chats').doc(socialUserModel!.uId).collection('messages').add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
    
  }

  List<MessageModel> messageModelList = [];

  void getMessage({required String receiverId}){


    FirebaseFirestore.instance.collection('users').doc(socialUserModel!.uId).collection('chats').doc(receiverId).collection('messages').orderBy('dateTime').snapshots()
        .listen((event) {
          messageModelList = []; 
          event.docs.forEach((element) { 
            messageModelList.add(MessageModel.fromjson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });

  }



  void logout(context){
    CacheHelper.removeData(key: 'uId').then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SocialLoginScreen()));
      currentIndex= 0;
    });
  }




}
