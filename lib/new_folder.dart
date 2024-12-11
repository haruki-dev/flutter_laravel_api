import 'package:flutter/material.dart';
import 'listpage.dart';
import 'api_request.dart';

class NewFolder extends StatefulWidget{

  const NewFolder({super.key});

  @override
  State<NewFolder> createState() => _NewFolderState();
}

class _NewFolderState extends State<NewFolder>{

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
                  "フォルダを作成しよう",
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
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "新しいフォルダ名",
                      labelStyle: TextStyle(
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
                      await TodoApi.postFolder(textController);
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