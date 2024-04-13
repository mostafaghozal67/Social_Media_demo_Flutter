import 'package:flutter/cupertino.dart';
class PostModel{
  late String name;
  late String uId;
  late String profileImage;
  late String dateTime;
  late String text;
  late String? postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.profileImage,
    required this.dateTime,
    required this.text,
    this.postImage
  });

  PostModel.fromjson(Map<String ,dynamic>json){
    name = json['name'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String ,dynamic>toMap(){
    return {
      'name' : name,
      'uId' : uId,
      'profileImage' : profileImage,
      'dateTime' : dateTime,
      'text' : text,
      'postImage' : postImage
    };


  }

}