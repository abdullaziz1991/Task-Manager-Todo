// Const

import 'package:flutter/material.dart';

//Icons.local_fire_department

Color Red = Color.fromARGB(255, 214, 16, 9);
Color Blue = Color.fromARGB(255, 1, 29, 78);
Color Green = Color.fromRGBO(82, 170, 94, 1.0);

String ServerUrl = 'https://dummyjson.com/';
String Serverlogin = ServerUrl + "auth/login";
String ServerAllTodos = ServerUrl + "todos?limit=3000&skip=10";
String ServerAddNewTodo = ServerUrl + "todos/add";
//String ServerAddNewTodo = "https://dummyjson.com/todos/add";
//String ServerAddNewTodo = ServerAllTodos + "/add";
String ServerGetTodosUser = ServerUrl + "todos/user/";
//String ServerGetTodosUser = "https://dummyjson.com/todos/user/24";
String ServerEditTodo = ServerUrl + "todos/";

List<String> PriorityList = [
  "Ordinary importance",
  "Important",
  "Highly important"
];

List<String> TodoStateList = ["Not Completed", "Completed"];
