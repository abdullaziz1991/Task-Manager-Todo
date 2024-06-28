// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Screens/Home.dart';
import 'package:task_manager/Tools/Model.dart';
import 'package:task_manager/Screens/Update_UserProfile.dart';
import 'package:task_manager/Tools/Values.dart';
import 'package:task_manager/Tools/Widgets.dart';

class UserProfile extends StatefulWidget {
  static const Route = '/UserProfile';
  UserModle MyData;
  UserProfile({
    Key? key,
    required this.MyData,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserModle MyData;
  late String MyImage;

  @override
  void initState() {
    MyData = widget.MyData;
    MyImage = widget.MyData.Image; //SharedPrefs().UserImage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    // bool isLanguageArabic = context.locale.languageCode == "ar";
    Future<bool> _onWillPop() async {
      Navigator.of(context).pushNamed(Home.Route);
      return (true);
    }

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: ListView(children: [
            Container(
                width: width,
                height: width,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black)),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.black)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(MyImage,
                              fit: BoxFit.cover,
                              width: width,
                              height: 2.3 / 4 * height)),
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        //  margin: EdgeInsets.all(5),
                        width: width,
                        height: width,
                        child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(20),
                            height: 1 / 8 * height,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.2)),
                                // borderRadius: BorderRadius.only(
                                //     bottomLeft: Radius.circular(25),
                                //     bottomRight: Radius.circular(25)),
                                borderRadius: BorderRadius.circular(25)),
                            child: TextShadowMethod()))
                  ],
                )),
            SizedBox(height: 5),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextMethod(Colors.black, 18, "${MyData.Email}"),
                            TextMethod(Colors.black54, 15,
                                "Full Name : ${MyData.FirstName} ${MyData.LastName}"),
                            TextMethod(
                                Colors.black54, 15, "Gender : ${MyData.Gender}")
                          ])
                    ])),
          ]),
        ));
  }

  Container TextMethod(Color color, double size, String text) {
    //, bool isLanguageArabic
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: Text(text,
            style: TextStyle(
                fontSize: size, color: color, fontWeight: FontWeight.bold)));
  }

  Row TextShadowMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Stack(children: <Widget>[
            Text(MyData.Username,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold))
          ]),
          SizedBox(width: 10),
          Icon(Icons.whatshot, color: Red)
        ]),
        InkWell(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Red),
              child: Text("Edit",
                  style: TextStyle(fontSize: 16, color: Colors.white))),
          onTap: () async {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateUserProfile(MyData: MyData)));
          },
        )
      ],
    );
  }
}
