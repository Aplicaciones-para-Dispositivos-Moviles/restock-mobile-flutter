
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restock/features/auth/data/local/auth_storage.dart';
import 'package:restock/features/auth/data/remote/auth_service.dart';
import 'package:restock/features/auth/presentation/blocs/login_bloc.dart';
import 'package:restock/features/auth/presentation/blocs/register_bloc.dart';
import 'package:restock/features/auth/presentation/pages/login_page.dart';
import 'package:restock/features/home/presentation/pages/home_page.dart';

// INVENTORY
import 'package:restock/features/resource/inventory/data/remote/inventory_service.dart';
import 'package:restock/features/resource/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:restock/features/resource/inventory/presentation/blocs/inventory_bloc.dart';
import 'package:restock/features/resource/inventory/presentation/pages/inventory_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService();
  final authStorage = AuthStorage();

  final inventoryService = InventoryService();
  final inventoryRepository = InventoryRepositoryImpl(
    service: inventoryService,
    getUserId: () async {
      final id = await authStorage.getUserId();
      if (id == null) {
        throw Exception('No hay usuario logueado');
      }
      return id;
    },
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(
            service: authService,
            storage: authStorage,
          ),
        ),
        BlocProvider(
          create: (_) => RegisterBloc(
            service: authService,
            storage: authStorage,
          ),
        ),
        BlocProvider(
          create: (_) => InventoryBloc(repository: inventoryRepository),
        ),
      ],
      child: const RestockApp(),
    ),
  );
}

class RestockApp extends StatelessWidget {
  const RestockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restock',
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
        '/inventory': (_) => const InventoryPage(),
      },
    );
  }
}
