import 'package:flutter/material.dart';
import 'listpage.dart';

class NewFolder extends StatefulWidget{

  const NewFolder({super.key});

  @override
  State<NewFolder> createState() => _NewFolderState();
}

class _NewFolderState extends State<NewFolder>{

  String _folder = '';
  // String _password = '';


  @override
  void initState(){
    super.initState();
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
                    decoration:InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "新しいフォルダ名",
                      labelStyle: TextStyle(
                        fontSize: 12,
                      )
                    ),
                    onChanged: (String value){
                      setState(){
                        _folder = value;
                      }
                    }
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: Container(
              //     width: 250,
              //     height: 50,
              //     child: TextField(
              //       decoration:InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: "パスワード",
              //           labelStyle: TextStyle(
              //           fontSize: 12,
              //         )
              //       ),
              //       onChanged: (String value){
              //         setState(){
              //           _mail = value;
              //         }
              //       }
              //     ),
              //   ),
              // ),
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
                    onPressed:(){
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