import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

import '../models/app_state.dart';
import '../models/models.dart';
import '../presentation/active_page.dart';

class SideMenuScreen extends StatelessWidget {
  final AppPage tab;

  SideMenuScreen({required AppPage this.tab});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, viewModel) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: tab == AppPage.listCustomers
                ? Text('Customers')
                : Text('Home'),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 300,
                        child: ListView(
                          children: AppPage.values.map((tab) {
                            return ListTile(
                              leading: Icon(
                                  tab == AppPage.listCustomers
                                      ? Icons.list
                                      : Icons.home,
                                  key: Key(tab.name)),
                              title: tab == AppPage.listCustomers
                                  ? Text('Customers')
                                  : Text('Home'),
                              onTap: () => viewModel.onPageSelected(tab),
                            );
                          }).toList()),
                      ),
                      Expanded(
                        child: ActivePage(
                            key: Keys.activePage,
                            page: tab,                    
                          )
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ViewModel {
  final Function(AppPage) onPageSelected;

  _ViewModel({    
    required this.onPageSelected,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onPageSelected: (tab) => store.dispatch(NavigateToAction.replace(tab.appPageToRoute()))
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType;  
}