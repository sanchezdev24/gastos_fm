
import 'package:ecommerce_fm/app_init.dart';
import 'package:ecommerce_fm/src/boostrap/boostrap.dart';
import 'package:flutter/material.dart';

void main() async {
  final it = await boostrap();
  runApp(AppInit(it: it,));
}
