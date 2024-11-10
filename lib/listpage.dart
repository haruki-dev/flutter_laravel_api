import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'model.dart';

import 'new_folder.dart';
import 'new_task.dart';

import 'api_request.dart';



class ListPage extends StatefulWidget{

  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}


// class ExpTile extends StatelessWidget{

//   final String title;
//   final List<String> items;

//   const ExpTile ({super.key, required this.title, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       title:Text(title),
//       children:
//         FolderMenu(),
//         items.map((item) => ListTile(title: Text(item))).toList(),
      
//     );
//   }
// }

class _ListPageState extends State<ListPage>{

  // double upperRotateValue = 0;
  // double bottomRotateValue = 0;

  // bool opened = false;

  List<String> _folderTitles = [];
  List<String> folderTitles = [];
  List<String> _taskTitles = [];
  @override
  void initState(){
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final List<Folder> jsondata = await TodoApi.fetchData();
    List<String> taskTitles = [];
    // print(jsondata);
    for (var folder in jsondata) {
      folderTitles.add(folder.title);
      print(folderTitles);
      for (var task in folder.tasks){
        taskTitles.add(task.title);
        print(taskTitles);
      }
    }
    setState((){
      _folderTitles = folderTitles;
      _taskTitles = taskTitles;
    });
  }

  // void startAnimation(){
  //   setState((){
  //     if(!opened){
  //       upperRotateValue = pi /7.1;
  //       bottomRotateValue = -pi /7.1;
  //     }
  //     else{
  //       upperRotateValue = 0;
  //       bottomRotateValue = 0;
  //     }
  //     opened = !opened;
  //   });
  // }



    @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  // color: Colors.blueGrey,
                  width: double.infinity,
                  // height:75,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Text('TodoApp'),
                      ),
                      Container(
                        color: Colors.black45,
                        width: double.infinity,
                        height: 1,
                      ),
                    ],
                  ) ,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: _folderTitles.length,
                      itemBuilder: (context, index){
                        return  Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                              child: ExpansionTile(
                                title: Text(
                                  _folderTitles[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                // title: _folderTitle[index]['title'],
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: Text(
                                          '全選択',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blue
                                          ),
                                          ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: Text(
                                          '全解除',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blue
                                          ),
                                          ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: Text(
                                          '選択項目の削除',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    itemCount: _taskTitles.length,
                                    itemBuilder: (context, index){
                                      return  Column(
                                        children: [
                                          ListTile(
                                            title: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey[100],
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  _taskTitles[index],
                                                  style:TextStyle(
                                                    fontSize: 12,
                                                  ),  
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                      );
                                    }
                                  ),
                                  // Container(
                                  //   child: ListTile(
                                  //     title: Container(
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.blueGrey[100],
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(10),
                                  //         child: Text(
                                  //           'nest_1',
                                  //           style:TextStyle(
                                  //             fontSize: 12,
                                  //           ),  
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   child: ListTile(
                                  //     title: Container(
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.blueGrey[100],
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(10),
                                  //         child: Text(
                                  //           'nest_2',
                                  //           style:TextStyle(
                                  //             fontSize: 12,
                                  //           ),  
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              height:20,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // Container(
                //   height: 1,
                //   color: Colors.black45,
                // ),
                // Container(
                //   // color: Colors.amber,
                //   width: double.infinity,
                //   height:60,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       InkWell(
                          // TweenAnimationBuilder使ってハンバーガーボタンのアニメーション作ってみたけど使わなかったやつ

                          // color: Colors.blue,
                          // child: Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     TweenAnimationBuilder<double>(
                          //       tween: Tween(
                          //         begin: 0,
                          //         end: upperRotateValue,
                          //       ),
                          //       duration: Duration(milliseconds: 150),
                          //       builder: (_, val, child) => Transform.rotate(
                          //         angle: val,
                          //         alignment: Alignment.centerLeft,
                          //         child: child,
                          //       ),
                          //       child: Container(
                          //         height: 1,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 15,
                          //     ),
                          //     TweenAnimationBuilder<double>(
                          //       tween: Tween(
                          //         begin: 0,
                          //         end: bottomRotateValue,
                          //       ),
                          //       duration: Duration(milliseconds: 200),
                          //       builder: (_, val, child) => Transform.rotate(
                          //         angle: val,
                          //         alignment: Alignment.centerLeft,
                          //         child: child,
                          //       ),
                          //       child: Container(
                          //         height: 1,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                  //       ),
                  //   ],
                  // ),
                // ),
              ],
            ),
            Positioned(
              top:18,
              left:345,
              child: Container(
                width:35,
                height:35,
                child: Image.asset(
                  'assets/logout.png',
                ),
              ),
            ),
            Positioned(
              top:50,
              left:335,
              child: Text(
                'user : john',
                style: TextStyle(
                  fontSize: 10
                ),
                )
            ),
          ]
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        onTap: (index){
          // startAnimation();
          if(index == 0){
            showModalBottomSheet(
              context: context, 
              builder: (BuildContext context){
                return PopScope(
                  canPop: true,
                  // onPopInvoked: (didPop) async {
                  //   if (didPop){
                  //     startAnimation();
                  //   }
                  // },
                  child: InkWell(
                    onTap:(){
                    // startAnimation();
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width:double.infinity,
                      height:200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              child: Text(
                              "Add New Folder",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54
                              ),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200,40),
                                backgroundColor: Colors.blueGrey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              onPressed:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:((context) => NewFolder()),
                                  )
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              child: Text(
                              "Add New Task",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54
                              ),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200,40),
                                backgroundColor: Colors.blueGrey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              onPressed:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // builder:((context) => Todo()),
                                    builder:((context) => NewTask()),
                                  )
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }
        },
        backgroundColor: Colors.blueGrey[50],
        selectedItemColor: Colors.blueGrey[700],
        unselectedItemColor: Colors.blueGrey[700],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_sharp),
              label: 'Setting',
            ),
          ],
          selectedLabelStyle: TextStyle(fontSize: 10 ),
          unselectedLabelStyle: TextStyle(fontSize: 10),
        ),
    );
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

}