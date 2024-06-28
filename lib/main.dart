import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/Screens/Home.dart';
import 'package:task_manager/Tools/Model.dart';
import 'package:task_manager/Screens/Sign_In.dart';
import 'package:task_manager/Screens/Update_UserProfile.dart';
import 'package:task_manager/Screens/UserProfile.dart';
import 'package:task_manager/Tools/SqlLite.dart';
import 'package:task_manager/Tools/Widgets.dart';
import 'package:task_manager/bloc/task_manager_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  await SqfLite().intialDb();
  // SqfLite sqflite = SqfLite();
  // sqflite.DropTableAndCreateNewOne();
  // FlutterNativeSplash.remove();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => TaskManagerBloc()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    UserModle MyData = UserModle(
      Email: SharedPrefs().Email,
      Username: SharedPrefs().Username,
      Id: SharedPrefs().Id,
      Gender: SharedPrefs().Gender,
      FirstName: SharedPrefs().FirstName,
      LastName: SharedPrefs().LastName,
      Image: SharedPrefs().Image,
      Token: SharedPrefs().Token,
      RefreshToken: SharedPrefs().RefreshToken,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyData.Username != "" ? Home(MyData: MyData) : SignIn(),
      routes: {
        Home.Route: (context) => Home(MyData: MyData),
        SignIn.Route: (context) => SignIn(),
        UserProfile.Route: (context) => UserProfile(MyData: MyData),
        UpdateUserProfile.Route: (context) => UpdateUserProfile(MyData: MyData),
      },
    );
  }
}
