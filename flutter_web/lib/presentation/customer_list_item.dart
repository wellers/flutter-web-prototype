import 'package:flutter/material.dart';

import '../models/models.dart';

class CustomerListItem extends StatelessWidget {
  final Function onRemovePressed;
  final Function onEditPressed;
  final DismissDirectionCallback onDismissed;  
  final Customer customer;

  CustomerListItem({
    required this.onDismissed, 
    required this.onEditPressed,
    required this.onRemovePressed,   
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Keys.customerList(customer.id),
      onDismissed: onDismissed,
      child: (
        ListTile(                    
          title: Row(
            children: [              
              Text('Customer name: ${customer.name}'),
              Text("   "),
              Text('Age: ${customer.age.toString()}'),
              Spacer(),
              IconButton(
                tooltip: 'Edit',
                onPressed: () {
                  onEditPressed();
                },
                icon: const Icon(Icons.edit, color: Colors.blueAccent)),
              IconButton(
                tooltip: 'Remove',
                onPressed: () {
                  onRemovePressed();
                }, 
                icon: const Icon(Icons.clear, color: Colors.redAccent))
            ]
          )
        )
      )    
    );
  }
}