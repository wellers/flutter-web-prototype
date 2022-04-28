import 'package:flutter/material.dart';

import 'containers/add_customer.dart';
import 'containers/edit_customer_screen.dart';
import 'containers/side_menu_screen.dart';
import 'models/models.dart';
import 'presentation/unknown_screen.dart';

Route getRoute(RouteSettings settings) {    
  if (settings.name!.startsWith(RegExp("^\/editCustomer\/[0-9a-fA-F]{24}"))) {              
    final parts = settings.name!.split('/');
    return _buildRoute(settings, EditCustomerScreen(id: parts[2]));
  }
  
  switch (settings.name) {
    case '/listCustomers':        
      return _buildRoute(settings, SideMenuScreen(tab: AppPage.listCustomers));
    case '/addCustomer':        
      return _buildRoute(settings, AddCustomer());      
    case '/':
      return _buildRoute(settings, SideMenuScreen(tab: AppPage.home));
    default:
      return _buildRoute(settings, UnknownScreen());
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return new MyCustomRoute(
    settings: settings,
    builder: (BuildContext context) => builder,
  );
}
  
class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ required WidgetBuilder builder, required RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return new FadeTransition(opacity: animation, child: child);
  }
}