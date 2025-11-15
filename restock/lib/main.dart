import 'package:restock/features/auth/data/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restock/features/auth/presentation/blocs/login_bloc.dart';
import 'package:restock/features/auth/presentation/blocs/register_bloc.dart';
import 'package:restock/features/auth/presentation/pages/login_page.dart';
import 'package:restock/features/home/presentation/pages/home_page.dart';

void main() {
  final authService = AuthService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(service: authService)),
        BlocProvider(create: (_) => RegisterBloc(service: authService)),
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

      home: const LoginPage(),

      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}
