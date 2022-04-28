import '../models/app_state.dart';
import 'loading_reducer.dart';
import 'customers_reducer.dart';
import 'customer_reducer.dart';

AppState appStateReducer(AppState state, action) {  
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    customers: customersReducer(state.customers, action),
    customer: customerReducer(state.customer, action)
  );
}