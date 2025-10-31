import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/services/auth_service.dart';
import '../data/models/user_model.dart';

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
  error,
}

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  AuthStatus _status = AuthStatus.initial;
  UserModel? _currentUser;
  String? _errorMessage;

  // Getters
  AuthStatus get status => _status;
  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.loading;

  // Constructor
  AuthProvider() {
    _initializeAuth();
  }

  // Inicializar - escuchar cambios de autenticación
  void _initializeAuth() {
    _authService.userStream.listen((User? user) {
      if (user != null) {
        _loadUserData(user.uid);
      } else {
        _status = AuthStatus.unauthenticated;
        _currentUser = null;
        notifyListeners();
      }
    });
  }

  // Cargar datos del usuario
  Future<void> _loadUserData(String uid) async {
    try {
      _currentUser = await _authService.getCurrentUserData();
      _status = AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Registrar usuario
  Future<bool> register({
    required String email,
    required String password,
    required String nombre,
    String? telefono,
  }) async {
    try {
      _status = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      _currentUser = await _authService.registerWithEmail(
        email: email,
        password: password,
        nombre: nombre,
        telefono: telefono,
      );

      if (_currentUser != null) {
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }

      _status = AuthStatus.error;
      _errorMessage = 'Error al registrar usuario';
      notifyListeners();
      return false;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Iniciar sesión
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _status = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      _currentUser = await _authService.signInWithEmail(
        email: email,
        password: password,
      );

      if (_currentUser != null) {
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }

      _status = AuthStatus.error;
      _errorMessage = 'Error al iniciar sesión';
      notifyListeners();
      return false;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      _status = AuthStatus.loading;
      notifyListeners();

      await _authService.signOut();

      _status = AuthStatus.unauthenticated;
      _currentUser = null;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Recuperar contraseña
  Future<bool> resetPassword(String email) async {
    try {
      _status = AuthStatus.loading;
      _errorMessage = null;
      notifyListeners();

      await _authService.resetPassword(email);

      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Actualizar perfil
  Future<bool> updateProfile({
    String? nombre,
    String? telefono,
    String? photoUrl,
  }) async {
    try {
      _status = AuthStatus.loading;
      notifyListeners();

      await _authService.updateUserProfile(
        nombre: nombre,
        telefono: telefono,
        photoUrl: photoUrl,
      );

      // Recargar datos del usuario
      if (_currentUser != null) {
        await _loadUserData(_currentUser!.uid);
      }

      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Limpiar error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}