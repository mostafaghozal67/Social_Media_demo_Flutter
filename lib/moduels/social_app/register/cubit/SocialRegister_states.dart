
abstract class SocialRegisterStates{}

class SocialRegisterIntialState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates{
  //final ShopLoginModel shopLoginModel;
  //ShopRegisterSuccessState(this.shopLoginModel);
}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterErrorState extends SocialRegisterStates{}

class SocialChangePasswordvisibilityState extends SocialRegisterStates{}

class SocialCreateUserSuccessState extends SocialRegisterStates{
  final String uId ;
  SocialCreateUserSuccessState(this.uId);
}

//class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialCreateUserErrorState extends SocialRegisterStates{}
