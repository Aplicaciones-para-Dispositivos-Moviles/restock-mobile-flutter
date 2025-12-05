// lib/features/resources/orders/data/repositories/orders_repository_impl.dart
 
import 'package:restock/features/resource/orders/data/models/order_request_dto.dart';
import 'package:restock/features/resource/orders/data/remote/orders_service.dart';
import 'package:restock/features/resource/orders/domain/models/order.dart';
import 'package:restock/features/resource/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersService service;

  OrdersRepositoryImpl({required this.service});

  @override
  Future<List<Order>> getAllOrders() async {
    try {
      final dtos = await service.getAllOrders();
      return dtos.map((e) => e.toDomain()).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<Order>> getOrdersByAdminRestaurantId(
      int adminRestaurantId) async {
    try {
      final dtos = await service.getOrdersByAdminRestaurantId(
        adminRestaurantId,
      );
      return dtos.map((e) => e.toDomain()).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<Order>> getOrdersBySupplierId(int supplierId) async {
    try {
      final dtos = await service.getOrdersBySupplierId(supplierId);
      return dtos.map((e) => e.toDomain()).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<Order?> getOrderById(int orderId) async {
    try {
      final dto = await service.getOrderById(orderId);
      return dto?.toDomain();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Order?> createOrder(Order order) async {
    try {
      final dto = OrderRequestDto.fromDomain(order);
      final responseDto = await service.createOrder(dto);
      return responseDto?.toDomain();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Order?> updateOrder(Order order) async {
    try {
      final dto = OrderRequestDto.fromDomain(order);
      final responseDto = await service.updateOrder(order.id, dto);
      return responseDto?.toDomain();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> deleteOrder(int orderId) async {
    try {
      await service.deleteOrder(orderId);
    } catch (_) {
      // ignora error por ahora
    }
  }
}
