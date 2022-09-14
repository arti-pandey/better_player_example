import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class timerClock extends StatefulWidget {
  const timerClock({Key? key}) : super(key: key);

  @override
  State<timerClock> createState() => _timerClockState();
}

class _timerClockState extends State<timerClock> {
  double percent = 0.0;
  Timer? timer;

  var initial_value = 0;
  var total_value = 60;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  _startTimer() {
    /*timer = Timer.periodic(Duration(seconds: 1000), (_) {
      setState(() {
        percent+=10;
        if(percent>=100){
          timer!.cancel();
          percent = 0.0;
        }
      });

    });*/
    setState(() {
      if (initial_value == total_value) {
        initial_value--;
      } else {
        initial_value++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: InkWell(
                  onTap: () {
                    _startTimer();
                  },
                  child: Text(
                    'Timer',
                    style: TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: initial_value / total_value,
                  animation: false,
                  radius: 80.0,
                  lineWidth: 5.0,
                  progressColor: Colors.redAccent,
                  center: Text(
                    '$initial_value',
                    style: TextStyle(color: Colors.black, fontSize: 80),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
