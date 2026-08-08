import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  String currentDateTime = "";            // 현재 시간
  DateTime? chosenDateTime;               // 선택한 시간
  late Color chosenDateTimeColor;         // 화면 색
  final bool _isRunning = true;


  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(!_isRunning){                    // false일때 작동
        timer.cancel();                   // dispose를 사용 안해도 됨.
      }
      _attItem();
      setState(() {});
    },);
  }


  void _attItem(){
    final DateTime now = DateTime.now();   // os가 주는 것 (class DateTime 함수 now에)
    currentDateTime = "${now.year} - ${now.month.toString().padLeft(2, '0')} -"
    " ${now.day.toString().padLeft(2, '0')} ${_weekDayToString(now.weekday)} "        // <- 숫자로 만들어진것을 toString으로 함수 만들어 요일 설정
    "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";   // << 숫자를 String한 것 (숫자는 우측정렬) '0' - 빈 값은 0으로 넣겠다.
    setState(() {});
  }

  String _weekDayToString(int weekday){
    String dateName = "";

    switch(weekday){
      case 1:
      dateName = '월';
      case 2:
      dateName = '화';
      case 3:
      dateName = '수';
      case 4:
      dateName = '목';
      case 5:
      dateName = '금';
      case 6:
      dateName = '토';
      case 7: //(=default)
      dateName = '일';
    }
    return dateName;  // 반환타입 String 타입 맞춰주기
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _chosenDateTimeColor(),
      appBar: AppBar(
        title: Text('알람 정하기'),
        centerTitle: true,    // 가운데 정렬
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "현재시간 : $currentDateTime",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 300,
              height: 200,
              child: CupertinoDatePicker(           // 날짜 변경했을 때 실행
                initialDateTime: DateTime.now(),    // 초기 시간 addItem에 설정해 둔 값 (DateTime.now())
                use24hFormat: true,                 // 24시간
                onDateTimeChanged: (value) {
                  chosenDateTime = value;
                  setState(() {});
                },
              ),
            ),
            Text(
              '선택 시간 : ${chosenDateTime != null ? _chosenItem(chosenDateTime!) : "시간을 선택 하세요."}',    // << null 값이 아닌 경우 _chosenItem함수 실행(위에 설정한 DateTime late가 아닌 ?로 설정)
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  } // build

  // ------------ Function -----------

  String _chosenItem(DateTime now1){        // 선택한 시간
    String chosenDateTime1 = "${now1.year} - ${now1.month.toString().padLeft(2, '0')} -"
      " ${now1.day.toString().padLeft(2, '0')} ${_weekDayToString(now1.weekday)} "    // <- 숫자로 만들어진것을 toString으로 함수 만들어 요일 설정
      "${now1.hour.toString().padLeft(2, '0')}:${now1.minute.toString().padLeft(2, '0')}";

      return chosenDateTime1;
  }

  Color? _chosenDateTimeColor(){    // 함수가 비어있는 상태(null표시로 ?) / 색 변환 or null값 반환
    Color? chosenDateTimeColor; 
    if(chosenDateTime != null && _chosenItem(DateTime.now()) == _chosenItem(chosenDateTime!)){        // 현재 시간을 분까지 나타내는 DateTime.now() <- 위에 설정함 currentDateTime
      if(DateTime.now().second % 2 == 0){

        chosenDateTimeColor = Colors.pinkAccent;    // 짝수일 때 pink로 변함
      }else{
        chosenDateTimeColor = Colors.amber;         // 홀수일 때 amber
      }
    }
    return chosenDateTimeColor;
  }
} // class