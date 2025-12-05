import 'package:restock/features/resource/inventory/domain/models/supply.dart';

class SupplyDto {
  final int? id;
  final String name;
  final String? description;
  final bool? perishable;
  final String? category;

  const SupplyDto({
    required this.id,
    required this.name,
    this.description,
    this.perishable,
    this.category,
  });

  factory SupplyDto.fromJson(Map<String, dynamic> json) {
    return SupplyDto(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'],
      perishable: json['perishable'],
      category: json['category'],
    );
  }

  Supply toDomain() {
    return Supply(
      id: id ?? 0,
      name: name,
      description: description,
      perishable: perishable ?? false,
      category: category,
    );
  }
}