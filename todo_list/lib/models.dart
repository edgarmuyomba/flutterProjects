class Task {
  String description;
  String status;
  String details;

  Task({
    required this.description,
    this.status = 'Incomplete',
    this.details = '',
  });
}
