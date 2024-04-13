import 'package:first_project/layouts/social_app/cubit/SocialLayout_cubit.dart';
import 'package:first_project/layouts/social_app/cubit/SocialLayout_states.dart';
import 'package:first_project/moduels/social_app/edit_profile/edit_profile_screen.dart';
import 'package:first_project/shared/network/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var usermodel = SocialCubit.get(context).socialUserModel;
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => usermodel!= null,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(image: NetworkImage(usermodel!.cover!),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64.0,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(usermodel.image!),
                        ),
                      )


                    ],
                  ),
                ),
                const SizedBox(height: 5.0,),
                Text(usermodel.name!, style: Theme.of(context).textTheme.titleLarge,),
                const SizedBox(height: 10.0,),
                Text(usermodel.bio!, style: Theme.of(context).textTheme.bodySmall,),
                //const SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(children: [
                          Text("100", style: Theme.of(context).textTheme.titleSmall,),
                          Text("Posts", style: Theme.of(context).textTheme.bodySmall,),

                        ],),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(children: [
                          Text("265", style: Theme.of(context).textTheme.titleSmall,),
                          Text("Photos", style: Theme.of(context).textTheme.bodySmall,),

                        ],),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(children: [
                          Text("100", style: Theme.of(context).textTheme.titleSmall,),
                          Text("Followers", style: Theme.of(context).textTheme.bodySmall,),

                        ],),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(children: [
                          Text("64", style: Theme.of(context).textTheme.titleSmall,),
                          Text("Following", style: Theme.of(context).textTheme.bodySmall,),

                        ],),
                      ),
                    ),
                  ],),
                ),
                Row(children: [
                  Expanded(
                    child: OutlinedButton(onPressed: () {  }, child: const Text("Add photos",style: TextStyle(color: Colors.blue),),),
                  ),
                  const SizedBox(width: 10.0,),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                    },
                    child: const Icon(
                      IconBroken.Edit,
                      size: 16.0,
                      color: Colors.blue,),)
                ],)
              ],
            ),
          ) ,
          fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),

        );
      },

    );
  }
}
