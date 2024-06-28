// ignore_for_file: public_member_api_docs, sort_constructors_first

import "dart:io";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:image_picker/image_picker.dart";
import "package:lottie/lottie.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:task_manager/Screens/Home.dart";
import "package:task_manager/Tools/Values.dart";

showLoading(BuildContext context, String Title, String Message) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(Title),
            content: Container(
                width: double.infinity, height: 50, child: Text(Message)),
            actions: [
              ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ]);
      });
}

void SnackBarMethod(BuildContext context, String Message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(Message),
      backgroundColor: Blue,
    ),
  );
}

Center CenterTextMethod(String Message) => Center(
        child: Text(
      Message,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ));

class SharedPrefs {
  late final SharedPreferences _sharedPrefs;
  static final SharedPrefs _instance = SharedPrefs._internal();
  factory SharedPrefs() => _instance;
  SharedPrefs._internal();
  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  String get Id => _sharedPrefs.getString("Id") ?? "";
  set Id(String value) {
    _sharedPrefs.setString("Id", value);
  }

  String get Username => _sharedPrefs.getString("Username") ?? "";
  set Username(String value) {
    _sharedPrefs.setString("Username", value);
  }

  String get Email => _sharedPrefs.getString("Email") ?? "";
  set Email(String value) {
    _sharedPrefs.setString("Email", value);
  }

  String get FirstName => _sharedPrefs.getString("FirstName") ?? "";
  set FirstName(String value) {
    _sharedPrefs.setString("FirstName", value);
  }

  String get LastName => _sharedPrefs.getString("LastName") ?? "";
  set LastName(String value) {
    _sharedPrefs.setString("LastName", value);
  }

  String get Gender => _sharedPrefs.getString("Gender") ?? "";
  set Gender(String value) {
    _sharedPrefs.setString("Gender", value);
  }

  String get Image => _sharedPrefs.getString("Image") ?? "";
  set Image(String value) {
    _sharedPrefs.setString("Image", value);
  }

  String get Token => _sharedPrefs.getString("Token") ?? "";
  set Token(String value) {
    _sharedPrefs.setString("Token", value);
  }

  String get RefreshToken => _sharedPrefs.getString("RefreshToken") ?? "";
  set RefreshToken(String value) {
    _sharedPrefs.setString("RefreshToken", value);
  }
}

Opacity topImageMethod(double opacity) {
  return Opacity(
      opacity: opacity,
      child: Container(
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/images/background_top.png",
            width: double.infinity,
          )));
}

Opacity bottomImageMethod(double opacity, double height) {
  return Opacity(
      opacity: opacity,
      child: Container(
          alignment: Alignment.bottomLeft,
          height: height,
          width: double.infinity,
          child: Image.asset(
            "assets/images/background_bottom.png",
            width: double.infinity,
          )));
}

Center LottieMethod(String Image) {
  return Center(
      child: Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          child:
              Lottie.asset("assets/Animation/$Image.json", fit: BoxFit.cover)));
}

RatingBar ratingMethod(
    String RatingNumber, bool ignoreGestures, Color unratedColor) {
  return RatingBar.builder(
    ignoreGestures: ignoreGestures,
    itemSize: 25,
    initialRating: double.parse(RatingNumber),
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    updateOnDrag: true,
    unratedColor: unratedColor,
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
    onRatingUpdate: (rating) {
      print(rating);
    },
  );
}

Container SignInButtonMethod(String title) {
  return Container(
    alignment: Alignment.center,
    child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.orange,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 17,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.bold),
          // style: Theme.of(context).textTheme.headline6,
        )),
  );
}

Container TextFormFieldMethod(
    String value,
    String validator1,
    String validator2,
    IconData icon,
    String label,
    // bool isDark,
    TextInputType textInputType,
    int MaxLenght,
    int MinLenght,
    TextEditingController controllers) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(
      controller: controllers,
      // style: TextStyle(color: isDark ? Colors.white : Colors.black),
      validator: (val) {
        if (val!.length > MaxLenght) {
          return validator1;
        }
        if (val.length < MinLenght) {
          return validator2;
        }

        if (label == "Email" && (val == null || val.isEmpty)) {
          return 'Please enter your email';
        }
        // Simple regex for email validation
        final RegExp emailRegex = RegExp(
          r'^[^@]+@[^@]+\.[^@]+',
        );
        if (!emailRegex.hasMatch(val)) {
          return 'Please enter a valid email address';
        }

        return null;
      },

      keyboardType: textInputType,
      //  obscureText: true,
      maxLines: value == "Todo" ? 10 : 1,

      minLines: 1,
      // maxLines: 10,
      inputFormatters: [
        LengthLimitingTextInputFormatter(MaxLenght),
      ],
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.orange,
          ),
          //hintText: value,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(width: 1, color: Colors.black),
          )),
    ),
  );
}

Future<String> UpdateImage(
    BuildContext context, double ratioX, double ratioY) async {
  String NewImage = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text("Choose an image",
                style: TextStyle(), textAlign: TextAlign.center),
            content: Container(
                height: MediaQuery.of(context).size.height / 6,
                child: Column(children: [
                  ElevatedButton(
                      onPressed: () async {
                        await getImage(ImageSource.gallery, ratioX, ratioY)
                            .then((value) => Navigator.pop(context, value));
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.image),
                            SizedBox(width: 10),
                            Text("From the gallery")
                          ])),
                  ElevatedButton(
                      onPressed: () async {
                        await getImage(ImageSource.camera, ratioX, ratioY)
                            .then((value) => Navigator.pop(context, value));
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.camera),
                            SizedBox(width: 10),
                            Text("From the camera"),
                          ]))
                ])));
      });
  return NewImage;
}

Future<String> getImage(ImageSource media, double ratioX, double ratioY) async {
  String NewImage = "";
  var pickedImage = await ImagePicker().pickImage(source: media);
  File image = File(pickedImage!.path);
  // final CroppedImage = await ImageCropper().cropImage(
  //   sourcePath: image.path,
  //   aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
  //   uiSettings: [
  //     AndroidUiSettings(
  //       toolbarTitle: 'Crop Image',
  //       toolbarColor: Colors.deepOrange,
  //       toolbarWidgetColor: Colors.white,
  //       initAspectRatio: CropAspectRatioPreset.square,
  //       lockAspectRatio: true,
  //     ),
  //     IOSUiSettings(
  //       title: 'Crop Image',
  //     ),
  //   ],
  // );
  // var postUri = Uri.parse(ServerUrl + "addImage.php");
  // http.MultipartRequest request = http.MultipartRequest("POST", postUri);
  // http.MultipartFile multipartFile =
  //     await http.MultipartFile.fromPath("image", CroppedImage!.path);
  // request.files.add(multipartFile);
  // http.StreamedResponse response = await request.send();
  NewImage = image!.path.split('/').last;
  return NewImage;
}
