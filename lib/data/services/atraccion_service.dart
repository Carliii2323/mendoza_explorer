import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/atraccion_model.dart';
import 'dart:math' show atan2, cos, sin, sqrt;

class AtraccionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'atracciones';

  Stream<List<AtraccionModel>> getAtracciones() {
    return _firestore
        .collection(_collection)
        .where('disponibilidad', isEqualTo: true)
        .orderBy('topRanked', descending: true)
        .orderBy('nombre')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AtraccionModel.fromFirestore(doc))
          .toList();
    });
  }

  Stream<List<AtraccionModel>> getAtraccionesByTipo(String tipo) {
    return _firestore
        .collection(_collection)
        .where('tipo', isEqualTo: tipo)
        .where('disponibilidad', isEqualTo: true)
        .orderBy('topRanked', descending: true)
        .orderBy('nombre')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AtraccionModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<AtraccionModel?> getAtraccionById(String id) async {
    try {
      DocumentSnapshot doc =
      await _firestore.collection(_collection).doc(id).get();
      if (!doc.exists) return null;
      return AtraccionModel.fromFirestore(doc);
    } catch (e) {
      throw 'Error al obtener atracción: ${e.toString()}';
    }
  }

  Stream<List<AtraccionModel>> getAtraccionesDestacadas() {
    return _firestore
        .collection(_collection)
        .where('topRanked', isEqualTo: true)
        .where('disponibilidad', isEqualTo: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AtraccionModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<List<AtraccionModel>> searchAtracciones(String query) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(_collection)
          .where('disponibilidad', isEqualTo: true)
          .get();

      List<AtraccionModel> atracciones = snapshot.docs
          .map((doc) => AtraccionModel.fromFirestore(doc))
          .toList();

      String queryLower = query.toLowerCase();
      return atracciones
          .where((a) => a.nombre.toLowerCase().contains(queryLower))
          .toList();
    } catch (e) {
      throw 'Error al buscar atracciones: ${e.toString()}';
    }
  }

  Future<String> createAtraccion(AtraccionModel atraccion) async {
    try {
      DocumentReference doc = await _firestore
          .collection(_collection)
          .add(atraccion.toFirestore());
      return doc.id;
    } catch (e) {
      throw 'Error al crear atracción: ${e.toString()}';
    }
  }

  Future<void> updateAtraccion(
      String id, Map<String, dynamic> updates) async {
    try {
      updates['updatedAt'] = FieldValue.serverTimestamp();
      await _firestore.collection(_collection).doc(id).update(updates);
    } catch (e) {
      throw 'Error al actualizar atracción: ${e.toString()}';
    }
  }

  Future<void> deleteAtraccion(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw 'Error al eliminar atracción: ${e.toString()}';
    }
  }

  Future<List<AtraccionModel>> getAtraccionesCercanas(
      double userLat,
      double userLng,
      double radiusKm,
      ) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(_collection)
          .where('disponibilidad', isEqualTo: true)
          .get();

      List<AtraccionModel> atracciones = snapshot.docs
          .map((doc) => AtraccionModel.fromFirestore(doc))
          .toList();

      return atracciones.where((atraccion) {
        double distance = _calculateDistance(
          userLat,
          userLng,
          atraccion.ubicacion.latitud,
          atraccion.ubicacion.longitud,
        );
        return distance <= radiusKm;
      }).toList();
    } catch (e) {
      throw 'Error al obtener atracciones cercanas: ${e.toString()}';
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * (3.141592653589793 / 180);
  }
}