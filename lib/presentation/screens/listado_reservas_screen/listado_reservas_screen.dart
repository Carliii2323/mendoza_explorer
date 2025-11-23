import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Importa tus pantallas con rutas correctas
import '../bodegas_screen/bodegas_screen.dart';
import '../map_screen/map_screen.dart';
import '../user_screen/user_screen.dart';
import '../home_screen/home_screen.dart';

class ListadoReservasScreen extends StatelessWidget {
  const ListadoReservasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F1E8),
        elevation: 0,
        automaticallyImplyLeading: false, // Quita la flecha de back
        title: const Text(
          'Reservas',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Sección de reservas próximas
          const Text(
            'Próximas visitas',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Tarjeta de reserva 1
          _buildReservaCard(
            context,
            imagePath: 'assets/bodega1.jpg',
            bodegaNombre: 'Bodega Catena Zapata',
            fechas: '15-17 de dic de 2024',
            usuario: 'Usuario: Carlos Mendoza',
            ubicacion: 'Luján de Cuyo',
            badge: 'Dentro de 1 mes',
          ),
          const SizedBox(height: 16),

          // Tarjeta de reserva 2
          _buildReservaCard(
            context,
            imagePath: 'assets/bodega2.jpg',
            bodegaNombre: 'Domaine Bousquet',
            fechas: '22-24 de ene de 2025',
            usuario: 'Usuario: María López',
            ubicacion: 'Mendoza, Maipú',
            badge: 'Dentro de 2 meses',
          ),
          const SizedBox(height: 24),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F1E8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(Icons.home, false, context, () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen())
                  );
                }),
                _buildNavItem(FontAwesomeIcons.ticket, true, context, null), // true porque estamos en Reservas
                _buildNavItem(Icons.wine_bar, false, context, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BodegasScreen())
                  );
                }),
                _buildNavItem(Icons.location_on, false, context, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreen())
                  );
                }),
                _buildNavItem(Icons.person_outline, false, context, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserScreen())
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, BuildContext context, VoidCallback? onTap) {
    return GestureDetector(
      onTap: isActive ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4A3428) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : const Color(0xFF4A3428),
          size: 27,
        ),
      ),
    );
  }

  Widget _buildReservaCard(
      BuildContext context, {
        required String imagePath,
        required String bodegaNombre,
        required String fechas,
        required String usuario,
        required String ubicacion,
        required String badge,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen con badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.wine_bar, size: 60),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Información
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bodegaNombre,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$fechas · $usuario',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}