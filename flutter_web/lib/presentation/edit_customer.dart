import 'package:flutter/material.dart';

import '../models/models.dart';
import 'loading_indicator.dart';

typedef OnSaveCallback = void Function(Customer customer, String name, String age);

class EditCustomer extends StatefulWidget {
  final void Function() onInit;
  final Customer? customer;
  final OnSaveCallback onSave;
  final Function onBack;

  EditCustomer({required this.onInit, required this.customer, required this.onSave, required this.onBack}) : super(key: Keys.editCustomerScreen);

  @override
  State<StatefulWidget> createState() => EditCustomerState();
}

class EditCustomerState extends State<EditCustomer> {
  late String _name;
  late String _age;

  @override
  void initState() {    
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {        
    final textTheme = Theme.of(context).textTheme;

    if (widget.customer == null) {
      return LoadingIndicator(key: Keys.customerLoadingIndicator);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Customer'),
        leading: BackButton(onPressed: () {
          widget.onBack();
        }),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: Keys.editCustomerForm,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.customer?.name,
                key: Keys.editNameField,
                autofocus: false,
                style: textTheme.titleMedium,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                validator: (val) {
                  return val!.trim().isEmpty
                      ? 'Name is required'
                      : null;
                },
                onSaved: (value) => _name = value!                
              ),
              TextFormField(
                initialValue: widget.customer?.age.toString(),
                key: Keys.editAgeField,                
                style: textTheme.titleMedium,
                decoration: InputDecoration(
                  hintText: 'Age',
                ),
                validator: (val) {
                  return val!.trim().isEmpty
                      ? 'Age is required'
                      : null;
                },
                onSaved: (value) => _age = value!,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Keys.saveCustomer,
        tooltip: 'Save Changes',
        child: Icon(Icons.check),
        onPressed: () {
          if (Keys.editCustomerForm.currentState!.validate()) {
            Keys.editCustomerForm.currentState!.save();
            widget.onSave(widget.customer!, _name, _age);            
          }
        },
      ),
    );
  }
}