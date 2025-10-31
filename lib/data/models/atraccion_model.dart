import 'package:cloud_firestore/cloud_firestore.dart';

class Ubicacion {
  final String direccion;
  final double latitud;
  final double longitud;
  final double? distanciaKm;

  Ubicacion({
    required this.direccion,
    required this.latitud,
    required this.longitud,
    this.distanciaKm,
  });

  factory Ubicacion.fromMap(Map<String, dynamic> map) {
    return Ubicacion(
      direccion: map['direccion'] ?? '',
      latitud: (map['latitud'] ?? 0.0).toDouble(),
      longitud: (map['longitud'] ?? 0.0).toDouble(),
      distanciaKm: map['distancia_km']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'direccion': direccion,
      'latitud': latitud,
      'longitud': longitud,
      'distancia_km': distanciaKm,
    };
  }
}

class AtraccionModel {
  final String id;
  final String nombre;
  final String tipo;
  final String descripcion;
  final Ubicacion ubicacion;
  final List<String> imagenes;
  final double precio;
  final String moneda;
  final double? rating;
  final int? totalReviews;
  final List<String> caracteristicas;
  final List<String> servicios;
  final Map<String, String>? horarios;
  final bool disponibilidad;
  final bool topRanked;
  final DateTime createdAt;
  final DateTime updatedAt;

  AtraccionModel({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.descripcion,
    required this.ubicacion,
    List<String>? imagenes,
    required this.precio,
    this.moneda = 'USD',
    this.rating,
    this.totalReviews,
    List<String>? caracteristicas,
    List<String>? servicios,
    this.horarios,
    this.disponibilidad = true,
    this.topRanked = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : this.imagenes = imagenes ?? [],
        this.caracteristicas = caracteristicas ?? [],
        this.servicios = servicios ?? [],
        this.createdAt = createdAt ?? DateTime.now(),
        this.updatedAt = updatedAt ?? DateTime.now();

  factory AtraccionModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AtraccionModel(
      id: doc.id,
      nombre: data['nombre'] ?? '',
      tipo: data['tipo'] ?? '',
      descripcion: data['descripcion'] ?? '',
      ubicacion: Ubicacion.fromMap(data['ubicacion'] ?? {}),
      imagenes: List<String>.from(data['imagenes'] ?? []),
      precio: (data['precio'] ?? 0.0).toDouble(),
      moneda: data['moneda'] ?? 'USD',
      rating: data['rating']?.toDouble(),
      totalReviews: data['totalReviews'],
      caracteristicas: List<String>.from(data['caracteristicas'] ?? []),
      servicios: List<String>.from(data['servicios'] ?? []),
      horarios: data['horarios'] != null
          ? Map<String, String>.from(data['horarios'])
          : null,
      disponibilidad: data['disponibilidad'] ?? true,
      topRanked: data['topRanked'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'tipo': tipo,
      'descripcion': descripcion,
      'ubicacion': ubicacion.toMap(),
      'imagenes': imagenes,
      'precio': precio,
      'moneda': moneda,
      'rating': rating,
      'totalReviews': totalReviews,
      'caracteristicas': caracteristicas,
      'servicios': servicios,
      'horarios': horarios,
      'disponibilidad': disponibilidad,
      'topRanked': topRanked,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}