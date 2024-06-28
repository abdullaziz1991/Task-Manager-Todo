import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Tools/Model.dart';
import 'package:task_manager/Tools/SqlLite.dart';
import 'package:task_manager/Screens/Update_UserProfile.dart';
import 'package:task_manager/Screens/UserProfile.dart';
import 'package:task_manager/Tools/Widgets.dart';
import 'package:task_manager/main.dart';

SqfLite sqflite = SqfLite();
CustomDrawer(bool isDark, BuildContext context, UserModle MyData) => Drawer(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              InkWell(
                  onTap: () {
                    //  Navigator.pushNamed(context, SetProfileImage.Route);
                  },
                  child: UserAccountsDrawerHeader(
                      decoration:
                          BoxDecoration(color: Color.fromARGB(255, 11, 8, 59)),
                      currentAccountPicture: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: const Color(0xFF778899),
                          backgroundImage: NetworkImage(MyData.Image)),
                      accountEmail: Container(
                          child: Text(
                        MyData.Username,
                        style: TextStyle(color: Colors.white),
                      )),
                      accountName: Container(
                          child: Text(MyData.Email,
                              style: TextStyle(color: Colors.white))))),
              drawerItem(Icons.manage_accounts, "My Profile", context,
                  UpdateUserProfile.Route),
              drawerItem(Icons.logout, "Sign Out", context, "")
            ]),
          )
        ],
      ),
    );

ListTile drawerItem(
  IconData iconItem,
  String title,
  BuildContext context,
  String root,
) {
  return ListTile(
    onTap: () {
      if (root != "") {
        Navigator.of(context).pushReplacementNamed("$root");
      } else {
        SharedPrefs _sharedPrefs = SharedPrefs();
        _sharedPrefs.Id = "";
        _sharedPrefs.Username = "";
        _sharedPrefs.Email = "";
        _sharedPrefs.FirstName = "";
        _sharedPrefs.LastName = "";
        _sharedPrefs.Gender = "";
        _sharedPrefs.Image = "";
        _sharedPrefs.Token = "";
        _sharedPrefs.RefreshToken = "";
        sqflite.DropTableAndCreateNewOne();
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => MyApp()),
        );
      }
    },
    leading: Icon(
      iconItem,
      size: 28,
      color: Colors.red,
    ),
    title: Text(
      "$title",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

class AppColors {
  static var primary = Colors.blue;
}
