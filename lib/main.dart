import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
    DefaultFirebaseOptions
        .currentPlatform,
  );

  runApp(
    const TodoApp(),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Firebase TODO App',

      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSeed(
          seedColor:
          Colors.deepPurple,
        ),

        useMaterial3: true,
      ),

      home:
      const AuthWrapper(),
    );
  }
}

// =====================================================
// AUTH WRAPPER
// =====================================================

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final AuthService authService =
    AuthService();

    return StreamBuilder(
      stream:
      authService.authStateChanges,

      builder:
          (context, snapshot) {

        // Firebase auth check
        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child:
              CircularProgressIndicator(),
            ),
          );
        }

        // User logged in
        if (snapshot.hasData) {

          return const HomeScreen();
        }

        // User logged out
        return const LoginScreen();
      },
    );
  }
}