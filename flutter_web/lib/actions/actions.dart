
import '../models/models.dart';

class LoadCustomersAction {}

class CustomersNotLoadedAction {}

class CustomersLoadedAction {
  final List<Customer> customers;

  CustomersLoadedAction(this.customers);

  @override
  String toString() {
    return 'CustomersLoadedAction{customers: $customers}';
  }
}

class LoadCustomerAction {
  final String id;

  LoadCustomerAction(this.id);

  @override
  String toString() {
    return 'LoadCustomerAction{id: $id}';
  }
}

class CustomerNotLoadedAction {}

class CustomerLoadedAction {
  final Customer customer;

  CustomerLoadedAction(this.customer);

  @override
  String toString() {
    return 'CustomerLoadedAction{customers: $customer}';
  }
}

class DeleteCustomerAction {
  final String id;

  DeleteCustomerAction(this.id);

  @override
  String toString() {
    return 'DeleteCustomerAction{id: $id}';
  }
}

class AddCustomerAction {
  final CustomerInput customer;

  AddCustomerAction({required this.customer});  

  @override
  String toString() {
    return 'AddCustomerAction{customer: $customer}';
  }  
}

class UpdateCustomerAction {
  final String id;
  final Customer customer;

  UpdateCustomerAction({required this.id, required this.customer});  

  @override
  String toString() {
    return 'UpdateCustomerAction{customer: $customer}';
  }  
}