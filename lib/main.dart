import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_project/layouts/social_app/cubit/SocialLayout_cubit.dart';
import 'package:first_project/layouts/social_app/cubit/SocialLayout_states.dart';
import 'package:first_project/layouts/social_app/social_layout.dart';
import 'package:first_project/shared/bloc_observer.dart';
import 'package:first_project/shared/components/constants.dart';
import 'package:first_project/shared/network/local/cache_helper.dart';
import 'package:first_project/shared/network/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'moduels/social_app/login/social_login_screen.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  Bloc.observer = MyBlocObserver();
  //DioHelper.init();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Widget startwidget ;
  if( uId != null)
    startwidget = SocialLayout();
  else
    startwidget = SocialLoginScreen();

  runApp(Myapp(startwidget));
}
class Myapp extends StatelessWidget{
  final Widget StartWidget ;
  Myapp(this.StartWidget);

  @override
  Widget build(BuildContext context){

    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()
        )
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: StartWidget,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light

          );
        },

      ),
    );

  }

}







