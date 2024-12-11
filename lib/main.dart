import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
// import 'todo.dart';
// import 'api_request.dart';
// import 'welcome.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoApp_with_Laravel',
      home:const Welcome(
        title:'WelcomePage'
      ),
      theme: ThemeData(
        dividerColor: Colors.transparent,
      ),
    );
  }
}


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
                      child: GestureDetector(
                        onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const SignUpPage()),
                          )
                        );
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(top:130,left:30,right:30),
                          child:Image.asset(
                            'assets/person.png',
                            width:50,
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const LoginPage()),
                            )
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:130,left:30,right:30),
                          child: Image.asset(
                            'assets/login.png',
                            width:50,
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const SignUpPage()),
                            )
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top:30,left:20,right:27),
                          child: Text(
                            'ユーザー登録',
                            style: TextStyle(
                              fontSize:12
                            )
                          )
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: (){Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context)=> const LoginPage()),
                          ));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top:30,left:20,right:25),
                          child: Text(
                            'ログイン',
                            style: TextStyle(
                              fontSize:12
                            )
                          )
                        ),
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









// class Todo extends StatefulWidget{
//   const Todo({super.key});
//   @override
//   State<Todo> createState() => _TodoState();
// }

// class _TodoState extends State<Welcome>{

//   String _title = '';

//   @override
//   void initState(){
//     super.initState();
//     getData();
//   }

//   Future<void> getData() async {
//     final title = await TodoApi.fetchTodos();
//     setState((){
//       _title = title;
//     });
//     print(_title);
//   }

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body:Container(child: Text(_title)),
//     );    
//   }
// }
