import 'package:flutter/material.dart';

import '../models/models.dart';

typedef OnSaveCallback = void Function(String name, String age);

class AddScreen extends StatefulWidget {
  final OnSaveCallback onSave;

  AddScreen(
      {required Key key, required this.onSave})
      : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late String _name;
  late String _age;

  @override
  Widget build(BuildContext context) {    
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: Keys.addCustomerForm,
          child: ListView(
            children: [
              TextFormField(
                initialValue: '',
                key: Keys.addNameField,
                autofocus: true,
                style: textTheme.titleMedium,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                validator: (val) {
                  return val!.trim().isEmpty
                      ? 'Name is required'
                      : null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: '',
                key: Keys.addAgeField,                
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
        key: Keys.saveNewCustomer,
        tooltip: 'Add Customer',
        child: Icon(Icons.add),
        onPressed: () {
          if (Keys.addCustomerForm.currentState!.validate()) {
            Keys.addCustomerForm.currentState!.save();
            widget.onSave(_name, _age);            
          }
        },
      ),
    );
  }
}