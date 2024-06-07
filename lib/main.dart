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
  Hand? myHand;
//相手のじゃんけんマスタ
  Hand? computerHand;
  //Resultの型を使用した勝敗を格納する変数
  Result? result;
//じゃんけんリスト（相手の）
  List<Hand>jankenList = [Hand.rock, Hand.scissors, Hand.paper];

  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    //enum型になった
    final hand = Hand.values[randomNumber];
    setState(() {
      //Hand型をStringに変換
      computerHand = hand;
    });
    decideResult();
  }

  //勝敗判定の関数
  void decideResult(){
    if(myHand == null || computerHand == null ) {
      return;
    }
    final Result result;

    if (myHand == computerHand) {
      result = Result.draw;
    } else if(myHand == Hand.rock && computerHand == Hand.scissors) {
      result = Result.win;
    }  else if(myHand == Hand.scissors && computerHand == Hand.paper) {
      result = Result.win;
    } else if(myHand == Hand.paper && computerHand == Hand.rock) {
      result = Result.win;
    } else  {
      result = Result.lose;
    }
    setState(() {
      this.result = result;
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
              computerHand?.text ?? '?',
              style: TextStyle(fontSize: 80),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              result?.text ?? '?',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              '自分',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              myHand?.text ?? '?',
              style: TextStyle(fontSize: 150),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed:(){
                setState(() {
                  myHand = Hand.rock;
                });
                //相手のランダム選択をボタンを押すときに呼び出す
                chooseComputerText();
              },
            child: Text(
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
                myHand = Hand.scissors;
              });
              //相手のランダム選択をボタンを押すときに呼び出す
              chooseComputerText();
            },
            child: Text(
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
                myHand = Hand.paper;
              });
              //相手のランダム選択をボタンを押すときに呼び出す
              chooseComputerText();
            },
            child: Text(
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
//じゃんけんをここで判断してグーチョキパーアイコンを使用する
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

//勝ち負け引き分け表示の判断をする
enum Result {
  win,
  lose,
  draw;

  String get text {
    switch (this) {
      case Result.win:
        return '勝ち';
      case Result.lose:
        return '負け';
      case Result.draw:
        return 'あいこ';
    }
  }
}