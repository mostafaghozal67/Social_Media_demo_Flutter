abstract class SocialLoginStates{}

class SocialLoginIntialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates{
  final String uId ;
  SocialLoginSuccessState(this.uId);

}

class SocialLoginErrorState extends SocialLoginStates{
  late final String error ;
  SocialLoginErrorState(this.error);
}

class SocialChangePasswordvisibilityState extends SocialLoginStates{}
