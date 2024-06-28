// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:task_manager/Screens/BasicPage.dart';
import 'package:task_manager/Tools/Custom_Drawer.dart';
import 'package:task_manager/Tools/HomeAppBar.dart';
import 'package:task_manager/Tools/Model.dart';
import 'package:task_manager/Screens/UserProfile.dart';
import 'package:task_manager/bloc/task_manager_bloc.dart';

class Home extends StatefulWidget {
  static const Route = '/Home';
  UserModle MyData;
  Home({
    Key? key,
    required this.MyData,
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UserModle MyData;
  int _selectedScreenIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
      if (_selectedScreenIndex == 0) {
        // Navigator.pushReplacement(
        //   context,
        //   CupertinoPageRoute(builder: (context) => MyApp()),
        // );
      }
    });
  }

  @override
  void initState() {
    MyData = widget.MyData;
    BlocProvider.of<TaskManagerBloc>(context).add(GetTodosEvent(
        UserId: MyData.Id,
        context: context,
        Process: "Get All Todos",
        TodosId: '',
        SqlLiteId: '',
        AllTodos: []));
    //  InterestsList = MyData.InterestsList.map(int.parse).toList()..sort();
    // BlocProvider.of<ShoppingBloc>(context).add(AllProductEvent(
    //     Username: MyData.Username,
    //     SearchText: '',
    //     SearchType: 1,
    //     InterestsList: InterestsList));
    super.initState();
  }

  // @override
  // void didChangeDependencies() async {
  //   //  MyData = widget.MyData;

  //   //MyData.InterestsList
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    List<Map<String, Object>> _screens = [
      {'Screen': BasicPage(MyData: MyData), 'Title': "Basic Page"},
      {'Screen': BasicPage(MyData: MyData), 'Title': "Basic Page"},

      //{'Screen': Sales(MyData: MyData), 'Title': "Sales".tr()},
      {'Screen': UserProfile(MyData: MyData), 'Title': "Profile"},
    ];

    return Scaffold(
      drawer: CustomDrawer(isDark, context, MyData),
      appBar: HomeAppBar(
          _screens[_selectedScreenIndex]['Title'] as String, context),
      // isLanguageArabic, isDark,
      body: _screens[_selectedScreenIndex]['Screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Colors.black,
        selectedItemColor: Color.fromARGB(255, 233, 162, 8),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Basic Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cabin),
            label: "Sales",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
