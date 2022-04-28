import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../selectors/selectors.dart';

class CustomersLoading extends StatelessWidget {
  final Widget Function(BuildContext context, bool isLoading) builder;

  CustomersLoading({required Key key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (Store<AppState> store) => isLoadingSelector(store.state),
      builder: builder,
    );
  }
}