// lib/domain/repositories/orders_repository.dart
 
import 'package:restock/features/resource/orders/domain/models/order.dart';

abstract class OrdersRepository {
  Future<List<Order>> getAllOrders();
  Future<List<Order>> getOrdersByAdminRestaurantId(int adminRestaurantId);
  Future<List<Order>> getOrdersBySupplierId(int supplierId);
  Future<Order?> getOrderById(int orderId);
  Future<Order?> createOrder(Order order);
  Future<Order?> updateOrder(Order order);
  Future<void> deleteOrder(int orderId);
}
