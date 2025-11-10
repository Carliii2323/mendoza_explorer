import 'package:flutter/material.dart';
import 'package:mendoza_explorer/presentation/screens/user_screen/user_screen.dart';
import '../bodegas_screen/bodegas_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner principal - EDGE TO EDGE
            Container(
              height: 240 + MediaQuery.of(context).padding.top,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    // Imagen de fondo
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/banner_mendoza.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF1A4D5C),
                                  Color(0xFF3A7A8A),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Overlay gradiente sutil
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Texto "MENDOZA EXPLORER" sobre la imagen
                    const Positioned(
                      left: 75,
                      bottom: 110,
                      child: Text(
                        'MENDOZA EXPLORER',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Título "Destacadas del mes"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Destacadas del mes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xFF2C2C2C),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Subtítulo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Descubrí las mejores bodegas de Mendoza',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Texto cursiva
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Viví la experiencia del vino mendocino',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF4A3428),
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Grid de cards destacadas - Primera fila
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  // Card Bodega Catena Zapata
                  Expanded(
                    child: _buildWineCard(
                      context,
                      imagePath: 'assets/images/tours_vino.png',
                      title: 'Bodega Catena\nZapata',
                      price: 'Desde \$150',
                      badge: 'Tours Premium',
                      badgeColor: const Color(0xFF4A3428),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Card Degustaciones
                  Expanded(
                    child: _buildWineCard(
                      context,
                      imagePath: 'assets/images/tours_vino.png',
                      title: 'Degustaciones\ncon vista',
                      price: 'Desde \$90',
                      badge: 'Popular',
                      badgeColor: const Color(0xFF4A3428),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Grid de cards destacadas - Segunda fila
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  // Card Maridajes gourmet
                  Expanded(
                    child: _buildWineCard(
                      context,
                      imagePath: 'assets/images/tours_vino.png',
                      title: 'Maridajes\ngourmet',
                      price: 'Desde \$120',
                      badge: 'Descuento',
                      badgeColor: const Color(0xFF4A3428),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Card Cata con enólogo
                  Expanded(
                    child: _buildWineCard(
                      context,
                      imagePath: 'assets/images/sitios_culturales.png',
                      title: 'Cata con\nenólogo',
                      price: 'Desde \$180',
                      badge: 'Nuevo',
                      badgeColor: const Color(0xFF4A3428),
                      isDark: true,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Card horizontal grande - Aventura en viñedo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildHorizontalCard(
                context,
                imagePath: 'assets/images/banner_mendoza.png',
                title: 'Aventura en viñedo',
                badge: 'Aventura en viñedo',
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
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
                _buildNavItem(Icons.home, true, context, null),
                _buildNavItem(FontAwesomeIcons.ticket, false, context, null),
                _buildNavItem(Icons.wine_bar, false, context, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BodegasScreen())
                  );
                }),
                _buildNavItem(Icons.favorite_border, false, context, null),
                _buildNavItem(Icons.person_outline, false, context, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const UserScreen()));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWineCard(
      BuildContext context, {
        required String imagePath,
        required String title,
        required String price,
        required String badge,
        required Color badgeColor,
        bool isDark = false,
      }) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Abriendo: $title'),
            backgroundColor: const Color(0xFF4A3428),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Imagen de fondo
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isDark
                              ? [const Color(0xFF2C2416), const Color(0xFF4A3428)]
                              : [const Color(0xFFC4A574), const Color(0xFFD4B896)],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Overlay oscuro
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(isDark ? 0.8 : 0.7),
                      ],
                    ),
                  ),
                ),
              ),

              // Badge superior
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Contenido inferior
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(
      BuildContext context, {
        required String imagePath,
        required String title,
        required String badge,
      }) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Abriendo: Aventura en viñedo'),
            backgroundColor: Color(0xFF4A3428),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Imagen de fondo
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFC4A574),
                            const Color(0xFFD4B896),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Overlay oscuro
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),

              // Badge superior izquierdo
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A3428),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon,
      bool isActive,
      BuildContext context,
      VoidCallback? onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4A3428) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : const Color(0xFF4A3428),
          size: 26,
        ),
      ),
    );
  }
}