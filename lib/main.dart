import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:onboardingsecreen/swipe_cards.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

import 'OnboardingSecreen.dart';
import 'dart:math' as math;

/*

void main() {
  runApp(CardView());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
Widget schild=Container();
  List<Widget> wdg = [];
  List<Widget> wdg1 = [];
  @override
  void initState() {
    super.initState();
    setupAnimation();




    wdg = [
      Positioned(
        top: 35,
        left: 35,
        height: 250,
        width: 250,
        child: Container(
          width: double.infinity,
          height:  double.infinity,
          color: Colors.yellow[300],
          child: Text(
            'Green',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),    Positioned(
        top: 35,
        left: 35,
        height: 250,
        width: 250,
        child: Container(
          width: 150,
          height: 150,
          color: Colors.yellow[300],
          child: Text(
            'Green',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),    Positioned(
        top: 35,
        left: 35,
        height: 250,
        width: 250,
        child: Container(
          width: 150,
          height: 150,
          color: Colors.yellow[300],
          child: Text(
            'Green',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      Positioned(
        top: 45,
        left: 45,
        height: 250,
        width: 250,
        child: Container(
          width: 150,
          height: 150,
          color: Colors.black26,
          child: Text(
            'Green',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      Positioned(
        top: 45,
        left: 45,
        height: 250,
        width: 250,
        child: Container(
          width: 150,
          height: 150,
          color: Colors.deepOrange,
          child: Text(
            'Green',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      Positioned(
        top: 55,
        left: 55,
        height: 250,
        width: 250,
        child: Container(
          width: double.infinity-20,
          height: double.infinity-20,
          color: Colors.red[300],
          child: Text(
            'Green',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    ];

     animation = Tween<double>(begin: 0, end: 2).animate(controller);
    super.initState();
  }

  void setupAnimation() {
    */
/*  controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );*/ /*

    controller = AnimationController(
        vsync: this, duration: Duration(seconds: 5), upperBound: math.pi * 2)
      ..repeat();

    controller.stop();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  var animation;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Triggered'),
      ),
      body: SwipeDetector(
        onSwipeLeft: () {

          setState(() {
            controller.repeat();
            if(wdg.length>0) {
              //schild=getAnimate(wdg.last);
              schild=wdg.last;
              wdg.removeLast();
              wdg.add(getAnimate(schild));


            }
          });
        },
        onSwipeRight: (){
          controller.stop();
        },
        swipeConfiguration: SwipeConfiguration(
            verticalSwipeMinVelocity: 100.0,
            verticalSwipeMinDisplacement: 100.0,
            verticalSwipeMaxWidthThreshold: 100.0,
            horizontalSwipeMaxHeightThreshold: 100.0,
            horizontalSwipeMinDisplacement: 100.0,
            horizontalSwipeMinVelocity: 200.0),
        child:  Stack(
            children:wdg,
        ),
        ),

    );
  }
  Widget getAnimate(Widget child){
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget child) {
        final xPos = 300 * animation.value;
        final yPos = 60 * animation.value;
        if( controller.value >0.5){
          controller.stop();
          wdg.removeLast();
          controller.value=0;
        }
        return Transform.rotate(
          angle: animation.value * 2,
          origin: Offset(100, 0),
          alignment: Alignment.topLeft,
          child: child,
        );
      },
    );
  }
}
final List data = [
  {
    'color': Colors.red,
  },
  {
    'color': Colors.green,
  },
  {
    'color': Colors.blue,
  }
];

class CardView extends StatelessWidget {
  const CardView({
    Key key,
    this.text = "Card View",
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Material(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(color: Colors.blueAccent,),
            ),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    Text("$text details",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white)),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
import 'package:example/content.dart';
import 'package:flutter/material.dart';

*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Cards Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Swipe Cards Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({ Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Widget> _colors = [
    Pages(
    textContent: lipsum.createText(numParagraphs: 1, numSentences: 2),
    walkImg: "assets/pv1-1.png",
    desc: "1",
  ),
    Pages(
      textContent: lipsum.createText(numParagraphs: 1, numSentences: 2),
      walkImg: "assets/pv2-2.png",
      desc: "2",
    ),
    Pages(
      textContent: lipsum.createText(numParagraphs: 1, numSentences: 2),
      walkImg: "assets/pv3-2.png",
      desc: "3",
    ),
    Pages(
      textContent: lipsum.createText(numParagraphs: 1, numSentences: 2),
      walkImg: "assets/pv1-1.png",
      desc: "4",
    )
  ];

  @override
  void initState() {
    for (int i = 0; i < _colors.length; i++) {
      _swipeItems.add(SwipeItem(
        content: _colors[i],));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        key: _scaffoldKey,

        body:
        Stack(
          children: [

            Container(
              height: sz.height - 10,
              width: sz.width-10,
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {

                  return  _swipeItems[index].content;
                },
                onCardChanged: (){
                  print("mmmmmmmmmmmmmmmmmmmmmmmmmmmm");
                  setState(() {

                  });
                },
                onStackFinished:() {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text("Stack Finished"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                child: _matchEngine.currentItemIndex<=3?
                DotsIndicator(
                  dotsCount: 4,
                  position: _matchEngine.currentItemIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: Color(0XFFDADADA),
                    activeColor: Color(0XFF4600D9),
                  ),
                ):Container(),
              ),
            ),
          ],
        ));
  }
}

class Content {
  final String text;
  final Color color;

  Content({ this.text, this.color});
}