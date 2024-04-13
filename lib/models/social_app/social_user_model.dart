class SocialUserModel{

  late String? name;
  late String? email;
  late String? phone;
  late String? uId;
  late bool? isEmailVerified;
  late String? image;
  late String? cover;
  late String? bio;

  SocialUserModel({this.name,this.email,this.phone,this.uId,this.isEmailVerified,this.image,this.cover,this.bio});

  
  SocialUserModel.fromjson(Map<String,dynamic>json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    cover = json['cover'];
    bio = json['Bio'];
  }
  
  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'isEmailVerified' : isEmailVerified,
      'image' : image,
      'cover' : cover,
      'Bio' : bio


    };
  }


}
