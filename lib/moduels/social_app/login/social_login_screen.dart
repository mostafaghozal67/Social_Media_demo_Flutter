import 'package:first_project/layouts/social_app/cubit/SocialLayout_cubit.dart';
import 'package:first_project/layouts/social_app/social_layout.dart';
import 'package:first_project/moduels/social_app/login/cubit/SocialLogin_cubit.dart';
import 'package:first_project/shared/components/constants.dart';
import 'package:first_project/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../../shared/components/components.dart';
import '../register/social_register_screen.dart';
import 'cubit/SocialLogin_states.dart';

class SocialLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context , state){
          if(state is SocialLoginErrorState) {
            ShowToast(mesg: state.error, color: Colors.red);
          }
          if(state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              if(value){
                uId = state.uId;
                SocialCubit.get(context).socialUserModel = null;
                SocialCubit.get(context).getUserData();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SocialLayout()));
              }

            });
          }
        },
        builder: (context , state){
          var LoginCubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login", style: Theme.of(context).textTheme.headlineLarge,),
                        const SizedBox(height: 5.0,),
                        Text("Login now to communicate with friends",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),),
                        const SizedBox(height: 30.0,),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty || value == null) {
                              return "Please enter your email address";
                            }
                          },
                          label: "Email Address",
                          prefix: Icons.email_outlined,
                        ),//DefaultFromField
                        const SizedBox(height: 15.0 ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value){
                              if(value!.isEmpty || value == null) {
                                return "Please enter your password";
                              }
                            },
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                LoginCubit.userLogin(email: emailController.text, password: passwordController.text);
                              }
                            },
                            label: "Password",
                            prefix: Icons.lock_outline,
                            isPassword: LoginCubit.isPasswordShown,
                            suffix: LoginCubit.suffix,
                            suffixPressed: (){
                              LoginCubit.changePasswordVisibility();
                            }
                        ),//DefaultFormField
                        const SizedBox(height: 30.0,),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) => state is! SocialLoginLoadingState,
                            widgetBuilder: (context) => defaultButton(
                                onpressed: (){
                                  if(formKey.currentState!.validate()){
                                    LoginCubit.userLogin(email: emailController.text, password: passwordController.text);
                                  }
                                },
                                text: "Login", isUpperCase: true) ,
                            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator())
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account ?"),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SocialRegisterScreen()));
                            }, child: Text("Register Now".toUpperCase()))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}

