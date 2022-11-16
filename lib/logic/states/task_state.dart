abstract class TaskState {}

class InitialState extends TaskState {}

class ValidState extends TaskState {}

class EditState extends TaskState {}

class LoadingState extends TaskState {}

class ErrorState extends TaskState {
  final String errorMessage;
  ErrorState(this.errorMessage);
}

class ApiSuccessState extends TaskState {}

class ApiFailState extends TaskState {}
