// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Tools/Custom_Drawer.dart';
import 'package:task_manager/Screens/Home.dart';
import 'package:task_manager/Tools/HomeAppBar.dart';
import 'package:task_manager/Tools/Model.dart';
import 'package:task_manager/Tools/Values.dart';
import 'package:task_manager/Tools/Widgets.dart';

class UpdateUserProfile extends StatefulWidget {
  static const Route = '/UpdateUserProfile';
  UserModle MyData;
  UpdateUserProfile({
    Key? key,
    required this.MyData,
  }) : super(key: key);

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  late UserModle MyData;
  late String MyImage, OldImage;
  TextEditingController UsernameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  @override
  void initState() {
    MyData = widget.MyData;
    MyImage = MyData.Image;
    // OldImage = MyData.Image;
    print(MyImage);

    UsernameController = TextEditingController(text: MyData.Username);
    EmailController = TextEditingController(text: MyData.Email);
    FirstNameController = TextEditingController(text: MyData.FirstName);
    LastNameController = TextEditingController(text: MyData.LastName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Future<bool> _onWillPop() async {
      Navigator.of(context).pushNamed(Home.Route);
      return (true);
    }

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: CustomDrawer(isDark, context, MyData),
          appBar: HomeAppBar("User Profile", context),
          extendBodyBehindAppBar: true,
          body: ListView(children: [
            Container(
                width: width,
                //height: 2.3 / 4 * height,
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
                          child: Image.network(MyImage, //MyData.UserImage,
                              fit: BoxFit.cover,
                              width: width,
                              height: 2.3 / 4 * height)),
                    ),
                    Container(
                        alignment: Alignment.bottomRight,
                        //margin: EdgeInsets.all(5),
                        // padding: EdgeInsets.all(25),
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
                          child: InkWell(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Red),
                                child: Text("Update",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white))),
                            onTap: () async {
                              await UpdateImage(context, 1, 1).then(
                                (value) => setState(() {
                                  MyImage = value;
                                  print(MyImage);
                                }),
                              );
                            },
                          ),
                        ))
                  ],
                )),
            SizedBox(height: 15),
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormFieldMethod(
                      "Username",
                      "Username can't to be larger than 15 letter",
                      "Username can't to be less than 2 letter",
                      Icons.article,
                      "Username",
                      TextInputType.text,
                      15,
                      2,
                      UsernameController),
                  SizedBox(height: 15),
                  TextFormFieldMethod(
                      "Email",
                      "Email can't to be larger than 35 letter",
                      "Email can't to be less than 4 letter",
                      Icons.email,
                      "Email",
                      TextInputType.emailAddress,
                      35,
                      4,
                      EmailController),
                  SizedBox(height: 15),
                  TextFormFieldMethod(
                      "FirstName",
                      "FirstName can't to be larger than 20 digit",
                      "FirstName can't to be less than 2 digit",
                      Icons.phone_iphone,
                      "FirstName",
                      TextInputType.number,
                      20,
                      2,
                      FirstNameController),
                  SizedBox(height: 15),
                  TextFormFieldMethod(
                      "LastName",
                      "LastName can't to be larger than 20 digit",
                      "LastName can't to be less than 2 digit",
                      Icons.phone_iphone,
                      "LastName",
                      TextInputType.number,
                      20,
                      2,
                      LastNameController),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              child: SignInButtonMethod("Update My Information"),
              onTap: () async {
                // var formdata = formstate.currentState;
                // if (formdata!.validate()) {
                //   formdata.save();
                //   //Here We Can Update our information
                //   SnackBarMethod(context, "Your Information Has Been Updated");
                // }
                LottieMethod("Loading");
                var formdata = formstate.currentState;
                if (formdata!.validate()) {
                  formdata.save();
                } else {
                  print("Not Vaild");
                }
              },
            ),
            SizedBox(height: 10),
          ]),
        ));
  }
}


  // Container TextMethod(Color color, double size, String text) {
  //   return Container(
  //       padding: EdgeInsets.only(left: 10),
  //       child: Text(text,
  //           style: TextStyle(
  //               fontSize: size, color: color, fontWeight: FontWeight.bold)));
  // }