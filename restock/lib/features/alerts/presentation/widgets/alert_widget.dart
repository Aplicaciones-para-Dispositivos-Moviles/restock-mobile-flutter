import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:restock/features/alerts/domain/models/alert.dart';

class AlertCard extends StatelessWidget {
  final Alert alert;
  final Color baseColor;

  const AlertCard({
    required this.alert,
    required this.baseColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd, yyyy HH:mm').format(alert.date);
    
    // Usamos Card para darle un borde y elevación, y ListTile para el contenido
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: baseColor, width: 4.0), 
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alert.message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Fila de Situación y Fecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Situación (con color de fondo para resaltar)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: baseColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    alert.situationDescription.replaceAll('_', ' '),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: baseColor,
                      fontSize: 13,
                    ),
                  ),
                ),

                // Fecha
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Detalles adicionales (Order ID)
            Text(
              'Order ID: #${alert.orderId}',
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
            
            // Separador opcional para más acciones
            // Divider(color: Colors.grey.shade300, height: 20),
            
            // Aquí puedes añadir botones o un onTap para ir al detalle de la Orden
            // TextButton(
            //   onPressed: () {
            //     // Lógica para navegar al detalle de la orden
            //   },
            //   child: Text('View Order Details', style: TextStyle(color: baseColor)),
            // )
          ],
        ),
      ),
    );
  }
}