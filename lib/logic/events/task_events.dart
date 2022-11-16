abstract class TaskEvent {}

class TextChangeEvent extends TaskEvent {
  final String title;
  final String description;
  TextChangeEvent(this.title, this.description);
}

class SubmittedEvent extends TaskEvent {
  final String title;
  final String description;
  final String type;
  final String iid;
  SubmittedEvent(this.title, this.description, this.type, this.iid);
}

class UpdateEvent extends TaskEvent {
  final String title;
  final String description;
  final String type;
  UpdateEvent(this.title, this.description, this.type);
}
