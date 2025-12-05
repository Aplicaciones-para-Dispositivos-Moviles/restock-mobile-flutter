 
import 'package:flutter/material.dart';
import 'package:restock/features/resource/inventory/domain/models/custom_supply.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restock/features/resource/inventory/presentation/blocs/inventory_bloc.dart';
import 'package:restock/features/resource/inventory/presentation/blocs/inventory_event.dart';

class SupplyDetailPage extends StatelessWidget {
  final CustomSupply? customSupply;

  const SupplyDetailPage({
    super.key,
    required this.customSupply,
  });

  @override
  Widget build(BuildContext context) {
    if (customSupply == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Supply Details')),
        body: const Center(child: Text('Supply not found')),
      );
    }

    final supply = customSupply!.supply;
    final greenColor = const Color(0xFF4F8A5B);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supply Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              supply?.name ?? 'Unnamed Supply',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoItem('Description', customSupply!.description),
                    _InfoItem('Min Stock', '${customSupply!.minStock}'),
                    _InfoItem('Max Stock', '${customSupply!.maxStock}'),
                    _InfoItem('Unit', customSupply!.unit.name),
                    _InfoItem(
                        'Unit Abbreviation', customSupply!.unit.abbreviation),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // aquí luego puedes navegar a SupplyFormPage para editar
                      // por ahora solo placeholder
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<InventoryBloc>().add(
                            DeleteCustomSupplyEvent(customSupply!.id),
                          );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
