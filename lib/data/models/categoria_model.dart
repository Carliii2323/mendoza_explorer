import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriaModel {
  final String id;
  final String nombre;
  final String? icono;
  final String colorHex;
  final int orden;
  final bool activa;

  CategoriaModel({
    required this.id,
    required this.nombre,
    this.icono,
    required this.colorHex,
    required this.orden,
    this.activa = true,
  });

  factory CategoriaModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CategoriaModel(
      id: doc.id,
      nombre: data['nombre'] ?? '',
      icono: data['icono'],
      colorHex: data['color'] ?? '#4CAF50',
      orden: data['orden'] ?? 0,
      activa: data['activa'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'icono': icono,
      'color': colorHex,
      'orden': orden,
      'activa': activa,
    };
  }

  Color get color {
    return Color(
      int.parse(colorHex.replaceAll('#', '0xFF')),
    );
  }

  CategoriaModel copyWith({
    String? id,
    String? nombre,
    String? icono,
    String? colorHex,
    int? orden,
    bool? activa,
  }) {
    return CategoriaModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      icono: icono ?? this.icono,
      colorHex: colorHex ?? this.colorHex,
      orden: orden ?? this.orden,
      activa: activa ?? this.activa,
    );
  }
}