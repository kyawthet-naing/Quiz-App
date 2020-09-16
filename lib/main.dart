import 'package:flutter/material.dart';
import 'package:quiz/pages/QuizsPage.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => QuizsPage()},
    ));
