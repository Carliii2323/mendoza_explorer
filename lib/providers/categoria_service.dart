import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/categoria_model.dart';

class CategoriaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'categorias';

  Stream<List<CategoriaModel>> getCategorias() {
    return _firestore
        .collection(_collection)
        .where('activa', isEqualTo: true)
        .orderBy('orden')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoriaModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<CategoriaModel?> getCategoriaById(String id) async {
    try {
      DocumentSnapshot doc =
      await _firestore.collection(_collection).doc(id).get();
      if (!doc.exists) return null;
      return CategoriaModel.fromFirestore(doc);
    } catch (e) {
      throw 'Error al obtener categoría: ${e.toString()}';
    }
  }
}