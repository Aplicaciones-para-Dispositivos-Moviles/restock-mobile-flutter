
import 'package:restock/features/alerts/domain/models/alert.dart';

class AlertState {
  final List<Alert> supplierAlerts; // Alertas para el proveedor
  final List<Alert> adminAlerts;    // Alertas para el administrador
  final bool loading;
  final String? error;

  const AlertState({
    this.supplierAlerts = const [],
    this.adminAlerts = const [],
    this.loading = false,
    this.error,
  });

  AlertState copyWith({
    List<Alert>? supplierAlerts,
    List<Alert>? adminAlerts,
    bool? loading,
    String? error,
  }) {
    return AlertState(
      supplierAlerts: supplierAlerts ?? this.supplierAlerts,
      adminAlerts: adminAlerts ?? this.adminAlerts,
      loading: loading ?? this.loading,
      error: error, 
    );
  }
}