import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/models.dart';

final customerReducer = combineReducers<Customer?>([  
  TypedReducer<Customer?, CustomerLoadedAction>(_setLoadedCustomer),
  TypedReducer<Customer?, CustomerNotLoadedAction>(_setNoLoadedCustomer),
  TypedReducer<Customer?, CustomersLoadedAction>(_setLoadedCustomers),
]);

Customer? _setLoadedCustomer(Customer? customer, CustomerLoadedAction action) {  
  return action.customer;
}
Customer? _setNoLoadedCustomer(Customer? state, CustomerNotLoadedAction action) {
  return null;
}

Customer? _setLoadedCustomers(Customer? state, CustomersLoadedAction action) {
  return null;
}
