// lib/features/resources/orders/data/remote/orders_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restock/core/constants/api_constants.dart';
import 'package:restock/features/resource/orders/data/models/order_dto.dart';
import 'package:restock/features/resource/orders/data/models/order_request_dto.dart';
 
class OrdersService {
  final http.Client client;

  OrdersService({http.Client? client}) : client = client ?? http.Client();

  Uri _uri(String path) => Uri.parse('${ApiConstants.baseUrl}$path');

  Map<String, String> _headers() => {
        'Content-Type': 'application/json',
        // aquí luego puedes sumar Authorization
      };

  Future<List<OrderDto>> getAllOrders() async {
    final response =
        await client.get(_uri(ApiConstants.ordersEndpoint), headers: _headers());

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => OrderDto.fromJson(e)).toList().cast<OrderDto>();
    }
    throw Exception('Failed to load orders (${response.statusCode})');
  }

  Future<List<OrderDto>> getOrdersByAdminRestaurantId(
      int adminRestaurantId) async {
    final response = await client.get(
      _uri(ApiConstants.ordersByAdminRestaurantId(adminRestaurantId)),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => OrderDto.fromJson(e)).toList().cast<OrderDto>();
    }
    throw Exception(
        'Failed to load orders by admin (${response.statusCode})');
  }

  Future<List<OrderDto>> getOrdersBySupplierId(int supplierId) async {
    final response = await client.get(
      _uri(ApiConstants.ordersBySupplierId(supplierId)),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => OrderDto.fromJson(e)).toList().cast<OrderDto>();
    }
    throw Exception(
        'Failed to load orders by supplier (${response.statusCode})');
  }

  Future<OrderDto?> getOrderById(int orderId) async {
    final response = await client.get(
      _uri(ApiConstants.orderById(orderId)),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return OrderDto.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<OrderDto?> createOrder(OrderRequestDto dto) async {
    final response = await client.post(
      _uri(ApiConstants.ordersEndpoint),
      headers: _headers(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return OrderDto.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<OrderDto?> updateOrder(int id, OrderRequestDto dto) async {
    final response = await client.put(
      _uri(ApiConstants.orderById(id)),
      headers: _headers(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      return OrderDto.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<void> deleteOrder(int id) async {
    await client.delete(
      _uri(ApiConstants.orderDelete(id)),
      headers: _headers(),
    );
  }
}
