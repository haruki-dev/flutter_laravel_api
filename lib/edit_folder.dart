import 'package:flutter/material.dart';
import 'listpage.dart';
import 'api_request.dart';


class EditFolder extends StatefulWidget{

  final String folderTitle;
  final int folderId;

  const EditFolder({super.key, required this.folderTitle, required this.folderId});

  @override
  State<EditFolder> createState() => _EditFolderState();
}

class _EditFolderState extends State<EditFolder>{

  final TextEditingController textController = TextEditingController();
  String folder = '';


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
    String folderTitle = widget.folderTitle;
    int folderId = widget.folderId;
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
                  "フォルダ名を編集",
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
                      labelText: folderTitle,
                      labelStyle: const TextStyle(
                        fontSize: 12,
                      )
                    ),
                    onChanged: (String value){
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
                          await TodoApi.updateFolder(textController, folderId);
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