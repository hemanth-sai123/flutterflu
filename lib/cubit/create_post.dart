import 'package:flut_task/cubit/create_post/create_post.dart';
import 'package:flut_task/cubit/create_post/create_post_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _title =TextEditingController();
  TextEditingController _body =TextEditingController();
  TextEditingController _reaction=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void createPost(){
    if(_formKey.currentState!.validate()){
      BlocProvider.of<CreatePostCubit>(context).createPost();
    }

  }
  Widget _uiWidget(){
      return  Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            //color: index==0?Colors.red:Colors.white,
            // border: Border.all(
            //   color: Colors.red,
            // ),
              color: Colors.lightBlue,
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          //#FE724C

          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
                onTap: () {
                  createPost();
                  //isLogin?loginServices.login(_emailController.text,_passwordController.text):loginServices.register(_emailController.text,_passwordController.text);
                  //Navigator.of(context).pushNamed("/main");
                },
                child: Center(
                  child: Text(
                    "POST",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          )
      );
  }
  _bloclistener(BuildContext context1){
    return BlocListener<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
      if (state is CreatePostLoadedState) {
        ScaffoldMessenger.of(context1).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Post Created Successfuly',style: TextStyle(color: Colors.white),),
          ),
        );
      }
    },child: _blocBuilder());
  }
  _blocBuilder(){
    return BlocBuilder<CreatePostCubit,CreatePostState>(
        builder:(context,state){

          if (state is CreatePostLoadingState) {

            return Center(child: CircularProgressIndicator(),);
          }
          if (state is CreatePostLoadedState) {


            return _uiWidget();
          }
          if (state is CreatePostErrorState) {

            return Center(child: Text("error"),);
          }

          return  _uiWidget();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[ Text("Create your Post",style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),)]),
                 SizedBox(height: 30,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  controller: _title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                  onChanged: (text) {
                    setState(() {
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter body';
                    }
                    return null;
                  },
                  maxLines: 3,
                  controller: _body,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  onChanged: (text) {
                    setState(() {
                      // fullName = text;
                      //you can access nameController in its scope to get
                      // the value of text entered as shown below
                      //fullName = nameController.text;
                    });
                  },
                ),

          SizedBox(height: 10,),
         _bloclistener(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


