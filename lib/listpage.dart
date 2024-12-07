// import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class _ListPageState extends State<ListPage>{

  // double upperRotateValue = 0;
  // double bottomRotateValue = 0;
  // bool opened = false;
  List<Folder> folders = [];
  List<String> _folderTitles = []; // 通常のリスト型 [string1,string2,string3]
  List<int> _folderIds = []; // 通常のリスト型 [string1,string2,string3]

  List<List<String>> _taskTitles = []; // Listの中にListをネストする [[],[],[]......]
  List<List<int>> _taskIds = []; // Listの中にListをネストする [[],[],[]......]
  // String _deleteFolderId = '';
  int _deleteFolderId = 0;
  int _deleteTaskId = 0;

  @override
  void initState(){
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final List<Folder> folders = await TodoApi.fetchData();
    setState((){
      _folderTitles = folders.map((folder) => folder.title).toList(); // folder階層のtitle mapメソッドで取り出した値をfolderに格納しているので、引数であるfolderという名前である必要はない
      _folderIds = folders.map((folder) => folder.id).toList(); // folder階層のtitle mapメソッドで取り出した値をfolderに格納しているので、引数であるfolderという名前である必要はない
      _taskTitles = folders.map((folder) => folder.tasks.map((task) => task.title).toList()).toList(); // tasksプロパティに値を持つフォルダからしかデータを持ってこない
      _taskIds = folders.map((folder) => folder.tasks.map((task) => task.id).toList()).toList(); // folder階層のtitle mapメソッドで取り出した値をfolderに格納しているので、引数であるfolderという名前である必要はない
    });
  }


  Future<void> deleteDataFolder(int deleteFolderId) async {
    setState((){
      _deleteFolderId = deleteFolderId;
    });
    final deleteFolder = await TodoApi.deleteFolder(_deleteFolderId);
      deleteFolder;
  }


  Future<void> deleteDataTask(int deleteTaskId) async {
    setState((){
      _deleteTaskId = deleteTaskId;
    });
    final deleteTask = await TodoApi.deleteTask(_deleteTaskId);
      deleteTask;
  }


void _showAlertDialogFolder(BuildContext context, String folderName, int deleteFolderId) {
    final _folderName = folderName;

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('フォルダの削除'),
        content: Text('「$_folderName」を削除します。よろしいですか？'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDestructiveAction: true,
            onPressed: () {
              deleteDataFolder(deleteFolderId);
              print(deleteFolderId);
              Navigator.pop(context);
              getData();
            },
            child: const Text('削除する'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('戻る'),
          ),
        ],
      ),
    );
  }




void _showAlertDialogTask(BuildContext context, String taskName,int deletetaskId) {
    // final folderName = _folderTitles.indexOf(deletefolderTitle);
    final _taskName = taskName;

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('フォルダの削除'),
        content: Text('「$_taskName」を削除します。よろしいですか？'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDestructiveAction: true,
            onPressed: () {
              deleteDataTask(deletetaskId);
              print(deletetaskId);
              getData();
              Navigator.pop(context);
            },
            child: const Text('削除する'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('戻る'),
          ),
        ],
      ),
    );
  }



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
                      itemCount: _folderIds.length,
                      itemBuilder: (context, folderIndex){
                        // ListViewを2つ作成するので、第2引数は別の名前にする
                        return  Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                                child: Stack(
                                  children: [
                                    ExpansionTile(
                                      title: Text(
                                        _folderTitles[folderIndex], // itemBuilderで宣言した第2引数をキーに値を取得
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
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
                                          itemCount: _taskTitles[folderIndex].length,
                                          itemBuilder: (context, taskIndex){
                                            // 第2引数は上位層のものと別名に
                                            return  Column(
                                              children: [
                                                Stack(
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
                                                          _taskTitles[folderIndex][taskIndex], // _taskTitlesの型は<List<List<String>>>になっているため、2つのインデックスで取得する必要がある
                                                          style:TextStyle(
                                                            fontSize: 12,
                                                          ),  
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                    Positioned(
                                                      child: SizedBox(
                                                        width:30,
                                                        height:30,
                                                        child: CupertinoButton(
                                                          onPressed:(){
                                                            _showAlertDialogTask(context, _taskTitles[folderIndex][taskIndex],_taskIds[folderIndex][taskIndex]);
                                                          },
                                                          
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: 20,
                                                            color: Colors.red[400],
                                                          ),
                                                        ),
                                                      ),
                                                      top:3,
                                                      left:280,
                                                    ),
                                                  ]
                                                ),
                                              ]
                                            );
                                          }
                                        ),
                                      ],
                                    ),
                                    
                                    Positioned(
                                      child: SizedBox(
                                        width:30,
                                        height:30,
                                        child: CupertinoButton(
                                          onPressed:(){
                                            _showAlertDialogFolder(context, _folderTitles[folderIndex], _folderIds[folderIndex]);
                                          },
                                          
                                          child: Icon(
                                            Icons.delete,
                                            size: 20,
                                            color: Colors.red[400],
                                          ),
                                        ),
                                      ),
                                      top:3,
                                      left:260,
                                    ),
                                  ],
                                ),
                            ),
                            Container(
                              color: Colors.white,
                              height:20,
                            ),
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