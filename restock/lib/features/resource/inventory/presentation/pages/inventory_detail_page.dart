import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restock/features/resource/inventory/domain/models/batch.dart';
import 'package:restock/features/resource/inventory/presentation/blocs/inventory_bloc.dart';
import 'package:restock/features/resource/inventory/presentation/blocs/inventory_state.dart';
import 'package:restock/features/resource/inventory/presentation/blocs/inventory_event.dart';
import 'batch_form_page.dart';

class InventoryDetailPage extends StatelessWidget {
  final String batchId;

  const InventoryDetailPage({
    super.key,
    required this.batchId,
  });

  @override
  Widget build(BuildContext context) {
    final greenColor = const Color(0xFF4F8A5B);

    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        final Batch? batch =
            state.batches.where((b) => b.id == batchId).firstOrNull;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Batch Details'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: batch == null
              ? const Center(child: Text('Batch not found'))
              : _BatchDetailContent(
                  batch: batch,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BatchFormPage(existingBatch: batch),
                      ),
                    );
                  },
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Delete batch'),
                        content: const Text(
                            'Are you sure you want to delete this batch?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      context
                          .read<InventoryBloc>()
                          .add(DeleteBatchEvent(batch.id));
                      Navigator.pop(context);
                    }
                  },
                  accentColor: greenColor,
                ),
        );
      },
    );
  }
}

class _BatchDetailContent extends StatelessWidget {
  final Batch batch;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Color accentColor;

  const _BatchDetailContent({
    required this.batch,
    required this.onEdit,
    required this.onDelete,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final customSupply = batch.customSupply;
    final supply = customSupply?.supply;
    final unit = customSupply?.unit;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Supply Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Divider(),
                  _DetailRow('Name', supply?.name ?? '-'),
                  _DetailRow('Description', supply?.description ?? '-'),
                  _DetailRow('Category', supply?.category ?? '-'),
                  _DetailRow(
                    'Perishable',
                    (supply?.perishable ?? false) ? 'Yes' : 'No',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Custom Supply Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Divider(),
                  _DetailRow(
                      'Min stock', customSupply?.minStock.toString() ?? '-'),
                  _DetailRow(
                      'Max stock', customSupply?.maxStock.toString() ?? '-'),
                  _DetailRow(
                      'Price', customSupply?.price.toString() ?? '-'),
                  _DetailRow(
                    'Unit',
                    '${unit?.name ?? '-'} (${unit?.abbreviation ?? ''})',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Batch Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Divider(),
                  _DetailRow('Current stock', batch.stock.toString()),
                  _DetailRow('Expiration date', batch.expirationDate ?? '-'),
                  _DetailRow('User ID', (batch.userId ?? 0).toString()),
                  _DetailRow('Batch ID', batch.id),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
