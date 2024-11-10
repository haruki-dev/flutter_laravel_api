import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';


class TodoApi{
  static const String requestFolder = 'http://10.0.2.2/api/folders';
  static const String requestTask = 'http://10.0.2.2/api/tasks';

  static Future<List<Folder>> fetchData() async {

    final responseFolder = await http.get(Uri.parse(requestFolder));
    final responseTask = await http.get(Uri.parse(requestTask));

  if (responseFolder.statusCode == 200){

    final List<dynamic> folders = jsonDecode(responseFolder.body)['folders'];
    final List<dynamic> tasks = jsonDecode(responseTask.body)['tasks'];

    final Map<int, List<Task>> tasksByFolderId = {};

    for (var task in tasks) {
      tasksByFolderId.putIfAbsent(task['folder_id'], () => []).add(
        Task(
          id: task['id'],
          folderId: task['folder_id'],
          title: task['title']
        ),
      );
    }
    print(tasksByFolderId);
    return folders.map((folderData) {
      final folder = Folder(
        id: folderData['id'],
        title: folderData['title'],
        tasks: tasksByFolderId[folderData['id']] ?? [],
      );
      print(folder);
      return folder;
    }).toList();

  } else {

    throw Exception('Failed');

  }
}
      // return titles;
      // } else if(responseTask.statusCode == 200){
      // final Map<String, dynamic> jsonTask = jsonDecode(responseTask.body);
      // final List<dynamic> tasks = jsonTask['tasks'];








  // static Future<List> fetchFolders() async {
  //   final response = await http.get(Uri.parse(requestFolder));
  //   if (response.statusCode == 200){
  //     final Map<String, dynamic> jsonList = jsonDecode(response.body);
  //     final List<dynamic> folders = jsonList['folders'];
  //     final List<String> titles = folders.map((folder) => folder['title'] as String).toList();
  //     // print(folders);
  //     // print(titles);
  //     return titles;
  //     } else {
  //       throw Exception('Failed');
  //     }
  // }


  // static Future<List> fetchFolderID() async {
  //   final response = await http.get(Uri.parse(requestFolder));
  //   if (response.statusCode == 200){
  //     final Map<String, dynamic> jsonList = jsonDecode(response.body);
  //     final List<dynamic> folders = jsonList['folders'];
  //     // ignore: non_constant_identifier_names
  //     final List<String> folder_id = folders.map((folder) => folder['id'] as String).toList();
  //     return folder_id;
  //     } else {
  //       throw Exception('Failed');
  //     }
  // }

  // static Future<List> fetchTasks() async {
  //   final response = await http.get(Uri.parse(requestTask));
  //   if (response.statusCode == 200){
  //     final Map<String, dynamic> jsonList = jsonDecode(response.body);
  //     final List<dynamic> tasks = jsonList['tasks'];
  //     final List<String> titles = tasks.map((task) => task['title'] as String).toList();
  //     // print(tasks);
  //     // print(titles);
  //     return titles;
  //     } else {
  //       throw Exception('Failed');
  //     }
  // }


  // static Future<List> fetchTaskID() async {
  //   final response = await http.get(Uri.parse(requestTask));
  //   if (response.statusCode == 200){
  //     final Map<String, dynamic> jsonList = jsonDecode(response.body);
  //     final List<dynamic> tasks = jsonList['tasks'];
  //     // ignore: non_constant_identifier_names
  //     final List<String> task_id = tasks.map((folder) => folder['folder_id'] as String).toList();
  //     // print(tasks);
  //     // print(titles);
  //     return task_id;
  //     } else {
  //       throw Exception('Failed');
  //     }
  // }

}