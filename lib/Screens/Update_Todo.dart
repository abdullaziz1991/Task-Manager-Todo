// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:task_manager/Tools/Dropdown_Buttons.dart';
import 'package:task_manager/Tools/HomeAppBar.dart';
import 'package:task_manager/Tools/Model.dart';
import 'package:task_manager/Tools/SqlLite.dart';
import 'package:task_manager/Tools/Values.dart';
import 'package:task_manager/Tools/Widgets.dart';
import 'package:task_manager/bloc/task_manager_bloc.dart';

class UpdateTodo extends StatefulWidget {
  static const Route = '/UpdateTodo';
  List<TodoModle> AllTodos;
  TodoModle Todos;
  UserModle MyData;
  UpdateTodo({
    Key? key,
    required this.AllTodos,
    required this.Todos,
    required this.MyData,
  }) : super(key: key);
  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController TodoController = TextEditingController();
  late List<TodoModle> AllTodos;
  late TodoModle Todos;
  late String Priority = PriorityList[0], Completed = TodoStateList[0];
  DateTime date = DateTime(2024, 1, 1), CurrentDate = DateTime.now();
  var Date = "Please Set The Date", TheTime = "Please Set The Time";
  bool isDateSet = false, isTimeSet = false;
  late int PriorityNumber;
  int _currentValue = 3;
  void _updateValue(DropdownButtonModle NewDropdownValue) {
    setState(() {
      if (NewDropdownValue.Sign == 'Priority') {
        Priority = NewDropdownValue.NewValue;
        PriorityNumber = NewDropdownValue.IndexValue;
      }
      if (NewDropdownValue.Sign == 'Completed') {
        Completed = NewDropdownValue.NewValue;
      }
    });
  }

  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";

  @override
  void initState() {
    AllTodos = widget.AllTodos;
    Todos = widget.Todos;
    TodoController = TextEditingController(text: Todos.Todo_Text);
    Todos.Todo_Priority == ""
        ? Priority = PriorityList[0]
        : Priority = Todos.Todo_Priority;
    Todos.Todo_Date == ""
        ? Date = "Please Set The Date"
        : Date = Todos.Todo_Date;
    Todos.Todo_Time == ""
        ? TheTime = "Please Set The Time"
        : TheTime = Todos.Todo_Time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: HomeAppBar("Update Todo", context),
      body: Form(
        key: formstate,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              TextFormFieldMethod(
                  "Todo",
                  "Todo can't to be larger than 200 letter",
                  "Todo can't to be less than 2 letter",
                  Icons.article,
                  "Todo",
                  TextInputType.text,
                  200,
                  2,
                  TodoController),
              SizedBox(height: 15),
              DropdownButtons(
                Sign: 'Priority',
                initialValue: Priority,
                list: PriorityList,
                icon: Icons.add_circle,
                NewDropdownValue: _updateValue,
              ),
              SizedBox(height: 15),

              DateMethod(width, context),
              SizedBox(height: 15),
              // TimePickerMethod(),
              TimePickerMethod(width, context),
              SizedBox(height: 15),
              InkWell(
                child: SignInButtonMethod("Add"),
                onTap: () {
                  if (TodoController.text != "" &&
                      Date != "" &&
                      TheTime != "") {
                    context.read<TaskManagerBloc>().add(AddTodosEvent(
                        UserId: widget.MyData.Id,
                        Todo: TodoController.text.toString(),
                        Priority: Priority,
                        context: context,
                        AllTodos: AllTodos,
                        Todo_Date: Date,
                        Todo_Time: TheTime,
                        Completed: Completed));
                    showLoading(context, "Add Todo",
                        "The Todo has been added successfully");
                  } else {
                    SnackBarMethod(
                        context, "You Forgot To Fill In One Of The Fields");
                  }
                },
              ),
              SizedBox(height: 15),
              InkWell(
                child: SignInButtonMethod("drop table"),
                onTap: () {
                  SqfLite sqflite = SqfLite();
                  sqflite.DropTableAndCreateNewOne();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container DateMethod(double width, BuildContext context) {
    return Container(
        width: width - 20,
        height: 65,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
          // border: Border(
          //   bottom: BorderSide(width: 1.0, color: Colors.black),
          // ),
        ),
        child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(Icons.calendar_today, color: Colors.orange),
                  SizedBox(width: 10),
                  Center(child: Text(Date, style: TextStyle(fontSize: 16))),
                ]),
                Icon(isDateSet ? Icons.done_all : Icons.close,
                    color: isDateSet ? Colors.orange : Colors.red),
              ],
            ),
            onTap: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2100));
              if (newDate == null) return;
              setState(() {
                date = newDate as DateTime;

                Date = "${date.year}/${date.month}/${date.day}";
                DateTime birthDate = DateTime(date.year, date.month, date.day);

                CurrentDate.compareTo(date) > 0
                    ? {
                        Date = "Please Set The Date",
                        isDateSet = false,
                        SnackBarMethod(context, "You Have Entered An Old Date")
                      }
                    : {Date, isDateSet = true};
              });
            }));
  }

  Container TimePickerMethod(double width, BuildContext context) {
    return Container(
        width: width - 20,
        height: 65,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          // border: Border(
          //   bottom: BorderSide(width: 1.0, color: Colors.black),
          // ),
          border: Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
        ),
        child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(Icons.schedule, color: Colors.orange),
                  SizedBox(width: 10),
                  Center(child: Text(TheTime, style: TextStyle(fontSize: 16))),
                ]),
                Icon(isTimeSet ? Icons.done_all : Icons.close,
                    color: isTimeSet ? Colors.orange : Colors.red),
              ],
            ),
            onTap: () async {
              TheTime = await showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          content: Builder(builder: (context) {
                            var width = MediaQuery.of(context).size.width;
                            return Container(
                                alignment: Alignment.center,
                                height: 260,
                                width: width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        NumberPicker(
                                          minValue: 0,
                                          maxValue: 12,
                                          value: hour,
                                          zeroPad: true,
                                          infiniteLoop: true,
                                          itemWidth: 80,
                                          itemHeight: 60,
                                          onChanged: (value) {
                                            setState(() {
                                              hour = value;
                                              print(hour);
                                            });
                                          },
                                          textStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 20),
                                          selectedTextStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                bottom: BorderSide(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        NumberPicker(
                                          minValue: 0,
                                          maxValue: 59,
                                          value: minute,
                                          zeroPad: true,
                                          infiniteLoop: true,
                                          itemWidth: 80,
                                          itemHeight: 60,
                                          onChanged: (value) {
                                            setState(() {
                                              minute = value;
                                            });
                                          },
                                          textStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 20),
                                          selectedTextStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                bottom: BorderSide(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      timeFormat = "AM";
                                                    });
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              timeFormat == "AM"
                                                                  ? Colors.grey
                                                                      .shade800
                                                                  : Colors.grey
                                                                      .shade700,
                                                          border: Border.all(
                                                            color: timeFormat ==
                                                                    "AM"
                                                                ? Colors.grey
                                                                : Colors.grey
                                                                    .shade700,
                                                          )),
                                                      child: const Text(
                                                        "AM",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25),
                                                      ))),
                                              const SizedBox(height: 15),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      timeFormat = "PM";
                                                    });
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              timeFormat == "PM"
                                                                  ? Colors.grey
                                                                      .shade800
                                                                  : Colors.grey
                                                                      .shade700,
                                                          border: Border.all(
                                                              color: timeFormat ==
                                                                      "PM"
                                                                  ? Colors.grey
                                                                  : Colors.grey
                                                                      .shade700)),
                                                      child: const Text(
                                                        "PM",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25),
                                                      )))
                                            ])
                                      ]),
                                  InkWell(
                                      child: SignInButtonMethod("OK"),
                                      onTap: () {
                                        setState(() {
                                          var NewTime =
                                              "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, "0")} ${timeFormat}";
                                          Navigator.pop(context, NewTime);
                                          isTimeSet = true;
                                        });
                                      })
                                ]));
                          }));
                    });
                  });
              setState(() {
                TheTime;
              });
            }));
  }
}
