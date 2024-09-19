import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'main.g.dart';
main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String resultStr1 = "결과 값";
  late Map<String, dynamic> map1;

  void onPressDecode() {
    String jsonStr = '{"id" : 1, "title":"hello", "completed":false}';

    Map<String, dynamic> map = jsonDecode(jsonStr);

    setState(() {
      resultStr1 =
          "디코드 : 아이디는 ${map['id']} , 제목은 : ${map["title"]}, 결과는 : ${map["completed"]}";
      //"디코드 : 아이디는 ${map}";
    });
  }

  void onPressDecode2() {
    String jsonStr =
        '[{"id" : 1, "title" : "hello", "completed" : false},{"id" : 2 , "title" : "world" , "completed" : false}]';

    StringBuffer sb = StringBuffer();
    List list = jsonDecode(jsonStr);
    // map1 = list[0];
    // var list1 = list[1];
    // forEach 메소드에서 익명 함수 사용
    // list.forEach((list1) {
    //   sb.write(
    //       // "디코드 : 아이디는 ${list1} \n");
    //       "디코드 : 아이디는 ${list1['id']} , 제목은 : ${list1['title']}, 결과는 : ${list1['completed']}\n");
    // });

    List<Todo> todoList = [];
    for (Map<String, dynamic> map in list) {
      todoList.add(Todo.fromJson(map));
    }

    for(Todo todo in todoList) {
      sb.writeln(todo);
    }

    setState(() {
      resultStr1 = sb.toString();
    });
  }

  void onPressEncode() {
    setState(() {
      resultStr1 = jsonEncode(map1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Network_json_test2"),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: onPressDecode, child: Text("JSON Decode Test1")),
            ElevatedButton(
                onPressed: onPressDecode2, child: Text("JSON Decode Test2")),
            ElevatedButton(
                onPressed: onPressEncode, child: Text("JSON Encode Test1")),
            Text(resultStr1),
          ],
        ),
      ),
    );
  }
}

@JsonSerializable()
class Todo {
  int id;
  String title;
  bool completed;

  Todo(this.id, this.title, this.completed);

  // Todo.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       title = json['title'],
  //       completed = json['completed'];
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  // Map<String, dynamic> toJson() =>
  //     {'id': id, 'title': title, 'completed': completed};
  Map<String, dynamic> toJson() => _$TodoToJson(this);


  @override
  String toString() {
    // TODO: implement toString
    return "아이디는 $id, 제목은 $title , 완료는 $completed";
  }
}
