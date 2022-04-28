import 'package:flutter/material.dart';

import '../containers/customers_loading.dart';
import '../models/models.dart';
import 'loading_indicator.dart';
import 'customer_list_item.dart';

class CustomersList extends StatelessWidget {
  final List<Customer> customers;
  final Function(Customer) onRemove;
  final Function(Customer) onUndoRemove;
  final Function(String) onEdit;

  CustomersList({
    required Key key,
    required this.customers,    
    required this.onRemove,
    required this.onUndoRemove,
    required this.onEdit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return CustomersLoading(
      key: Keys.customersLoading, 
      builder: (context, loading) {
        return loading
          ? LoadingIndicator(key: Keys.customersLoadingIndicator)
          : _buildListView();
      }
    );
  }

  _buildListView() {
     return ListView.builder(
      key: Keys.customersList,
      itemCount: customers.length,      
      itemBuilder: (BuildContext context, int index) {
        final customer = customers[index];

        return CustomerListItem(
          customer: customer,
          onEditPressed: () => onEdit(customer.id),
          onRemovePressed: () => _removeCustomer(context, customer),
          onDismissed: (direction) {
            _removeCustomer(context, customer);
          },
          
        );
      },
    );
  }

  void _removeCustomer(BuildContext context, Customer customer) {
    onRemove(customer);

    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Deleted',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => onUndoRemove(customer),
        )));
  }  
}