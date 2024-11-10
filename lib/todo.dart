// import 'package:flutter/material.dart';
// import 'api_request.dart';

// class Todo extends StatefulWidget{
//   const Todo({super.key});
//   @override
//   State<Todo> createState() => _TodoState();
// }

// class _TodoState extends State<Todo>{

//   List _title = [];

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
//     // print(_title);
//   }

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body:Center(child: Text('_title')),
//     );    
//   }
// }