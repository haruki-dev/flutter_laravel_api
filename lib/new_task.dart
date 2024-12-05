import 'package:flutter/material.dart';
import 'listpage.dart';
import 'api_request.dart';
import 'model.dart';


class NewTask extends StatefulWidget{

  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask>{

  final TextEditingController textController = TextEditingController();
  String _task = '';
  List<String> _folderTitles = []; // 通常のリスト型 [string1,string2,string3]
  // List<int> _folderId = []; // 通常のリスト型 [string1,string2,string3]
  String _dropdownValue = ''; // ドロップダウンリストの初期値を宣言
  int _dropdownId = 0; // 選択されたインデックスを初期化


  // String _password = '';


  @override
  void initState(){
    super.initState();
    getData();
  }
  
  Future<void> getData() async {
    final List<Folder> folders = await TodoApi.fetchData();
    setState((){
      _folderTitles = folders.map((folder) => folder.title).toList(); // folder階層のtitle mapメソッドで取り出した値をfolderに格納しているので、引数であるfolderという名前である必要はない
      // _folderId = folders.map((folder) => folder.id).toList(); // folder階層のtitle mapメソッドで取り出した値をfolderに格納しているので、引数であるfolderという名前である必要はない
      _dropdownValue = _folderTitles[0];
    });
  }



  void dropdownCallback(String? selectedValue){
    if (selectedValue is String){
      setState((){
        _dropdownValue = selectedValue;
        _dropdownId = _folderTitles.indexOf(selectedValue)+1;
        print(_dropdownValue);
        print(_dropdownId);
        // print(_task);
        print(textController.text);
      });
    }
  }


  @override
  void dispose() {
    textController.dispose(); // メモリリークを防ぐためにdisposeする
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  child: Text(
                    "タスクを作成しよう",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 250,
                  height: 50,
                  child: TextField(
                    controller: textController, //TextFieldの入力値を管理できる
                    decoration:InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "新しいタスク名",
                      labelStyle: TextStyle(
                        fontSize: 12,
                      )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    items: _folderTitles.map((title){
                      return DropdownMenuItem(child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(title),
                      ),value: title);
                      }).toList(), // mapメソッドを用いて_folderTitlesのすべての要素に対してDrodownMenuItemウィジェットを生成、Textとvalueに抽出した値を代入し、toListメソッドでリスト化している  
                      // ハードコーディングするなら以下の形式
                      // DropdownMenuItem(child: Center(child: Text(_folderTitles[index])), value: _folderTitles[index]),
                    isExpanded: true,
                    value: _dropdownValue,
                    onChanged: dropdownCallback,
                    underline: Container(color: Colors.white,),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  width: 250,
                  height: 50,
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child:Text(
                      "作成",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                      ),
                      ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50,40),
                      backgroundColor: Colors.blueGrey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                    onPressed:() async {
                      await TodoApi.postTask(textController,_dropdownId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:((context) => ListPage()),
                        )
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );    
  }
}