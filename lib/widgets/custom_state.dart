import 'package:do_it_flutter_v2/utils/app_router.dart';
import 'package:flutter/cupertino.dart';

abstract class CustomState<T extends StatefulWidget> extends State<T>{
   String get routeName;

  @override
  void dispose() {
    AppRouter.removeRoute(routeName: routeName);
    super.dispose();
  }
}