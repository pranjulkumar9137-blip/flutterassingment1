import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // ============================================
  // REGISTER
  // ============================================

  Future<UserCredential> register(
      String email,
      String password,
      ) async {
    return await _auth
        .createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // ============================================
  // LOGIN
  // ============================================

  Future<UserCredential> login(
      String email,
      String password,
      ) async {
    return await _auth
        .signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // ============================================
  // LOGOUT
  // ============================================

  Future<void> logout() async {
    await _auth.signOut();
  }

  // ============================================
  // CURRENT USER
  // ============================================

  User? get currentUser {
    return _auth.currentUser;
  }

  // ============================================
  // AUTH STATE
  // ============================================

  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }
}