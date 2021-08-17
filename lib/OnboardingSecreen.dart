


import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class OnboardingSecreen extends StatefulWidget{
  @override
  _OnboardingSecreen createState() =>_OnboardingSecreen();


}
class _OnboardingSecreen extends State<OnboardingSecreen>{

int currentIndexPage = 0;

PageController _controller = new PageController();

@override
void initState() {
  super.initState();
  currentIndexPage = 0;
}

// ignore: missing_return
VoidCallback onPrev() {
  setState(() {
    if (currentIndexPage >= 1) {
      currentIndexPage = currentIndexPage - 1;
      _controller.jumpToPage(currentIndexPage);
    }
  });
}

// ignore: missing_return
VoidCallback onNext() {
  if (currentIndexPage < 3) {
    currentIndexPage = currentIndexPage + 1;
    _controller.jumpToPage(currentIndexPage);
    setState(() async {});
  } else {
    //setBool(IS_FIRST_TIME, false);
   // DashboardActivity().launch(context, isNewTask: true);
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _controller,
              children: <Widget>[
                Pages(
                  textContent:"",
                  walkImg: "assets/pv1-1.png",
                  desc: "",
                ),
                Pages(
                  textContent: "",
                  walkImg: "assets/pv2-2.png",
                  desc: "",
                ),
                Pages(
                  textContent: "",
                  walkImg: "assets/pv3-2.png",
                  desc: "",
                ),
                Pages(
                  textContent: "",
                  walkImg: "assets/pv1-1.png",
                  desc: "",
                ),
              ],
              onPageChanged: (value) {
                setState(() => currentIndexPage = value);
              },
            ),
          ),
          Container(
            height: 85,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  child: currentIndexPage == 0
                      ? SizedBox()
                      : FlatButton(child: Text("prev"),
                      onPressed: onPrev),
                ),
                DotsIndicator(
                  dotsCount: 4,
                  position: currentIndexPage.toDouble(),
                  decorator: DotsDecorator(
                    color: Color(0XFFDADADA),
                    activeColor: Color(0XFF4600D9),
                  ),
                ),
                FlatButton(
                    child: Text("nxt"),
                    onPressed: onNext,
                    ),
              ],
            ),
          )
        ],
      ));
}
}

class Pages extends StatelessWidget {
  final String textContent;
  final String walkImg;
  final String desc;

  Pages({Key key,  this.textContent,  this.walkImg,  this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: h * 0.05),
            height: h * 0.5,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Image.asset(walkImg, width: width * 0.8, height: h * 0.4)
              ],
            ),
          ),
          SizedBox(
            height: h * 0.08,
          ),
          Text(
            textContent,
            style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold)),

          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: Text(
              desc,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: primaryTextStyle(size: 16),
            ),
          )
        ],
      ),
    );
  }
}
