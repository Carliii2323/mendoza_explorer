import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String nombre;
  final String? telefono;
  final String? photoUrl;
  final List<String> favoritos;
  final List<String> reservas;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.nombre,
    this.telefono,
    this.photoUrl,
    List<String>? favoritos,
    List<String>? reservas,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : this.favoritos = favoritos ?? [],
        this.reservas = reservas ?? [],
        this.createdAt = createdAt ?? DateTime.now(),
        this.updatedAt = updatedAt ?? DateTime.now();

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      nombre: data['nombre'] ?? '',
      telefono: data['telefono'],
      photoUrl: data['photoUrl'],
      favoritos: List<String>.from(data['favoritos'] ?? []),
      reservas: List<String>.from(data['reservas'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'nombre': nombre,
      'telefono': telefono,
      'photoUrl': photoUrl,
      'favoritos': favoritos,
      'reservas': reservas,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? nombre,
    String? telefono,
    String? photoUrl,
    List<String>? favoritos,
    List<String>? reservas,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      photoUrl: photoUrl ?? this.photoUrl,
      favoritos: favoritos ?? this.favoritos,
      reservas: reservas ?? this.reservas,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}