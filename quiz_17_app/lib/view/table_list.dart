import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_17_app/model/quiz_list.dart';
import 'package:quiz_17_app/util/message.dart';
import 'package:quiz_17_app/view/detail_list.dart';
import 'package:quiz_17_app/view/insert_list.dart';

class TableList extends StatefulWidget {
  const TableList({super.key});

  @override
  State<TableList> createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  // Property
  late List<QuizList> quizList;

  @override
  void initState() {
    super.initState();
    quizList = [];
    addData();        // QuizeList에 넣기 위해 생성
  }

  void addData(){
    quizList.add(QuizList(imagePath: 'images/cart.png', workList: "책 구매"));
    quizList.add(QuizList(imagePath: 'images/clock.png', workList: "철수와 약속"));
    quizList.add(QuizList(imagePath: 'images/pencil.png', workList: "스터디 준비하기"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
        centerTitle: true,      // 가운데 정렬
        actions: [              // 아이콘 추가
          IconButton(
            onPressed: () {
              Get.to(InsertList(list: quizList))!.then((value) => rebuildborder());
            }, 
            icon: Icon(Icons.add)
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: quizList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Message.images = quizList[index].imagePath;   // Message에서 불러오기
                Message.workList = quizList[index].workList;
                Get.to(
                  DetailList(),
                );
              },
              child: SizedBox(
                height: 100,
                  child: Card(
                    color: index % 2 == 0
                    ? Colors.deepPurple 
                    : Colors.purple,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            quizList[index].imagePath,
                          ),
                        ),
                        Text(
                          "       ${quizList[index].workList}"
                        ),
                      ],
                    ),
                  ),
              ),
            );
          },
        ),
      ),
    );
  } // build


  //========= Function ============
  void rebuildborder(){
    if(Message.action){

      quizList.add(QuizList(imagePath: Message.images, workList: Message.workList));
      Message.action = false;
      setState(() {});
    }
  }
} // class