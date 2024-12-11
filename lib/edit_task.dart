import 'package:flutter/material.dart';
import 'listpage.dart';
import 'api_request.dart';



class EditTask extends StatefulWidget{

  final String taskTitle;
  final int folderId;
  final int taskId;

  const EditTask({super.key, required this.taskTitle, required this.folderId, required this.taskId});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask>{

  final TextEditingController textController = TextEditingController();


  @override
  void initState(){
    super.initState();
  }




  @override
  void dispose() {
    textController.dispose(); // メモリリークを防ぐためにdisposeする
    super.dispose();
  }



  @override
  Widget build(BuildContext context){
    String taskTitle = widget.taskTitle;
    int folderId = widget.folderId;
    int taskId = widget.taskId;
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
                  "タスク名を編集",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    controller: textController,
                    decoration:InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: taskTitle,
                      labelStyle: const TextStyle(
                        fontSize: 12,
                      )
                    ),
                    onChanged: (String value){
                      // setStateいらない、そのまま入力した文字列がvalueに入る
                    }
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(50,40),
                          backgroundColor: Colors.red[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                        onPressed:(){
                          Navigator.pop(context);
                        },
                        child:const Text(
                          "戻る",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                          ),
                          ),
                      ),
                    ),
                    Container(
                      width: 130,
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
                          await TodoApi.updateTask(textController,folderId,taskId);
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
                          "送信",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                          ),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );    
  }
}