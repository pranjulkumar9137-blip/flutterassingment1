import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final confirmPasswordController =
  TextEditingController();

  final AuthService _authService =
  AuthService();

  bool isLoading = false;

  bool obscurePassword = true;

  String? errorMessage;

  // ==========================================
  // REGISTER
  // ==========================================

  Future<void> register() async {

    final email =
    emailController.text.trim();

    final password =
        passwordController.text;

    final confirmPassword =
        confirmPasswordController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {

      setState(() {
        errorMessage =
        'Please fill all fields.';
      });

      return;
    }

    if (password.length < 6) {

      setState(() {
        errorMessage =
        'Password must be at least 6 characters.';
      });

      return;
    }

    if (password != confirmPassword) {

      setState(() {
        errorMessage =
        'Passwords do not match.';
      });

      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {

      await _authService.register(
        email,
        password,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text('Account created successfully!'),
        ),
      );

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      setState(() {
        errorMessage =
            getErrorMessage(e.code);
      });

    } catch (e) {

      setState(() {
        errorMessage =
        'Registration failed.';
      });

    } finally {

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String getErrorMessage(String code) {

    switch (code) {

      case 'email-already-in-use':
        return 'This email is already registered.';

      case 'invalid-email':
        return 'Please enter a valid email.';

      case 'weak-password':
        return 'Password is too weak.';

      default:
        return 'Registration failed.';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Create Account',
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
          const EdgeInsets.all(25),

          child: Column(

            children: [

              const Icon(
                Icons.person_add,
                size: 80,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),

              const Text(
                'Create Account',

                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller:
                emailController,

                keyboardType:
                TextInputType.emailAddress,

                decoration:
                const InputDecoration(
                  labelText: 'Email',
                  prefixIcon:
                  Icon(Icons.email),
                  border:
                  OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller:
                passwordController,

                obscureText:
                obscurePassword,

                decoration:
                InputDecoration(
                  labelText: 'Password',

                  prefixIcon:
                  const Icon(Icons.lock),

                  suffixIcon:
                  IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),

                    onPressed: () {
                      setState(() {
                        obscurePassword =
                        !obscurePassword;
                      });
                    },
                  ),

                  border:
                  const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller:
                confirmPasswordController,

                obscureText:
                obscurePassword,

                decoration:
                const InputDecoration(
                  labelText:
                  'Confirm Password',

                  prefixIcon:
                  Icon(Icons.lock_outline),

                  border:
                  OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              if (errorMessage != null)
                Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(12),

                  decoration:
                  BoxDecoration(
                    color:
                    Colors.red.shade50,

                    borderRadius:
                    BorderRadius.circular(10),
                  ),

                  child: Text(
                    errorMessage!,

                    style: TextStyle(
                      color:
                      Colors.red.shade700,
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,

                child:
                ElevatedButton(

                  onPressed:
                  isLoading
                      ? null
                      : register,

                  child: isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'CREATE ACCOUNT',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}