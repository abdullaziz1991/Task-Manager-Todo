part of 'task_manager_bloc.dart';

@immutable
abstract class TaskManagerState {}

final class TaskManagerInitial extends TaskManagerState {
  TaskManagerInitial();
}

class AllTodosState extends TaskManagerState {
  final List<TodoModle> AllTodos;

  AllTodosState({required this.AllTodos});
  //List<Object> get props => [AllTodos];

  AllTodosState copyWith({
    List<TodoModle>? AllTodos,
  }) {
    return AllTodosState(AllTodos: AllTodos ?? this.AllTodos);
  }

  @override
  List<Object> get props => [AllTodos];
  // @override
  // String toString() => 'TodosLoaded { tpdos $todos }';
}

@immutable
abstract class OfflineDataState {}

class OfflineDataInitial extends OfflineDataState {}

final class InterestsListState extends OfflineDataState {
  InterestsListState();
}
