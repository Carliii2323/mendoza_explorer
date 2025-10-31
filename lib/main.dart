import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/app_export.dart';
import 'config/firebase_config.dart';
import 'providers/auth_provider.dart';
import 'providers/atraccion_provider.dart';
import 'providers/categoria_provider.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await FirebaseConfig.initializeFirebase();

  // 🚨 CRITICAL: Device orientation lock - DO NOT REMOVE
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AtraccionProvider()..loadAtracciones()),
        ChangeNotifierProvider(create: (_) => CategoriaProvider()..loadCategorias()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'MendozaExplorer',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.welcomeScreen,
            routes: AppRoutes.routes,
            // 🚨 CRITICAL: NEVER REMOVE OR MODIFY
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(1.0)),
                child: child!,
              );
            },
            // 🚨 END CRITICAL SECTION
          );
        },
      ),
    );
  }
}
