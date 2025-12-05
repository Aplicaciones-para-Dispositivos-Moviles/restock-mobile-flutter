 
import 'package:restock/features/auth/domain/models/user.dart';
import 'package:restock/features/resource/orders/domain/models/order_batch_item.dart';
import 'package:restock/features/resource/orders/domain/models/order_situation.dart';
import 'package:restock/features/resource/orders/domain/models/order_state.dart';

class Order {
  final int id;
  final int adminRestaurantId;
  final int supplierId;
  final User supplier;
  final String requestedDate;
  final bool partiallyAccepted;
  final int requestedProductsCount;
  final double totalPrice;
  final OrderState state;
  final OrderSituation situation;
  final List<OrderBatchItem> batchItems;

  const Order({
    required this.id,
    required this.adminRestaurantId,
    required this.supplierId,
    required this.supplier,
    this.requestedDate = '',
    this.partiallyAccepted = false,
    this.requestedProductsCount = 0,
    this.totalPrice = 0.0,
    this.state = OrderState.onHold,
    this.situation = OrderSituation.pending,
    this.batchItems = const [],
  });

  Order copyWith({
    int? id,
    int? adminRestaurantId,
    int? supplierId,
    User? supplier,
    String? requestedDate,
    bool? partiallyAccepted,
    int? requestedProductsCount,
    double? totalPrice,
    OrderState? state,
    OrderSituation? situation,
    List<OrderBatchItem>? batchItems,
  }) {
    return Order(
      id: id ?? this.id,
      adminRestaurantId: adminRestaurantId ?? this.adminRestaurantId,
      supplierId: supplierId ?? this.supplierId,
      supplier: supplier ?? this.supplier,
      requestedDate: requestedDate ?? this.requestedDate,
      partiallyAccepted: partiallyAccepted ?? this.partiallyAccepted,
      requestedProductsCount:
          requestedProductsCount ?? this.requestedProductsCount,
      totalPrice: totalPrice ?? this.totalPrice,
      state: state ?? this.state,
      situation: situation ?? this.situation,
      batchItems: batchItems ?? this.batchItems,
    );
  }
}
