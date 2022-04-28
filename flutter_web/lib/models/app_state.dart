import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'models.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Customer> customers;    
  final Customer? customer;

  AppState({
    this.isLoading = false,
    this.customers = const [],
    this.customer = null  
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    required bool isLoading,
    required List<Customer> customers,    
  }) {
    return AppState(
      isLoading: isLoading,
      customers: customers      
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      customers.hashCode;      

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          customers == other.customers;          

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, customers: $customers}';
  }
}