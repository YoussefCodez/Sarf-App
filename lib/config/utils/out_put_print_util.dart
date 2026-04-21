import 'package:flutter/material.dart';

abstract class OutPutPrintUtil {
  static void printOutPut(Object? object){
    debugPrint(object.toString());
  }
}