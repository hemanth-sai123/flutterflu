import 'package:firebase_auth/firebase_auth.dart';
import 'package:flut_task/cubit/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_services.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  bool isLogin=true;
  // LoginServices loginServices=LoginServices();
  TextEditingController _emailController =TextEditingController();
  TextEditingController _userNameController =TextEditingController();
  TextEditingController _passwordController =TextEditingController();
  _blocListener(BuildContext context1){
    return BlocListener<LoginServices, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            
            ScaffoldMessenger.of(context1).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.error,style: TextStyle(color: Colors.white),),
              ),
            );
          }
          if(state is LoginLoadedState){
            BlocProvider.of<LoginServices>(context).emit(LoginInitialState());
            Navigator.of(context).pushNamed("/dash_board");
          }
        },child: _blocBuilder());
  }
  _uiWidget(){
    return  Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(

            color: Colors.lightBlue,
            borderRadius:
            BorderRadius.all(Radius.circular(10))),
        //#FE724C

        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: InkWell(
              onTap: () {
                var loginServices =BlocProvider.of<LoginServices>(context);
                if(_formKey.currentState!.validate()){
                  isLogin?loginServices.login(_emailController.text,_passwordController.text):loginServices.register(_emailController.text,_passwordController.text,_userNameController.text);
                }

                //Navigator.of(context).pushNamed("/main");
              },
              child: Center(
                child: Text(
                  isLogin?"Login":"Registor",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              )),
        )
    );
  }
  _blocBuilder(){
    return BlocBuilder<LoginServices,LoginState>(
        builder:(context,state){

          if (state is LoginErrorState) {
            print("djllkdsskldsklkldkldkslkldskldklerror "+state.error.toString());
            return _uiWidget();
          }
          if (state is LoginLoadingState) {

            //BlocProvider.of<BookLanguageCubit>(context).currentLanguagePage=1;
             //Navigator.of(context).pushNamed("home");
            return Center(child: CircularProgressIndicator(),);
          }
          if (state is LoginLoadedState) {

            //BlocProvider.of<BookLanguageCubit>(context).currentLanguagePage=1;

            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushNamed("/dash_board");
              
            });


           // _bloc.dispatch(NavigationComplete());
            return Container();
          }
          return _uiWidget();
        });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(

        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image.asset("assets/images/logo.png",width: 150,),
                isLogin?Container():Column(
                  children: [
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter user name';
                        }
                        return null;
                      },
                      controller: _userNameController,
                      decoration: InputDecoration(
                        border: null,
                        labelText: 'user name',
                      ),

                      onChanged: (text) {
                        setState(() {

                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (val) => val!.isEmpty || !val.contains("@")
          ? "enter a valid eamil"
          : null,
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) {
                    setState(() {

                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PassWord',

                  ),


                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (text) {
                    setState(() {

                    });
                  },
                ),
                SizedBox(height: 10,),
                //_blocBuilder(),
                _blocListener(context),
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isLogin?"Don't have an account? ":"Already have an account? ",
                        style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w100)),

                    InkWell(
                      onTap: (){
                        setState(() {
                          isLogin=!isLogin;
                        });

                      },
                      child: Text(isLogin?"Register":"Login",
                          style: TextStyle(fontSize: 16, color: Colors.lightBlue,fontWeight: FontWeight.bold)),
                    )
                  ],
                )

              ],
            ),
          ),
        )
      ),
    );
  }


}

