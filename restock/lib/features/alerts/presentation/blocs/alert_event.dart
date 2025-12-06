// Archivo: restock/features/resource/alerts/presentation/blocs/alert_event.dart

abstract class AlertEvent {
  const AlertEvent();
}

class AlertsLoadRequested extends AlertEvent {
  const AlertsLoadRequested();
}

/// Evento para limpiar el estado
class AlertsClearRequested extends AlertEvent {
  const AlertsClearRequested();
}

