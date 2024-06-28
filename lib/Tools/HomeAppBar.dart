import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

HomeAppBar(String title, BuildContext context) =>
    //, bool isLanguageArabic, bool isDark
    AppBar(
      actions: [SizedBox(width: 45)],
      backgroundColor: Colors.black,
      title: Center(
          child: Text(title,
              style: TextStyle(
                  // fontSize: isLanguageArabic ? 23 : 19,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'VariableFont_wght',
                  color: Colors.white //isDark ? Colors.white : Colors.black,
                  // color: Colors.white
                  ))),
      iconTheme: IconThemeData(color: Colors.white),
    );
