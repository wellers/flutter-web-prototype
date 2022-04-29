import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../presentation/customers_list.dart';

class CustomersScreen extends StatefulWidget {
  final void Function() onInit;

  CustomersScreen({required this.onInit}) : super(key: Keys.customers);

  @override
  CustomersScreenState createState() => CustomersScreenState();
}

class CustomersScreenState extends State<CustomersScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, viewModel) {
        return Scaffold(
          key: widget.key,          
          body: CustomersList(
            key: Keys.customersList,
            customers: viewModel.customers,
            onRemove: viewModel.onRemove,
            onUndoRemove: viewModel.onUndoRemove,
            onEdit: viewModel.onEdit
          ),
          floatingActionButton: FloatingActionButton(
            key: Keys.addCustomersButton,
            onPressed: () {
              viewModel.onAdd();
            },
            child: Icon(Icons.add),
            tooltip: 'Add Customer',
          )
        );
      },
    );
  }
}

class _ViewModel {
  final List<Customer> customers;
  final bool loading;  
  final Function(Customer) onRemove;
  final Function(Customer) onUndoRemove;
  final Function onAdd;
  final Function(String) onEdit;

  _ViewModel({
    required this.customers,
    required this.loading,    
    required this.onRemove,
    required this.onUndoRemove,
    required this.onAdd, 
    required this.onEdit
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      customers: store.state.customers,
      loading: store.state.isLoading,      
      onRemove: (customer) {
        store.dispatch(DeleteCustomerAction(customer.id));
      },
      onUndoRemove: (customer) {
        store.dispatch(AddCustomerAction(customer: CustomerInput.fromCustomer(customer)));
      },
      onAdd: () {        
        store.dispatch(NavigateToAction.replace(Routes.addCustomer));
      },
      onEdit: (id) {
        store.dispatch(NavigateToAction.replace(Routes.editCustomer(id)));
      }
    );
  }  
}