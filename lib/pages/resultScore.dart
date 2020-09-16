import 'package:flutter/material.dart';

///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
///**********************Not Used Class*********************///

// ignore: must_be_immutable
class ResultScore extends StatelessWidget {
  int result;

  ResultScore(this.result);

  ///**********************Not Used Class*********************///
  ///**********************Not Used Class*********************///
  ///**********************Not Used Class*********************///
  ///**********************Not Used Class*********************///
  ///**********************Not Used Class*********************///
  ///**********************Not Used Class*********************///
  @override
  Widget build(BuildContext context) {
    //var receiveScore=ModalRoute.of(context).settings.arguments as Map;
    return WillPopScope(
      //   onWillPop: _backPressed(),
      onWillPop: null,
      child: Scaffold(
        body: Center(child: Text(result.toString())),
      ),
    );
  }
}

///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
///**********************Not Used Class*********************///
