import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // iOS風UIの実装
import 'model.dart';  // FolderクラスとTaskクラスのインポート
import 'new_folder.dart'; // フォルダ作成ページ
import 'new_task.dart'; // タスク作成ページ
import 'edit_folder.dart'; // フォルダ編集ページ
import 'edit_task.dart'; // タスク編集ページ

import 'api_request.dart'; // APIリクエスト関数の定義ファイル
// import 'dart:math'; // matrix4dウィジェット用に使ったパッケージ。もう使ってない



class ListPage extends StatefulWidget{

  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();

}



class _ListPageState extends State<ListPage>{

  List<String> _folderTitles = []; // 通常のリスト型 [string1,string2,string3]
  List<int> _folderIds = []; // 通常のリスト型 [string1,string2,string3]
  List<List<String>> _taskTitles = []; // Listの中にListをネストする [[],[],[]......]
  List<List<int>> _taskIds = []; // Listの中にListをネストする [[],[],[]......]
  int _deleteFolderId = 0; // 削除するフォルダIDの初期化
  int _deleteTaskId = 0; // 削除するタスクIDの初期化
  final ScrollController _scrollController = ScrollController();


  // matrix4d用の変数
  // double upperRotateValue = 0;
  // double bottomRotateValue = 0;
  // bool opened = false;


  // ページの状態を読み込む度にgetData()で最新のDB情報を取得
  @override
  void initState(){
    super.initState();
    getData();
  }


  Future<void> getData() async {
    // api_request.dartから関数呼び出し、fetchData()が終了するまでsetStateメソッドは動かない
    final List<Folder> folders = await TodoApi.fetchData();
    setState((){
      // mapメソッドの直後の変数は何でもよい..「folder」である必要はない
      _folderTitles = folders.map((folder) => folder.title).toList(); 
      _folderIds = folders.map((folder) => folder.id).toList(); 
      // tasksもList型になっているので、mapメソッドでタイトルだけ抜き出してリスト化する
      _taskTitles = folders.map((folder) => folder.tasks.map((task) => task.title).toList()).toList(); 
      _taskIds = folders.map((folder) => folder.tasks.map((task) => task.id).toList()).toList();
    });
  }


  void deleteDataFolder(int deleteFolderId) async {
    setState((){
      _deleteFolderId = deleteFolderId;
    });
    // フォルダの削除処理が終わるまで、最新のDBを取得しない
    await TodoApi.deleteFolder(_deleteFolderId);
    getData();
  }


  void deleteDataTask(int deleteTaskId) async {
    setState((){
      _deleteTaskId = deleteTaskId;
    });
    // タスクの削除処理が終わるまで、最新のDBを取得しない
    await TodoApi.deleteTask(_deleteTaskId);
    getData();
  }


// 第2引数に選択したフォルダ名、第3引数に選択したフォルダIDを持つ関数
void _showAlertDialogFolder(BuildContext context, String folderName, int deleteFolderId) {
    // 削除するフォルダ名を表示するための変数宣言
    final folderName_ = folderName;

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('フォルダの削除'),
        content: Text('「$folderName_」を削除します。よろしいですか？'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            // 取り消せないアクションを表現する際のプロパティ
            isDestructiveAction: true,
            onPressed: () {
              deleteDataFolder(deleteFolderId);
              Navigator.pop(context);
              // print(deleteFolderId);
            },
            child: const Text('削除する'),
          ),
          CupertinoDialogAction(
            // 通常のアクションを表現する際のプロパティ
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
    final taskName_ = taskName;

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('タスクの削除'),
        content: Text('「$taskName_」を削除します。よろしいですか？'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              deleteDataTask(deletetaskId);
              Navigator.pop(context);
              // print(deletetaskId);
            },
            child: const Text('削除する'),
          ),
          CupertinoDialogAction(
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
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(
        child: Stack( // ログアウトボタンを配置するためにStackウィジェット配置
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(25), // 153行目のContainerでheightを使用せず、Paddingで高さ調整
                        child: Text('TodoApp'),
                      ),
                      // 境界線を表示
                      Container(
                        color: Colors.black45,
                        width: double.infinity,
                        height: 1,
                      ),
                    ],
                  ) ,
                ),
                // リストの中身に応じて高さが可変のため、Expandedウィジェットで表現
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      // 無限スクロールのプロパティ
                      physics: const AlwaysScrollableScrollPhysics(),
                      // shrinkWrapは画面外のウィジェットも描画してしまうらしいので非推奨かも。。Silversウィジェットの方が効果的？
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: _folderIds.length, // フォルダのidの数でリスト生成
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
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      children: <Widget>[
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(7),
                                              child: Text(
                                                '全選択',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.blue
                                                ),
                                                ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(7),
                                              child: Text(
                                                '全解除',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.blue
                                                ),
                                                ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(7),
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
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          controller: _scrollController,
                                          itemCount: _taskTitles[folderIndex].length, // フォルダの数だけ生成する
                                          itemBuilder: (context, taskIndex){
                                            // 第2引数は上位層のものと別名に
                                            return  Column(
                                              children: [
                                                // 編集ボタンと削除ボタンのためのStackウィジェット
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
                                                          // _taskTitlesの型は<List<List<String>>>になっているため、2つのインデックスで取得する必要がある
                                                          _taskTitles[folderIndex][taskIndex], 
                                                          style:const TextStyle(
                                                            fontSize: 12,
                                                          ),  
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                    Positioned(
                                                      top:3,
                                                      left:280,
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
                                                    ),
                                                    Positioned(
                                                      top:3,
                                                      left:250,
                                                      child: SizedBox(
                                                        width:30,
                                                        height:30,
                                                        child: CupertinoButton(
                                                          onPressed:(){
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:((context) => EditTask(
                                                                  taskTitle:_taskTitles[folderIndex][taskIndex],
                                                                  folderId: _folderIds[folderIndex],
                                                                  taskId: _taskIds[folderIndex][taskIndex]
                                                                  )
                                                                ),
                                                              )
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons.edit_note,
                                                            size: 20,
                                                            color: Colors.blue[400],
                                                          ),
                                                        ),
                                                      ),
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
                                      top:3,
                                      left:260,
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
                                    ),
                                    Positioned(
                                      top:3,
                                      left:230,
                                      child: SizedBox(
                                        width:30,
                                        height:30,
                                        child: CupertinoButton(
                                          onPressed:(){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:((context) => EditFolder(folderTitle: _folderTitles[folderIndex], folderId: _folderIds[folderIndex])),
                                              )
                                            );
                                          },                                          
                                          child: Icon(
                                            Icons.edit_note,
                                            size: 20,
                                            color: Colors.blue[400],
                                          ),
                                        ),
                                      ),
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
              ],
            ),
            Positioned(
              top:18,
              left:345,
              child: SizedBox(
                width:35,
                height:35,
                child: Image.asset(
                  'assets/logout.png',
                ),
              ),
            ),
            const Positioned(
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
          if(index == 0){
            showModalBottomSheet(
              context: context, 
              builder: (BuildContext context){
                return PopScope(
                  canPop: true,
                  child: InkWell(
                    onTap:(){
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
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200,40),
                                backgroundColor: Colors.blueGrey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              onPressed:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:((context) => const NewFolder()),
                                  )
                                );
                              },
                              child: const Text(
                              "Add New Folder",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54
                              ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200,40),
                                backgroundColor: Colors.blueGrey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              onPressed:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:((context) => const NewTask()),
                                  )
                                );
                              },
                              child: const Text(
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54
                                ),
                              "Add New Task",
                              ),
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_sharp),
              label: 'Setting',
            ),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 10 ),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        ),
    );
  }
}



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
