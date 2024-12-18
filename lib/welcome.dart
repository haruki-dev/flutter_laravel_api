import 'package:flutter/material.dart';


class Welcome extends StatelessWidget{
  
  const Welcome({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(120)
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Hello,World!\nLet\'s start this App.',
                  textAlign:TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:130,left:30,right:30),
                        child:Image.asset(
                          'assets/person.png',
                          width:50,
                          height: 50,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:130,left:30,right:30),
                        child: Image.asset(
                          'assets/login.png',
                          width:50,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top:30,left:20,right:27),
                        child: Text(
                          'ユーザー登録',
                          style: TextStyle(
                            fontSize:12
                          )
                        )
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top:30,left:20,right:25),
                        child: Text(
                          'ログイン',
                          style: TextStyle(
                            fontSize:12
                          )
                        )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(120),
          ),
        ],
      )
    );
  }
}