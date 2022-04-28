import 'package:flutter/material.dart';

enum AppPage { 
  home, 
  listCustomers
}

extension AppPageExtensions on AppPage {
  appPageToRoute() {
    switch (this) {      
      case AppPage.listCustomers:
        return Routes.listCustomers;
      default:
        return Routes.home;        
    }
  }
}

class Routes {
  static final home = '/';  
  static final listCustomers = '/listCustomers';
  static final addCustomer = '/addCustomer';  
  static final editCustomer = (id) => '/editCustomer/$id';
}

class Keys {
  static final app = Key('reduxApp');
  static final addCustomerScreen = Key('addCustomerScreen');
  static final customers = Key('customers');
  static final customersList = Key('customersList');
  static final addCustomersButton = Key('addCustomersButton');
  static final customerLoadingIndicator = Key('customerLoadingIndicator');
  static final editCustomerScreen = Key('editCustomerScreen');
  static final activePage = Key('activePage');
  static final addNameField = Key('addNameField');
  static final addAgeField = Key('addAgeField');
  static final saveNewCustomer = Key('saveNewCustomer');
  static final customerList = (id) => Key('customer_$id');
  static final customersLoading = Key('customersLoading');
  static final customersLoadingIndicator =Key('customersLoadingIndicator');  
  static final addCustomerForm = GlobalKey<FormState>(debugLabel: 'addCustomerForm');
  static final editCustomerForm = GlobalKey<FormState>(debugLabel: 'editCustomerForm');
  static final editNameField = Key('editNameField');
  static final editAgeField = Key('editAgeField');
  static final saveCustomer = Key('saveCustomer');
}

class CustomerInput {
  final String name;
  final int age;

  const CustomerInput({    
    required this.name,
    required this.age,     
  });
  
  factory CustomerInput.fromJson(Map<String, dynamic> json) => CustomerInput(      
      name: json['name'],
      age: json['age'],
    );

  factory CustomerInput.fromCustomer(Customer customer) => CustomerInput(name: customer.name, age: customer.age);

  Map<String, dynamic> toJson() => {"name": name, "age": age};
}

class Customer {
  final String id;
  final String name;
  final int age;

  const Customer({    
    required this.name,
    required this.age, 
    required this.id    
  });

  Customer copyWith({String? id, String? name, int? age}) {
    return Customer(      
      name: name ?? this.name,
      age: age ?? this.age,
      id: id ?? this.id,
    );
  }
  
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );

  Map<String, dynamic> toJson() => {"name": name, "age": age};
}