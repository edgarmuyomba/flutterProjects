class Task {
  String description;
  String status;
  String details;
  String due;

  Task({
    required this.description,
    this.status = 'Incomplete',
    this.details = '',
    this.due = '',
  });
}
