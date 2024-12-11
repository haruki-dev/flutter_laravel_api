import 'package:flutter/material.dart';
import 'listpage.dart';

class LoginPage extends StatefulWidget{

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{


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
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "ログイン",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "メールアドレス",
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
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "パスワード",
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
                    onPressed:(){
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
              ),
            ],
          ),
        ],
      )
    );    
  }
}