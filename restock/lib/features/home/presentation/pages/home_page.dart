import 'package:flutter/material.dart'; 
import 'package:restock/features/auth/data/local/auth_storage.dart';
import 'package:restock/features/common/placeholder_screen.dart';
import 'package:restock/features/home/presentation/widgets/quick_action_card.dart';
import 'package:restock/features/resource/inventory/presentation/blocs/inventory_bloc.dart';
import 'package:restock/features/resource/inventory/presentation/blocs/inventory_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goPlaceholder(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlaceholderScreen(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF1B5E20);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: primaryGreen),
              child: Center(
                child: Text(
                  "Restock Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            // INVENTORY -> va a la ruta real
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text("Inventory"),
              onTap: () {
                Navigator.pop(context); // cierra drawer
                Navigator.pushNamed(context, '/inventory');
              },
            ),

            // Otras opciones siguen con placeholder
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Orders"),
              onTap: () => _goPlaceholder(context, "Orders"),
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title:
                  const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () async {
                await AuthStorage().clear(); // borra userId y token

                context.read<InventoryBloc>()
                    .add(const InventoryClearRequested()); // limpiamos el estado

                Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Restock"),
        centerTitle: true,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black54),
            ),
            Text(
              "Supplier",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
            ),
            const SizedBox(height: 32),
            Text(
              "Quick Actions",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.inventory,
                    title: "Inventory",
                    subtitle: "Track supplies",
                    onTap: () => Navigator.pushNamed(context, '/inventory'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.shopping_cart,
                    title: "Orders",
                    subtitle: "Make orders",
                    onTap: () => _goPlaceholder(context, "Orders"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Business",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.trending_up,
                            color: Colors.green.shade700),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Start managing your recipes, inventory and sales to see insights here.",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
