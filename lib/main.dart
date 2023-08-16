import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flut_task/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/create_post.dart';
import 'cubit/create_post/create_post.dart';
import 'cubit/feed/feed_cubit.dart';
import 'cubit/get_my_post/my_post_cubit.dart';
import 'cubit/login_services.dart';
import 'home_activity.dart';
import 'login_page.dart';
//late final FirebaseApp app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391

  // We store the app and auth to make testing with a named instance easier.
  await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
  );
  // auth = FirebaseAuth.instance.authStateChanges().;
  //
  // if (shouldUseFirebaseEmulator) {
  //   await auth.useAuthEmulator('localhost', 9099);
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<LoginServices>(
          create: (context) => LoginServices(),
        ), BlocProvider<FeedCubit>(
          create: (context) => FeedCubit(),
        ),BlocProvider<MyPostCubit>(
          create: (context) => MyPostCubit(),
        ),
        BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(),
        ),

      ],
      child: MaterialApp(
        routes: {
          "/home":(ctx)=>HomeActivity(),
          "/login":(ctx)=>LoginActivity(),
          "/dash_board":(ctx)=>MyHomePage()
        },
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const LoginActivity(),
      //home: const HomeActivity(),
      //home: MyHomePage(title: 'hj',),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var lightBlack =Color(int.parse("0xff35364a"));
  var backGroundColor =Color(int.parse("0xff1e223d"));
  var unselectedColors =Color(int.parse("0xff656673"));
  //for second audio

  @override
  void initState() {
    super.initState();

  }



  static const List<Widget> _pages = <Widget>[
    HomeActivity(),
    CreatePost(),
    UserProfile(),

  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        // showSelectedLabels: true,
        // showUnselectedLabels: false,
        // selectedItemColor: Colors.lightBlue,
        selectedLabelStyle: TextStyle(color: Colors.lightBlue),
        unselectedItemColor: unselectedColors,
        items:  [
          BottomNavigationBarItem(
            // icon: Icon(Icons.home),
            icon:Icon(Icons.cabin),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
      ),
    );
  }
}
