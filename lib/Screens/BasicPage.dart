// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/Screens/Add_Todo.dart';

import 'package:task_manager/Tools/Model.dart';
import 'package:task_manager/Tools/SqlLite.dart';
import 'package:task_manager/Screens/Update_Todo.dart';
import 'package:task_manager/Tools/Values.dart';
import 'package:task_manager/Tools/Widgets.dart';
import 'package:task_manager/bloc/task_manager_bloc.dart';
import 'package:task_manager/main.dart';

class BasicPage extends StatefulWidget {
  UserModle MyData;
  BasicPage({
    required this.MyData,
  });

  @override
  State<BasicPage> createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  late UserModle MyData;
  @override
  void initState() {
    MyData = widget.MyData;
    print(MyData.Email);

    super.initState();
  }

  int currentPage = 0;
  final int itemsPerPage = 5;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<TodoModle> AllTodos = [];

    return Scaffold(
      body: MyData.Email != ""
          ? BlocBuilder<TaskManagerBloc, TaskManagerState>(
              builder: (context, state) {
                if (state is AllTodosState) {
                  AllTodos = state.AllTodos;
                  int totalPages =
                      (state.AllTodos.length / itemsPerPage).ceil();
                  List<TodoModle> getCurrentPageItems() {
                    int start = currentPage * itemsPerPage;
                    int end = start + itemsPerPage;
                    return state.AllTodos.sublist(
                        start,
                        end > state.AllTodos.length
                            ? state.AllTodos.length
                            : end);
                  }

                  return state.AllTodos.length != 0
                      ? Scaffold(
                          floatingActionButton: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            margin: const EdgeInsets.only(bottom: 50),
                            child: FloatingActionButton.extended(
                              backgroundColor: Blue,
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => AddTodo(
                                            AllTodos: AllTodos,
                                            MyData: MyData)));
                              },
                              label: Text('Add',
                                  style: TextStyle(color: Colors.white)),
                              icon: Icon(Icons.add,
                                  color: Colors.white, size: 25),
                            ),
                          ),
                          body: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/background.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    //  itemCount: state.AllTodos.length,
                                    itemCount: getCurrentPageItems().length,
                                    //   key: Key(state.AllTodos.length.toString()),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      TodoModle item =
                                          getCurrentPageItems()[index];
                                      return InkWell(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(
                                              top: 10, right: 10, left: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Blue,
                                          ),
                                          width: width,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    value: bool.parse(
                                                        item.Todo_Completed),
                                                    onChanged: (ValueKey) {
                                                      print(
                                                          ValueKey.toString());

                                                      context
                                                          .read<
                                                              TaskManagerBloc>()
                                                          .add(UpdateTodosEvent(
                                                              UserId: MyData.Id,
                                                              context: context,
                                                              AllTodos:
                                                                  AllTodos,
                                                              TodosId: state
                                                                  .AllTodos[
                                                                      index]
                                                                  .Todo_Id,
                                                              SqlLiteId: state
                                                                  .AllTodos[
                                                                      index]
                                                                  .Id_In_SqlLite,
                                                              Todo: state
                                                                  .AllTodos[
                                                                      index]
                                                                  .Todo_Text,
                                                              Completed: ValueKey
                                                                  .toString(),
                                                              Priority: state
                                                                  .AllTodos[
                                                                      index]
                                                                  .Todo_Priority,
                                                              Todo_Date: state
                                                                  .AllTodos[
                                                                      index]
                                                                  .Todo_Date,
                                                              Todo_Time: state
                                                                  .AllTodos[
                                                                      index]
                                                                  .Todo_Time));
                                                    },
                                                    checkColor: Colors.white,
                                                    // focusColor: Colors.white,
                                                    //fillColor: Colors.black,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Todo : ${item.Todo_Text}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Visibility(
                                                        visible:
                                                            item.Todo_Date !=
                                                                "",
                                                        child: Text(
                                                          "Date : ${item.Todo_Date}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible:
                                                            item.Todo_Time !=
                                                                "",
                                                        child: Text(
                                                          "Time : ${item.Todo_Time}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible:
                                                            item.Todo_Priority !=
                                                                "",
                                                        child: Text(
                                                          "Priority :  ${item.Todo_Priority}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Positioned(
                                                right: 15,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                                title: Text(
                                                                    "Delete Todo"),
                                                                content: Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 50,
                                                                    child: Text(
                                                                        "Are you sure you want to delete the Todo?")),
                                                                actions: [
                                                                  ElevatedButton(
                                                                      child: Text(
                                                                          "Ok"),
                                                                      onPressed:
                                                                          () {
                                                                        context.read<TaskManagerBloc>().add(DeleteTodosEvent(
                                                                            UserId: MyData
                                                                                .Id,
                                                                            context:
                                                                                context,
                                                                            Process:
                                                                                "Delete",
                                                                            TodosId:
                                                                                state.AllTodos[index].Todo_Id,
                                                                            SqlLiteId: state.AllTodos[index].Id_In_SqlLite,
                                                                            AllTodos: AllTodos));
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      })
                                                                ]);
                                                          });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 55,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                UpdateTodo(
                                                                    AllTodos:
                                                                        AllTodos,
                                                                    MyData:
                                                                        MyData,
                                                                    Todos: AllTodos[
                                                                        index])),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Text('Page ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Blue,
                                            child: Text("${currentPage + 1}",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          Text(' of ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          CircleAvatar(
                                            backgroundColor: Blue,
                                            radius: 13,
                                            child: Text("$totalPages",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: IconButton(
                                              icon: Icon(Icons.arrow_back,
                                                  color: Colors.white),
                                              onPressed: currentPage > 0
                                                  ? () {
                                                      setState(() {
                                                        currentPage--;
                                                      });
                                                    }
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(width: 7),
                                          CircleAvatar(
                                            backgroundColor: Blue,
                                            child: IconButton(
                                              icon: Icon(Icons.arrow_forward,
                                                  color: Colors.white),
                                              onPressed:
                                                  currentPage < totalPages - 1
                                                      ? () {
                                                          setState(() {
                                                            currentPage++;
                                                          });
                                                        }
                                                      : null,
                                            ),
                                          ),
                                          SizedBox(width: 12)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          floatingActionButtonLocation:
                              FloatingActionButtonLocation.endFloat,
                        )
                      : Scaffold(
                          floatingActionButton: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            margin: const EdgeInsets.only(bottom: 50),
                            child: FloatingActionButton.extended(
                              backgroundColor: Blue,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => AddTodo(
                                            AllTodos: AllTodos,
                                            MyData: MyData)));
                              },
                              label: Text('Add',
                                  style: TextStyle(color: Colors.white)),
                              icon: Icon(Icons.add,
                                  color: Colors.white, size: 25),
                            ),
                          ),
                          body: CenterTextMethod("You didn't Add Any Todo"),
                          floatingActionButtonLocation:
                              FloatingActionButtonLocation.endFloat,
                        );
                }
                return LottieMethod("Loading");
              },
            )
          : CenterTextMethod("You are not logged in"),
    );
  }
}

  // Scaffold(
                  //     floatingActionButton: FloatingActionButton.extended(
                  //       backgroundColor: Blue,
                  //       onPressed: () {},
                  //       label: Text('Add',
                  //           style: TextStyle(color: Colors.white)),
                  //       icon:
                  //           Icon(Icons.add, color: Colors.white, size: 25),
                  //     ),
                  //     body: CenterTextMethod("You didn't sell anything"));