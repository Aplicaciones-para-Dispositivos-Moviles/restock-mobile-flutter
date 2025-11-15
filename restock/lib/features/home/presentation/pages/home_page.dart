import 'package:flutter/material.dart';
import 'package:restock/features/common/placeholder_screen.dart';
import 'package:restock/features/home/presentation/widgets/quick_action_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goTo(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlaceholderScreen(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF1B5E20);

    return Scaffold(
      // ------------------- DRAWER -------------------
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: primaryGreen),
              child: const Center(
                child: Text(
                  "Restock Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            // Opciones de navegación
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text("Inventory"),
              onTap: () => _goTo(context, "Inventory"),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Orders"),
              onTap: () => _goTo(context, "Orders"),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text("Recipes"),
              onTap: () => _goTo(context, "Recipes"),
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text("Sales"),
              onTap: () => _goTo(context, "Sales"),
            ),

            const Spacer(),

            // ------------------- LOGOUT ABAJO -------------------
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (_) => false);
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),

      // ------------------- APPBAR -------------------
      appBar: AppBar(
        title: const Text("Restock"),
        centerTitle: true,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),

      // ------------------- BODY ORIGINAL -------------------
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
                    onTap: () => _goTo(context, "Inventory"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.shopping_cart,
                    title: "Orders",
                    subtitle: "Make orders",
                    onTap: () => _goTo(context, "Orders"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.restaurant,
                    title: "Recipes",
                    subtitle: "Manage recipes",
                    onTap: () => _goTo(context, "Recipes"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.point_of_sale,
                    title: "Sales",
                    subtitle: "Register sales",
                    onTap: () => _goTo(context, "Sales"),
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
                        Icon(Icons.trending_up, color: Colors.green.shade700),
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
