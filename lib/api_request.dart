import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'new_folder.dart';


class TodoApi{
  static const String requestFolder = 'http://10.0.2.2/api/folders/';  // Androidエミュレーターを使用する場合は左記のIPアドレスでないとアクセスできない。通常はlocalhostおよび127.0.0.1:8000とかでいい
  static const String requestTask = 'http://10.0.2.2/api/tasks/';  // Androidエミュレーターを使用する場合は左記のIPアドレスでないとアクセスできない。通常はlocalhostおよび127.0.0.1:8000とかでいい


  static Future<List<Folder>> fetchData() async { 

    final responseGetFolder = await http.get(Uri.parse(requestFolder));  // requestFolderの文字列をURI形式に変換して、それに対してgetリクエストを送っている

    if (responseGetFolder.statusCode == 200){

      final List<dynamic> folders = jsonDecode(responseGetFolder.body)['folders'];
      final List<Folder> parsedFolders = folders.map((folderData) { // foldersリストから1要素ずつ抜き出してfolderDataに格納
        final List<Task> tasks = folderData['tasks'].map<Task>((taskData){ // そのfolderDataがMap形式で持っているtasksというリストから1要素ずつ抜き出しているが、mapメソッドを使うと型を再宣言しないとダメ
          return Task(
            id: taskData['id'], // プロパティはTaskクラスで定義したrequierdのプロパティ。tasksの内部にmap形式になっている'id'や'title'など、キーが一致するものを指定している
            folderId: taskData['folder_id'],
            title: taskData['title'],
          );
        }).toList();
        return Folder(
          id: folderData['id'],
          title: folderData['title'],
          tasks: tasks,
        );
      }).toList();
      return parsedFolders;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<void> postFolder(TextEditingController controller) async {

    final url = Uri.parse(requestFolder);
    final String folderTitle = controller.text;
    // final String folderTitle = NewFolderState.textController.text;

    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({'title': folderTitle, 'user_id': 2 });

    final responsePostFolder = await http.post(
      url,
      headers: headers, 
      body: body
      );
    if (responsePostFolder.statusCode != 200) {
      print('folder is created');
    } else{
      print('create folder is failed');
    }
  } 

  static Future<void> postTask(TextEditingController controller,int value) async {

    final url = Uri.parse(requestTask);
    final String taskTitle = controller.text;
    final int folderId = value;

    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({'title': taskTitle, 'folder_id': folderId });

    final responsePostFolder = await http.post(
      url,
      headers: headers, 
      body: body
      );
    if (responsePostFolder.statusCode != 201) {
      print('task is created');
      print(body);
    } else{
      print('create task is failed');
      print(body);
    }
  }


  static Future<void> deleteFolder(int value) async { 

    final deleteId = value;
    final deleteFolder = "$requestFolder$deleteId";
    final responseDeleteFolder = await http.delete(Uri.parse(deleteFolder));  // requestFolderの文字列をURI形式に変換して、それに対してgetリクエストを送っている

    if (responseDeleteFolder.statusCode == 200){
      print('folder is deleted');
      print(deleteId);
      print(deleteFolder);
      print(responseDeleteFolder);
    } else {
      print(deleteId);
      print(deleteFolder);
      print(responseDeleteFolder);
      throw Exception('failed');
    }
  }



  static Future<void> deleteTask(int value) async { 

    final deleteId = value;
    final deleteTask = "$requestTask$deleteId";
    final responseDeleteTask = await http.delete(Uri.parse(deleteTask));  // requestFolderの文字列をURI形式に変換して、それに対してgetリクエストを送っている

    if (responseDeleteTask.statusCode == 200){
      print('Task is deleted');
      print(deleteId);
      print(deleteTask);
      print(responseDeleteTask);
    } else {
      print(deleteId);
      print(deleteFolder);
      print(responseDeleteTask);
      throw Exception('failed');
    }
  }


















}