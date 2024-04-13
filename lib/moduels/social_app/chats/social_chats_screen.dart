import 'package:first_project/layouts/social_app/cubit/SocialLayout_cubit.dart';
import 'package:first_project/layouts/social_app/cubit/SocialLayout_states.dart';
import 'package:first_project/models/social_app/social_user_model.dart';
import 'package:first_project/moduels/social_app/chat_details/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state){},
      builder: (context , state){
        var socialCubit = SocialCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => socialCubit.users.length > 0,
          widgetBuilder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildChatItem(context,socialCubit.users[index]),
              separatorBuilder: (context,index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: socialCubit.users.length),
          fallbackBuilder: (context) => const Center(child: CircularProgressIndicator())
        );


      }

    );
  }

  buildChatItem(context,SocialUserModel socialUserModel) => InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(RecieverModel: socialUserModel,))); // bb3tlo al data bta3t al user aly b3ml click 3leh
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(socialUserModel.image!),),
          const SizedBox(width: 15.0,),
          Text(socialUserModel.name!)
        ],
      ),
    ),
  );
}
