import 'package:firebase_auth/firebase_auth.dart';
import 'package:flut_task/cubit/login_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/get_my_post/my_post_cubit.dart';
import 'cubit/get_my_post/my_post_state.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {




  _blocBuilder(){
    return BlocBuilder<MyPostCubit,MyPostsState>(
        builder:(context,state){


          if (state is MyPostsLoadingState) {


            return Center(child: CircularProgressIndicator(),);
          }
          if (state is MyPostsLoadedState) {


            return ListView.builder(
              itemCount: state.posts.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var post =state.posts[index];
                return Container(
                  margin: EdgeInsets.all(1),

                  child: Card(elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(post.title,style: TextStyle(fontSize: 18),),
                        ),
                        subtitle: Text(post.body,style: TextStyle(fontSize: 12),),

                      ),
                    ),
                  ),
                );
              },
            );
          }
          return  Center(child: Text("error"),);
        });
  }
  String displayName="";
  String email="";
  bool init=true;
  void uiChanges() async{
    var user =await FirebaseAuth.instance.currentUser;
    displayName=user?.displayName??"";
    email=user?.email??"";
    setState(() {

    });
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(init){
      uiChanges();
      init=false;

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
                  BlocProvider.of<LoginServices>(context).signOut();

                },
                child: Container(
                  margin: EdgeInsets.only(right: 40,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 5,),
                      Text("Logout",textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png"??""),
              ),
              SizedBox(height: 10,),
              Text(displayName??"",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(email??""),
              SizedBox(height: 20,),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    SizedBox(height: 10,),
                    Text("My Post",style: TextStyle(fontSize: 18,color: Colors.orange,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    _blocBuilder()
                  ],)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
