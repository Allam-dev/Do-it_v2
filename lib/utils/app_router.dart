import 'package:flutter/material.dart';

abstract class AppRouter {
  static String addRoute({required String routeName, required Widget screen}){
    routes[routeName] = (context) => screen;
    return routeName;
  }
  static Map<String, WidgetBuilder> routes = {};  
}