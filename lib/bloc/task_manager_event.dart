// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_manager_bloc.dart';

sealed class TaskManagerEvent extends Equatable {
//  const TaskManagerEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends TaskManagerEvent {
  String Username;
  String Password;

  BuildContext context;
  SignInEvent(
      {required this.Username, required this.Password, required this.context});
}

// class AllTodosEvent extends TaskManagerEvent {
//   String UserId;
//   String Process;
//   String TodosId;
//   String SqlLiteId;
//   List<TodoModle> AllTodos;
//   BuildContext context;
//   AllTodosEvent({
//     required this.UserId,
//     required this.Process,
//     required this.TodosId,
//     required this.SqlLiteId,
//     required this.AllTodos,
//     required this.context,
//   });
// }

class GetTodosEvent extends TaskManagerEvent {
  String UserId;
  String Process;
  String TodosId;
  String SqlLiteId;
  List<TodoModle> AllTodos;
  BuildContext context;
  GetTodosEvent({
    required this.UserId,
    required this.Process,
    required this.TodosId,
    required this.SqlLiteId,
    required this.AllTodos,
    required this.context,
  });
  List<Object> get props =>
      [UserId, Process, TodosId, SqlLiteId, AllTodos, context];
}

class DeleteTodosEvent extends TaskManagerEvent {
  String UserId;
  String Process;
  String TodosId;
  String SqlLiteId;
  List<TodoModle> AllTodos;
  BuildContext context;
  DeleteTodosEvent({
    required this.UserId,
    required this.Process,
    required this.TodosId,
    required this.SqlLiteId,
    required this.AllTodos,
    required this.context,
  });
  List<Object> get props =>
      [UserId, Process, TodosId, SqlLiteId, AllTodos, context];
}

class AddTodosEvent extends TaskManagerEvent {
  String UserId;
  String Todo;
  String Priority;
  String Completed;
  String Todo_Date;
  String Todo_Time;
  List<TodoModle> AllTodos;
  BuildContext context;
  AddTodosEvent({
    required this.UserId,
    required this.Todo,
    required this.Priority,
    required this.Completed,
    required this.Todo_Date,
    required this.Todo_Time,
    required this.AllTodos,
    required this.context,
  });
  List<Object> get props => [UserId, AllTodos, context];
}

class UpdateTodosEvent extends TaskManagerEvent {
  String UserId;
  // TodoModle Todos;
  String TodosId;
  String SqlLiteId;
  String Todo;
  String Completed;
  String Priority;
  String Todo_Date;
  String Todo_Time;
  List<TodoModle> AllTodos;
  BuildContext context;
  UpdateTodosEvent({
    required this.UserId,
    required this.TodosId,
    required this.SqlLiteId,
    required this.Todo,
    required this.Completed,
    required this.Priority,
    required this.Todo_Date,
    required this.Todo_Time,
    required this.AllTodos,
    required this.context,
  });
  // List<Object> get props => [UserId, TodosId, SqlLiteId, AllTodos, context];
}

@immutable
abstract class OfflineDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InterestsListEvent extends OfflineDataEvent {
  String Product_ID;

  InterestsListEvent({
    required this.Product_ID,
  });
}
