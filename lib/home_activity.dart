import 'package:flut_task/cubit/feed/feed_cubit.dart';
import 'package:flut_task/cubit/feed/feed_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {

  _blocBuilder(){
    return BlocBuilder<FeedCubit,FeedState>(
        builder:(context,state){

          // if (state is FeedErrorState) {
          //   print("djllkdsskldsklkldkldkslkldskldklerror "+state.error.toString());
          //   return Container();
          // }
          if (state is FeedLoadingState) {

            //BlocProvider.of<BookLanguageCubit>(context).currentLanguagePage=1;
            //Navigator.of(context).pushNamed("home");
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is FeedLoadedState) {

            //BlocProvider.of<BookLanguageCubit>(context).currentLanguagePage=1;
            //Navigator.of(context).pushNamed("home");
            return Expanded(
              child: ListView.builder(
                itemCount: state.posts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var post =state.posts[index];
                  return Container(

                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Card(elevation: 5,
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
              ),
            );
          }
          return  Center(child: Text("error"),);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 22,),
            Text("Feed Post",style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),
            _blocBuilder()
          ],
        ),
      ),
    );
  }
}
