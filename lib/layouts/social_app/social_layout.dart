import 'package:first_project/layouts/social_app/cubit/SocialLayout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/network/styles/icon_broken.dart';
import 'cubit/SocialLayout_states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(cubit.titels[cubit.currentIndex]),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IconButton(onPressed: (){
                  SocialCubit.get(context).logout(context);
                }, icon: const Icon(IconBroken.Logout,color: Colors.blue,)),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index){
              cubit.changeBottomNav(index);
            },
            items: const [
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Chat),
              label: "Chats"),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Setting),
              label: "Settings")
          ],),

        );
      },

    );
  }
}
