import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import 'models/app_state.dart';
import 'router.dart';

class ReduxApp extends StatelessWidget {
  final Store<AppState> store;

  const ReduxApp({required Key key, required this.store}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: getRoute,
      )
    );
  }
}