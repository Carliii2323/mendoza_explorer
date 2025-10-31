import 'package:flutter/material.dart';
import '../data/models/atraccion_model.dart';
import '../data/services/atraccion_service.dart';

class AtraccionProvider with ChangeNotifier {
  final AtraccionService _atraccionService = AtraccionService();

  List<AtraccionModel> _atracciones = [];
  List<AtraccionModel> _atraccionesFiltradas = [];
  List<AtraccionModel> _atraccionesDestacadas = [];
  AtraccionModel? _atraccionSeleccionada;

  bool _isLoading = false;
  String? _errorMessage;
  String _filtroTipo = 'todos';
  String _searchQuery = '';

  // Getters
  List<AtraccionModel> get atracciones => _atraccionesFiltradas;
  List<AtraccionModel> get atraccionesDestacadas => _atraccionesDestacadas;
  AtraccionModel? get atraccionSeleccionada => _atraccionSeleccionada;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get filtroTipo => _filtroTipo;
  String get searchQuery => _searchQuery;

  // Cargar todas las atracciones
  void loadAtracciones() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _atraccionService.getAtracciones().listen(
          (atracciones) {
        _atracciones = atracciones;
        _aplicarFiltros();
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

  // Cargar atracciones destacadas
  void loadAtraccionesDestacadas() {
    _atraccionService.getAtraccionesDestacadas().listen(
          (atracciones) {
        _atraccionesDestacadas = atracciones;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // Filtrar por tipo
  void filtrarPorTipo(String tipo) {
    _filtroTipo = tipo;

    if (tipo == 'todos') {
      loadAtracciones();
    } else {
      _isLoading = true;
      notifyListeners();

      _atraccionService.getAtraccionesByTipo(tipo).listen(
            (atracciones) {
          _atracciones = atracciones;
          _aplicarFiltros();
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
  }

  // Buscar atracciones
  Future<void> buscarAtracciones(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      _aplicarFiltros();
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      List<AtraccionModel> resultados =
      await _atraccionService.searchAtracciones(query);

      _atraccionesFiltradas = resultados;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Aplicar filtros locales
  void _aplicarFiltros() {
    _atraccionesFiltradas = _atracciones;

    if (_searchQuery.isNotEmpty) {
      _atraccionesFiltradas = _atraccionesFiltradas
          .where((a) => a.nombre
          .toLowerCase()
          .contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  // Seleccionar atracción
  Future<void> seleccionarAtraccion(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      _atraccionSeleccionada = await _atraccionService.getAtraccionById(id);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void limpiarSeleccion() {
    _atraccionSeleccionada = null;
    notifyListeners();
  }

  void limpiarBusqueda() {
    _searchQuery = '';
    _aplicarFiltros();
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}