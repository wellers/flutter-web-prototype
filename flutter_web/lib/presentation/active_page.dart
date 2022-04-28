import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

import '../actions/actions.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../containers/customers_screen.dart';

class ActivePage extends StatelessWidget {
  final AppPage page;

  ActivePage({required Key key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case AppPage.listCustomers:
        return CustomersScreen(onInit: () {
          StoreProvider.of<AppState>(context).dispatch(LoadCustomersAction());
        });
      default:
        return Center(child: Text('Hello, World!'));
    }
  }
}