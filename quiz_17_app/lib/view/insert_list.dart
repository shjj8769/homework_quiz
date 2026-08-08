import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_17_app/model/quiz_list.dart';
import 'package:quiz_17_app/util/message.dart';
import 'package:get/get.dart';


class InsertList extends StatefulWidget {
  final List<QuizList> list;
  const InsertList({super.key, required this.list});

  @override
  State<InsertList> createState() => _InsertListState();
}

class _InsertListState extends State<InsertList> {
  // Property
  late TextEditingController textEditingController;       // 추가 목록 문자 사용

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();

    Message.images = widget.list[0].imagePath;      // 처음 넘어왔을 때 초기 이미지를 첫 번째 이미지로 선정
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add View'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  Message.images      // 이미지 Message로 가져옴
                ),
              ),
              SizedBox(
                width: 200,
                height: 150,
                child: CupertinoPicker.builder(
                  childCount: widget.list.length,
                  itemExtent: 40,         // picker 크기 
                  backgroundColor: Colors.purple[100],
                  onSelectedItemChanged: (value) {
                    rebuildborder(value);
                    setState(() {});
                  }, 
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          widget.list[index].imagePath,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            width: 350,
            height: 100,
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: '목록을 입력하세요'
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if(textEditingController.text.trim().isNotEmpty){
                addList();            // tabel_list에 추가될 내용
              }
              Get.back();             // 뒤로 돌아가기
            }, 
            child: Text("OK")
          ),
        ],
      ),
    );
  } // build
  // ========= Function ==============
  void rebuildborder(int value){
    Message.images = widget.list[value].imagePath;
    }


  void addList(){
    Message.images;
    Message.workList = textEditingController.text.trim();
    Message.action = true;
  }
} // class