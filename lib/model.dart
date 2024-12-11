class Folder {
  final int id; 
  final String title;
  final List<Task> tasks;

  Folder({required this.id, required this.title, required this.tasks});
}

class Task {
  final int id;
  final int folderId;
  final String title;

  Task({required this.id, required this.folderId, required this.title});
}