import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final AuthService _authService =
  AuthService();

  bool isLoading = false;

  bool obscurePassword = true;

  String? errorMessage;

  // ==========================================
  // LOGIN
  // ==========================================

  Future<void> login() async {

    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {

      setState(() {
        errorMessage =
        'Please enter email and password.';
      });

      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {

      await _authService.login(
        emailController.text,
        passwordController.text,
      );

    } on FirebaseAuthException catch (e) {

      setState(() {
        errorMessage =
            getAuthErrorMessage(e.code);
      });

    } catch (e) {

      setState(() {
        errorMessage =
        'Something went wrong.';
      });

    } finally {

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ==========================================
  // AUTH ERROR
  // ==========================================

  String getAuthErrorMessage(
      String code,
      ) {

    switch (code) {

      case 'invalid-credential':
        return 'Invalid email or password.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
        return 'Incorrect password.';

      case 'invalid-email':
        return 'Please enter a valid email.';

      case 'too-many-requests':
        return 'Too many attempts. Try again later.';

      default:
        return 'Login failed. Please try again.';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  // ==========================================
  // UI
  // ==========================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Center(

          child: SingleChildScrollView(

            padding:
            const EdgeInsets.all(25),

            child: Column(

              children: [

                const Icon(
                  Icons.task_alt,
                  size: 90,
                  color: Colors.deepPurple,
                ),

                const SizedBox(height: 15),

                const Text(
                  'My TODO App',

                  style: TextStyle(
                    fontSize: 30,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Login to manage your tasks',
                  style: TextStyle(
                    color:
                    Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 35),

                // EMAIL
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

                // PASSWORD
                TextField(
                  controller:
                  passwordController,

                  obscureText:
                  obscurePassword,

                  decoration:
                  InputDecoration(
                    labelText: 'Password',

                    prefixIcon:
                    const Icon(
                      Icons.lock,
                    ),

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

                // ERROR
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

                const SizedBox(height: 15),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child:
                  ElevatedButton(

                    onPressed:
                    isLoading
                        ? null
                        : login,

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
                      'LOGIN',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // REGISTER
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    const Text(
                      "Don't have an account? ",
                    ),

                    TextButton(
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                            const RegisterScreen(),
                          ),
                        );
                      },

                      child:
                      const Text(
                        'Register',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}