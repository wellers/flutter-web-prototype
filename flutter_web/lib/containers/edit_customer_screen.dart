import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

import '../actions/actions.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../presentation/edit_customer.dart';

class EditCustomerScreen extends StatelessWidget {
  final String id;

  EditCustomerScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, viewModel) {
        return EditCustomer(
          onInit: () {
            StoreProvider.of<AppState>(context).dispatch(LoadCustomerAction(id));
          },
          onSave: viewModel.onSave,
          customer: viewModel.customer,
          onBack: viewModel.onBack,
        );
      }
    );
  }
}

class _ViewModel {  
  final bool loading;
  final Customer? customer;  
  final OnSaveCallback onSave;
  final Function onBack;

  _ViewModel({
    required this.loading,
    required this.customer,
    required this.onSave,
    required this.onBack
  });

  static _ViewModel fromStore(Store<AppState> store) {    
    return _ViewModel(
      loading: store.state.customer == null,
      customer: store.state.customer,
      onSave: (customer, name, age) {
        store.dispatch(UpdateCustomerAction(id: customer.id, customer: customer.copyWith(name: name, age: int.parse(age))));
      },
      onBack: () {
        store.dispatch(NavigateToAction.push(Routes.listCustomers));
      }
    );
  }  
}