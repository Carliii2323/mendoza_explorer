import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class FirebaseConfig {
  static Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('✅ Firebase inicializado correctamente');
    } on FirebaseException catch (e) {
      if (e.code == 'duplicate-app') {
        // Esto es normal en hot reload/hot restart
        print('✅ Firebase ya inicializado (hot reload)');
      } else {
        print('❌ Error al inicializar Firebase: $e');
        rethrow;
      }
    } catch (e) {
      print('❌ Error inesperado: $e');
      rethrow;
    }
  }
}