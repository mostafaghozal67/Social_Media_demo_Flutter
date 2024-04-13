import 'package:first_project/layouts/social_app/cubit/SocialLayout_cubit.dart';
import 'package:first_project/layouts/social_app/cubit/SocialLayout_states.dart';
import 'package:first_project/shared/network/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../../models/social_app/social_post_model.dart';
import '../../../shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  

  var postcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var socialCubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state){},
      builder: (context , state){
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => socialCubit.postModelList.length > 0 && socialCubit.socialUserModel != null ,
          widgetBuilder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                          children:[
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(SocialCubit.get(context).socialUserModel!.image!),
                            ),
                            const SizedBox(width: 10.0,),
                            Form(
                              key: formKey,
                              child: Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: "What's on your mind ..",
                                      border: InputBorder.none
                                  ),
                                  controller: postcontroller,
                                  validator: (value){
                                    if((value!.isEmpty || value == null) && SocialCubit.get(context).postImage == null)
                                      ShowToast(mesg: "Post must not be empty", color: Colors.red);
                                    //return "Post must not be empty";
                                  },
                                ),
                              ),
                            ),
                            IconButton(onPressed: (){
                              SocialCubit.get(context).getPostImage();
                            }, icon: const Icon(IconBroken.Image,color: Colors.blue,)),
                            IconButton(onPressed: (){
                              if(formKey.currentState!.validate() || SocialCubit.get(context).postImage != null){
                                SocialCubit.get(context).createNewPost(dateTime: DateTime.now().toString(), text: postcontroller.text);
                                postcontroller.text=''; 
                                // SocialCubit.get(context).getPosts();
                              }

                            }, icon: const Icon(IconBroken.Edit,color: Colors.blue,)),
                          ]
                      ),
                      if(SocialCubit.get(context).postImage != null)
                        const SizedBox(height: 10.0,),
                      if(SocialCubit.get(context).postImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 140.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(image:FileImage(SocialCubit.get(context).postImage!),
                                    fit: BoxFit.cover) ,
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).removePostImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.close,color: Colors.white,size: 16.0,)))
                          ],
                        ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index) => buildPostItem(context,SocialCubit.get(context).postModelList[index],index),
                  itemCount: SocialCubit.get(context).postModelList.length,
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10.0,),),
                const SizedBox(height: 8.0,)

              ],),
          ),
          fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),
        ) ;
      },

    );
  }
  Widget buildPostItem(context,PostModel postModel,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer, 
    color: Colors.white,
    //elevation: 10.0,
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start ,children: [
        Row(children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(postModel.profileImage),
          ),
          const SizedBox(width: 15.0,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(postModel.name,style: const TextStyle(height: 1.4),),
                  const SizedBox(width: 5.0,),
                  const Icon(Icons.check_circle,color: Colors.blue,size: 16.0,)
                ],
              ),
              Text(postModel.dateTime,style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4,color: Colors.grey),)
            ],)),
          const SizedBox(width: 15.0,),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz,size: 16.0,))
        ],),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Text(postModel.text, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black, height: 1.3,),),
        const SizedBox(height: 12.0,),
        if(postModel.postImage != '')
          Container(
          height: 140.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(image: NetworkImage(postModel.postImage!),
                fit: BoxFit.cover,
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(children: [
                      const Icon(IconBroken.Heart,size: 16.0,color: Colors.red,),
                      const SizedBox(width: 5.0,),
                      Text("${SocialCubit.get(context).likes[index]}")
                    ],),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end ,
                      children: [
                        Icon(IconBroken.Chat,size: 16.0,color: Colors.amber,),
                        SizedBox(width: 5.0,),
                        Text("0 comment")
                      ],),
                  ),
                ),
              ),
            ],),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(SocialCubit.get(context).socialUserModel!.image!),
                    ),
                    const SizedBox(width: 15.0,),
                    Text("Write a comment ..",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),)
                  ],),
              ),
            ),
            InkWell(
              onTap: (){
                SocialCubit.get(context).likePosts(SocialCubit.get(context).postId[index]);
              },
              child: const Row(children: [
                Icon(IconBroken.Heart,size: 16.0,color: Colors.red,),
                SizedBox(width: 5.0,),
                Text("Like")
              ],),
            ),
          ],)

      ],),
    ),
  );
}
