import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dart_graphql_client/dart_graphql_client.dart';

import '../actions/actions.dart';
import '../models/models.dart';
import '../models/app_state.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  return [
    NavigationMiddleware(),    
    TypedMiddleware<AppState, LoadCustomerAction>(_loadCustomer),
    TypedMiddleware<AppState, LoadCustomersAction>(_loadCustomers),
    TypedMiddleware<AppState, AddCustomerAction>(_addCustomer),
    TypedMiddleware<AppState, CustomerLoadedAction>(_customerLoaded),
    TypedMiddleware<AppState, CustomersLoadedAction>(_customersLoaded),
    TypedMiddleware<AppState, DeleteCustomerAction>(_deleteCustomer),
    TypedMiddleware<AppState, UpdateCustomerAction>(_updateCustomer)
  ];
}

final String API_URL = dotenv.env['API_URL']!;
final graphqlClient = DartGraphQLClient(API_URL);  

_loadCustomer(Store<AppState> store, LoadCustomerAction action, NextDispatcher next) async {    
  try {
    // load  
    final result = await graphqlClient.find(
      'docs { id, name, age }', 
      <String, dynamic>{ 
        'filter': { 
          'id': action.id
        } 
      });
  
    Customer? customer = null;
    if (result.containsKey('docs')) {
      customer = (result['docs'] as Iterable).map((customer) => Customer.fromJson(customer)).first;
    }

    store.dispatch(CustomerLoadedAction(customer!));
  } catch (err) {
    store.dispatch(CustomerNotLoadedAction());
  } 
}

_loadCustomers(Store<AppState> store, LoadCustomersAction action, NextDispatcher next) async {  
  try {    
    // load  
    final result = await graphqlClient.find(
      'docs { id, name, age }', 
      <String, dynamic>{ 
        'filter': {} 
      });    
  
    List<Customer> customers = [];
    if (result.containsKey('docs')) {
      customers = (result['docs'] as Iterable).map((customer) => Customer.fromJson(customer)).toList();
    }

    store.dispatch(CustomersLoadedAction(customers));
  } catch (err) {
    store.dispatch(CustomersNotLoadedAction());
  } 
  
  next(action);
}

_addCustomer(Store<AppState> store, AddCustomerAction action, NextDispatcher next) async {    
  next(action);

  //create
  await graphqlClient.insert(
    'success, message', 
    <String, dynamic>{ 
      'input': { 
        'customers': action.customer.toJson() 
      } 
    }); 
  
  store.dispatch(NavigateToAction.replace(Routes.listCustomers));
}

_customerLoaded(Store<AppState> store, action, NextDispatcher next) {
  next(action);
}

_customersLoaded(Store<AppState> store, action, NextDispatcher next) {
  next(action);
}

_deleteCustomer(Store<AppState> store, DeleteCustomerAction action, NextDispatcher next) async {  
  next(action);  

  //delete
  await graphqlClient.remove(
    'success, message', 
    <String, dynamic>{ 
      'input': { 
        'id': action.id
      } 
    });
  
  store.dispatch(LoadCustomersAction());
}

void _updateCustomer(Store<AppState> store, UpdateCustomerAction action, NextDispatcher next) async {
  next(action);

  final filter = {
    'id': action.customer.id
  };

  final update = {
    'name': action.customer.name, 
    'age': action.customer.age
  };
  //update
  await graphqlClient.upsert(
    'success, message', 
    <String, dynamic>{
      'input': {
        'filter': filter,
        'update': update
      }
    });
  
  store.dispatch(NavigateToAction.replace(Routes.listCustomers));
}