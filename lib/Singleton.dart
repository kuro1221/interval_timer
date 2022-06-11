import 'package:flutter/material.dart';

class Singleton {
  static Singleton singleton = Singleton._();

  static int _value1 = 0;
  Singleton._(){
      print('インスタンス生成');
      _value1 += 1;
  }

  // Singleton() {
  //   print('インスタンス生成');
  //   _value1 += 1;
  // }
  static Singleton getInstance() {
    return singleton;
  }

  static void setValue() {
    _value1 = 100;
  }

  static int getValue() {
    return _value1;
  }
}