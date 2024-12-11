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
  List<String> _folderTitles = []; // 通常のリスト型 [string1,string2,string3]
  List<int> _folderIds = []; // 通常のリスト型 [string1,string2,string3]
  int _dropdownId = 0; // 選択されたインデックスを初期化

  String? selectedFolder;

  Map<String, int> _folderMap = {};

  @override
  void initState(){
    super.initState();
    getData();
  }
  
  Future<void> getData() async {
    final List<Folder> folders = await TodoApi.fetchData();
    setState((){
      _folderTitles = folders.map((folder) => folder.title).toList(); // folder階層のtitle mapメソッドで取り出した値をfolderに格納しているので、引数であるfolderという名前である必要はない
      _folderIds = folders.map((folder) => folder.id).toList(); // folder階層のtitle mapメソッドで取り出した値をfolderに格納しているので、引数であるfolderという名前である必要はない

      _folderMap = Map.fromIterables(_folderTitles, _folderIds);
    });
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
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "タスクを作成しよう",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    controller: textController, //TextFieldの入力値を管理できる
                    decoration:const InputDecoration(
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
                  child: DropdownButtonFormField<String>(
                    value: selectedFolder,
                    items: _folderIds.map((id){
                      final index = _folderIds.indexOf(id);
                      final title = _folderTitles[index];
                      return DropdownMenuItem<String>(
                        value: title,
                        child: Text(title),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState((){
                        selectedFolder = newValue;
                        _dropdownId = _folderMap[newValue] ?? 0;
                        debugPrint("$_dropdownId");
                      });
                    },
                     // mapメソッドを用いて_folderTitlesのすべての要素に対してDrodownMenuItemウィジェットを生成、Textとvalueに抽出した値を代入し、toListメソッドでリスト化している  
                      // ハードコーディングするなら以下の形式
                      // DropdownMenuItem(child: Center(child: Text(_folderTitles[index])), value: _folderTitles[index]),
                    // underline: Container(color: Colors.white,),
                    isExpanded: true,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: 250,
                  height: 50,
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(50,40),
                      backgroundColor: Colors.blueGrey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                    onPressed:() async {
                      await TodoApi.postTask(textController,_dropdownId);
                      // ウィジェットの BuildContext がまだ有効かどうかをチェック
                      if (!context.mounted) return;
                      // 非同期処理中にcontextを書かないこと
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:((context) => const ListPage()),
                        )
                      );
                    },
                    child:const Text(
                      "作成",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                      ),
                      ),
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