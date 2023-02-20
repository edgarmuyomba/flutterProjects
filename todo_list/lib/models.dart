class Task {
  String description;
  DateTime due;
  String status = 'Incomplete';

  Task(
    this.description,
    this.due,
    this.status,
  );
}
