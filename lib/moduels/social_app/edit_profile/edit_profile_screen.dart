import 'package:first_project/layouts/social_app/cubit/SocialLayout_cubit.dart';
import 'package:first_project/layouts/social_app/cubit/SocialLayout_states.dart';
import 'package:first_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../../shared/network/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var namecontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var phonecontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state){},
      builder: (context , state) {
        var usermodel = SocialCubit.get(context).socialUserModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        return Conditional.single(
            context: context,
            conditionBuilder:(context) =>  usermodel != null,
            widgetBuilder: (context) {
              namecontroller.text = usermodel!.name! ;
              biocontroller.text = usermodel.bio! ;
              phonecontroller.text = usermodel.phone!;
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(IconBroken.Arrow___Left_2),
                    onPressed: () {
                      Navigator.pop(context);
                    },),
                  title: const Text("Edit Profile"),
                  titleSpacing: 5.0,
                  actions: [
                    TextButton(onPressed: (){
                      SocialCubit.get(context).updateUser(name: namecontroller.text, bio: biocontroller.text , phone: phonecontroller.text );
                    }, child: const Text("UPDATE",style: TextStyle(fontSize: 16.0,color: Colors.blue),)),
                    const SizedBox(width: 15.0,)
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      if(state is SocialUserUpdateLoadingState)
                        const LinearProgressIndicator(),
                      Container(
                        height: 190.0,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 140.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                        image: DecorationImage(image: coverImage == null ? NetworkImage(usermodel.cover!) : FileImage(coverImage) as ImageProvider ,
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        SocialCubit.get(context).getCoverImage();
                                      },
                                      icon: const CircleAvatar(
                                          radius: 20.0,
                                          backgroundColor: Colors.blue,
                                          child: Icon(IconBroken.Camera,size: 16.0,))),

                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64.0,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: profileImage == null ? NetworkImage(usermodel.image!) : FileImage(profileImage) as ImageProvider,
                                  ),
                                ),
                                IconButton(
                                    onPressed: (){
                                      SocialCubit.get(context).getProfileImage();
                                    },
                                    icon: const CircleAvatar(
                                        radius: 20.0,
                                        backgroundColor: Colors.blue,
                                        child: Icon(IconBroken.Camera,size: 16.0,))),
                              ],
                            )


                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      defaultFormField(
                          controller: namecontroller,
                          type: TextInputType.name,
                          validate: (value){
                            if(value!.isEmpty || value == null) {
                              return "Name must not be empty";
                            }
                          },
                          label: "Name",
                          prefix: IconBroken.User),
                      const SizedBox(height: 10.0,),
                      defaultFormField(
                          controller: biocontroller,
                          type: TextInputType.text,
                          validate: (value){
                            if(value!.isEmpty || value == null) {
                              return "Bio must not be empty";
                            }
                          },
                          label: "Bio",
                          prefix: IconBroken.Info_Circle),
                      const SizedBox(height: 10.0,),
                      defaultFormField(
                          controller: phonecontroller,
                          type: TextInputType.phone,
                          validate: (value){
                            if(value!.isEmpty || value == null) {
                              return "Phone Number must not be empty";
                            }
                          },
                          label: "Phone",
                          prefix: IconBroken.User),

                    ],),
                  ),
                ),

              );
            },
            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()));

      },

    );
  }
}
