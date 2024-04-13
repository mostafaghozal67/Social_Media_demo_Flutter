import 'package:first_project/layouts/social_app/cubit/SocialLayout_cubit.dart';
import 'package:first_project/layouts/social_app/cubit/SocialLayout_states.dart';
import 'package:first_project/models/social_app/message_model.dart';
import 'package:first_project/models/social_app/social_user_model.dart';
import 'package:first_project/shared/network/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {


  SocialUserModel? RecieverModel; 
  ChatDetailsScreen({this.RecieverModel});

  var messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Builder( 
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(receiverId: RecieverModel!.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
            listener: (context , states){},
            builder: (context , states){
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(children: [
                    CircleAvatar(
                      radius:20.0,
                      backgroundImage: NetworkImage(RecieverModel!.image!),
                    ),
                    const SizedBox(width: 15.0 ,),
                    Text(RecieverModel!.name!)
                  ],),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context , index) {
                              var message = SocialCubit.get(context).messageModelList[index];
                              if(SocialCubit.get(context).socialUserModel!.uId == message.senderId)
                                return SenderMessage(message);
                              else
                                return ReceiverMessage(message);
                            },
                            separatorBuilder: (context , index) => const SizedBox(height: 15.0,),
                            itemCount: SocialCubit.get(context).messageModelList.length),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.0
                            ),
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(border: InputBorder.none, hintText: "write your message",),
                                  controller: messageController,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            Container(
                                height: 50.0,
                                width: 50.0,
                                color: Colors.blue,
                                child: MaterialButton(onPressed: (){
                                  SocialCubit.get(context).sendMessage(mesg: messageController.text, receiverId: RecieverModel!.uId!, dateTime: DateTime.now().toString());
                                } , child: const Icon(IconBroken.Send,size: 16.0,color: Colors.white,),))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }

        );
      },

    );
  }

  Widget SenderMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0
      ),
      child: Text(messageModel.mesg),

    ),
  );

  Widget ReceiverMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.7),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0
      ),
      child: Text(messageModel.mesg),

    ),
  ) ;
}
