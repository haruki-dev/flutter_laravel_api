import 'package:flutter/material.dart';
import 'listpage.dart';
import 'api_request.dart';

class NewFolder extends StatefulWidget{

  const NewFolder({super.key});

  @override
  State<NewFolder> createState() => NewFolderState();
}

class NewFolderState extends State<NewFolder>{

  static final TextEditingController textController = TextEditingController();
  static String folder = '';


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
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  child: Text(
                    "フォルダを作成しよう",
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
                    controller: textController,
                    decoration:InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "新しいフォルダ名",
                      labelStyle: TextStyle(
                        fontSize: 12,
                      )
                    ),
                    onChanged: (String value){
                      setState(){
                        folder = value;
                      }
                    }
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
                      await TodoApi.postFolder();
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