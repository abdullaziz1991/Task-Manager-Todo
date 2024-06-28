import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Screens/Home.dart';
import 'package:task_manager/Tools/Model.dart';
import 'package:task_manager/Tools/SqlLite.dart';
import 'package:task_manager/Tools/Values.dart';
import 'package:task_manager/Tools/Widgets.dart';
import 'package:task_manager/main.dart';
import 'package:http/http.dart' as http;
part 'task_manager_event.dart';
part 'task_manager_state.dart';

class TaskManagerBloc extends Bloc<TaskManagerEvent, TaskManagerState> {
  TaskManagerBloc() : super(TaskManagerInitial()) {
    //AllTodos: []
    on<TaskManagerEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignInEvent>((event, emit) async {
      Uri url = Uri.parse(Serverlogin);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'username': event.Username,
        'password': event.Password,
        'expiresInMins': 30, // optional, defao 60
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        UserModle MyData = UserModle(
          Id: data['id'].toString(),
          Username: data['username'].toString(),
          Email: data['email'].toString(),
          FirstName: data['firstName'].toString(),
          LastName: data['lastName'].toString(),
          Gender: data['gender'].toString(),
          Image: data['image'].toString(),
          Token: data['token'].toString(),
          RefreshToken: data['refreshToken'].toString(),
        );
        SharedPrefs _sharedPrefs = SharedPrefs();
        _sharedPrefs.Id = data['id'].toString();
        _sharedPrefs.Username = data['username'].toString();
        _sharedPrefs.Email = data['email'].toString();
        _sharedPrefs.FirstName = data['firstName'].toString();
        _sharedPrefs.LastName = data['lastName'].toString();
        _sharedPrefs.Gender = data['gender'].toString();
        _sharedPrefs.Image = data['image'].toString();
        _sharedPrefs.Token = data['token'].toString();
        _sharedPrefs.RefreshToken = data['refreshToken'].toString();
        Navigator.pushReplacement(
          event.context,
          CupertinoPageRoute(builder: (context) => MyApp()),
        );
      } else {
        print('Failed to login: ${response.statusCode}');
        SnackBarMethod(event.context, "The User isnot Exists");
      }
    });

    on<GetTodosEvent>((event, emit) async {
      Uri url = Uri.parse(ServerGetTodosUser + event.UserId);
      List<TodoModle> AllTodos = event.AllTodos;
      SqfLite sqflite = SqfLite();
      List<Map> AllSqlData = [];
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //  print(data);
        for (var element in data["todos"]) {
          AllSqlData = await sqflite.readData("SELECT * FROM 'todos'");
          if (AllSqlData.length != 0) {
            bool exists = AllSqlData.any(
                (item) => item['id_In_Server'] == element['id'].toString());
            if (exists) {
              continue;
            } else {
              await sqflite.insertData(
                  "INSERT INTO  'todos' (id_In_Server, todo,completed,Todo_Priority,Todo_Date,Todo_Time) VALUES ('${element['id'].toString()}','${element['todo'].toString()}','${element['completed'].toString()}','','','')");
            }
          } else {
            await sqflite.insertData(
                "INSERT INTO  'todos' (id_In_Server, todo,completed,Todo_Priority,Todo_Date,Todo_Time) VALUES ('${element['id'].toString()}','${element['todo'].toString()}','${element['completed'].toString()}','','','')");
          }
        }

        AllSqlData = await sqflite.readData("SELECT * FROM 'todos'");
        for (var item in AllSqlData) {
          TodoModle Todo = TodoModle(
            Todo_Id: item['id_In_Server'].toString(),
            Id_In_SqlLite: item['id'].toString(),
            Todo_Text: item['todo'],
            Todo_Completed: item['completed'].toString(),
            Todo_Priority: item['Todo_Priority'].toString(),
            Todo_Date: item['Todo_Date'].toString(),
            Todo_Time: item['Todo_Time'].toString(),
          );
          AllTodos.add(Todo);
          List<Map> response2 = await sqflite.readData("SELECT * FROM 'todos'");
          print(response2);
        }
      } else {
        print('Failed to login: ${response.statusCode}');
        SnackBarMethod(event.context, "The User isnot Exists");
      }
      emit(AllTodosState(AllTodos: AllTodos));
    });

    on<DeleteTodosEvent>((event, emit) async {
      SqfLite sqflite = SqfLite();
      List<TodoModle> AllTodos = event.AllTodos;
      final url = Uri.parse(ServerEditTodo + event.TodosId);
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to Delete Todo: ${response.statusCode}');
      }
      int response3 = await sqflite
          .deleteData("DELETE FROM 'todos' WHERE id =${event.SqlLiteId}");
      AllTodos.removeWhere((element) {
        return element.Id_In_SqlLite == event.SqlLiteId;
      });
      emit(AllTodosState(AllTodos: AllTodos));
    });

    on<AddTodosEvent>((event, emit) async {
      SqfLite sqflite = SqfLite();
      List<TodoModle> AllTodos = event.AllTodos;
      Uri url = Uri.parse(ServerAddNewTodo);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'todo': event.Todo,
        'completed': event.Completed == "Completed" ? true : false,
        'userId': event.UserId,
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print(data);
        String isCompleted = event.Completed == "Completed" ? "true" : "false";
        int Response = await sqflite.insertData(
            "INSERT INTO  'todos' (id_In_Server, todo,completed,Todo_Priority,Todo_Date,Todo_Time) VALUES ('${data['id'].toString()}','${event.Todo}','$isCompleted','${event.Priority}','${event.Todo_Date}','${event.Todo_Time}')");
        print(Response);
        TodoModle Todo = TodoModle(
          Todo_Id: data['id'].toString(),
          Id_In_SqlLite: Response.toString(),
          Todo_Text: event.Todo,
          Todo_Completed: isCompleted,
          Todo_Priority: event.Priority,
          Todo_Date: event.Todo_Date,
          Todo_Time: event.Todo_Time,
        );
        AllTodos.add(Todo);
      } else {
        print('Failed to Add Todo : ${response.statusCode}');
        SnackBarMethod(event.context, "Failed to Add Todo");
      }
      emit(AllTodosState(AllTodos: AllTodos));
    });

    on<UpdateTodosEvent>((event, emit) async {
      SqfLite sqflite = SqfLite();
      List<TodoModle> AllTodos = event.AllTodos;
      final url = Uri.parse(ServerEditTodo + event.TodosId);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'todo': event.Todo,
        'completed': bool.parse(event.Completed),
        'userId': event.UserId,
      });

      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to Update Todo : ${response.statusCode}');
      }
      int response2 = await sqflite.updateData(
          "UPDATE 'todos' SET 'todo'='${event.Todo}','completed'='${event.Completed}','Todo_Priority'='${event.Priority}','Todo_Date'='${event.Todo_Date}','Todo_Time'='${event.Todo_Time}' WHERE id =${event.SqlLiteId}");
      for (int i = 0; i < AllTodos.length; i++) {
        if (AllTodos[i].Id_In_SqlLite == event.SqlLiteId) {
          AllTodos[i].Todo_Text = event.Todo;
          AllTodos[i].Todo_Priority = event.Priority;
          AllTodos[i].Todo_Date = event.Todo_Date;
          AllTodos[i].Todo_Time = event.Todo_Time;
          AllTodos[i].Todo_Completed = event.Completed;
        }
      }
      Navigator.of(event.context).pushReplacementNamed(Home.Route);
      emit(AllTodosState(AllTodos: AllTodos));
    });
  }
}
