import 'package:flutter/material.dart';
//Random使用のためインポート
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
//自分のじゃんけんマスタ
  String myJankenText = Hand.rock.text;
//相手のじゃんけんマスタ
  String computerJankenText = Hand.rock.text;
//じゃんけんリスト（相手の）
  List<Hand>jankenList = [Hand.rock, Hand.scissors, Hand.paper];

  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    //enum型になった
    final hand = jankenList[randomNumber];
    setState(() {
      //Hand型をStringに変換
      computerJankenText = hand.text;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '相手',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              computerJankenText,
              style: TextStyle(fontSize: 100),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              '自分',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              myJankenText,
              style: TextStyle(fontSize: 200),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed:(){
                setState(() {
                  myJankenText = Hand.rock.text;
                });
                //相手のランダム選択をボタンを押すときに呼び出す
                chooseComputerText();
              },
            child: const Text(
              Hand.rock.text,
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),

          FloatingActionButton(
            onPressed:(){
              setState(() {
                myJankenText = Hand.scissors.text;
              });
              //相手のランダム選択をボタンを押すときに呼び出す
              chooseComputerText();
            },
            child: const Text(
              Hand.scissors.text,
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),

          FloatingActionButton(
            onPressed:(){
              setState(() {
                myJankenText = Hand.paper.text;
              });
              //相手のランダム選択をボタンを押すときに呼び出す
              chooseComputerText();
            },
            child: const Text(
              Hand.paper.text,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//enum = Bool型の進化系（true・false以外の選択肢が設定できる）
enum Hand {
  rock,
  scissors,
  paper;

  String get text {
    switch(this){
      case Hand.rock:
        return '👊';
      case Hand.scissors:
        return '✌️';
      case Hand.paper:
        return '✋';
    }
  }
}
