import 'package:flutter/material.dart';
import '../data/models/categoria_model.dart';
import '../data/services/categoria_service.dart';

class CategoriaProvider with ChangeNotifier {
  final CategoriaService _categoriaService = CategoriaService();

  List<CategoriaModel> _categorias = [];
  CategoriaModel? _categoriaSeleccionada;

  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<CategoriaModel> get categorias => _categorias;
  CategoriaModel? get categoriaSeleccionada => _categoriaSeleccionada;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Cargar todas las categorías
  void loadCategorias() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _categoriaService.getCategorias().listen(
          (categorias) {
        _categorias = categorias;
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void seleccionarCategoria(CategoriaModel? categoria) {
    _categoriaSeleccionada = categoria;
    notifyListeners();
  }

  void limpiarSeleccion() {
    _categoriaSeleccionada = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}