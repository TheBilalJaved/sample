import 'package:flutter/material.dart';
import 'package:ivoting/Screens/SignUp/SignUp.dart';
import 'package:ivoting/util/DashboardItems.dart';

class UserDashboardScreen extends StatefulWidget {
  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  // int levelClock = 86400;
  int levelClock = 108;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(20.5),
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Poll Ends In",
                        style: TextStyle(
                          fontSize: 15.0,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Countdown(
                            animation: StepTween(
                              begin:
                                  levelClock, // THIS IS A USER ENTERED NUMBER
                              end: 0,
                            ).animate(_controller),
                          )),
                    ],
                  ),
                ),
                GridView.count(
                  physics:
                      NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    makeDashboardItem(
                        "warning", Icons.dangerous, context, SignUpScreen()),
                    // makeDashboardItem("Alphabet", Icons.alarm),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

//class for timer
// ignore: must_be_immutable
class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText;
    if (clockTimer.inHours.remainder(24) == 0) {
      timerText =
          '${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    } else {
      timerText =
          '${clockTimer.inHours.remainder(24).toString().padLeft(2, '0')}:${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 60,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
