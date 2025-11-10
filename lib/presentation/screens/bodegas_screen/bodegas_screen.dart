import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mendoza_explorer/presentation/screens/home_screen/home_screen.dart';
import 'package:mendoza_explorer/presentation/screens/user_screen/user_screen.dart';

class BodegasScreen extends StatefulWidget {
  const BodegasScreen({Key? key}) : super(key: key);

  @override
  State<BodegasScreen> createState() => _BodegasScreenState();
}

class _BodegasScreenState extends State<BodegasScreen> {
  int _selectedIndex = 2; // Index para el navbar (2 = wine_glass)
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Bodega> bodegas = [
    Bodega(
      nombre: 'Domaine Bousquet',
      imagen: 'assets/images/domaine_bousquet.png',
      ubicacion: 'Mendoza, Argentina',
      isFavorito: false,
    ),
    Bodega(
      nombre: 'Bodega Bianchi',
      imagen: 'assets/images/bodega_bianchi.png',
      ubicacion: 'Mendoza, Argentina',
      isFavorito: true,
    ),
    Bodega(
      nombre: 'Bodega Sabores de Maipu',
      imagen: 'assets/images/sabores_maipu.png',
      ubicacion: 'Maipú, Mendoza',
      isFavorito: false,
    ),
    Bodega(
      nombre: 'Bodega Catena Zapata',
      imagen: 'assets/images/catena_zapata.png',
      ubicacion: 'Luján de Cuyo',
      isFavorito: false,
    ),
    Bodega(
      nombre: 'Bodega Trapiche',
      imagen: 'assets/images/trapiche.png',
      ubicacion: 'Maipú, Mendoza',
      isFavorito: false,
    ),
    Bodega(
      nombre: 'Bodega Casa de Uco',
      imagen: 'assets/images/casa_uco.png',
      ubicacion: 'Valle de Uco',
      isFavorito: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filtrar bodegas según búsqueda
  List<Bodega> get bodegasFiltradas {
    if (_searchQuery.isEmpty) {
      return bodegas;
    }
    return bodegas.where((bodega) {
      final nombreLower = bodega.nombre.toLowerCase();
      final ubicacionLower = bodega.ubicacion.toLowerCase();
      final queryLower = _searchQuery.toLowerCase();
      return nombreLower.contains(queryLower) ||
          ubicacionLower.contains(queryLower);
    }).toList();
  }

  void _onNavItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    // Navegación según el índice
    switch (index) {
      case 0: // Home
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1: // Search
      // TODO: Navegar a pantalla de búsqueda
        break;
      case 2: // Grid (Bodegas)
      // Ya estamos aquí
        break;
      case 3: // Favoritos
      // TODO: Navegar a pantalla de favoritos
        break;
      case 4: // Perfil
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => const UserScreen()));
        break;
    }
  }

  void _toggleFavorito(int index) {
    setState(() {
      bodegas[index].isFavorito = !bodegas[index].isFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bodegasParaMostrar = bodegasFiltradas;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Título "Bodegas"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Bodegas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xFF2C2C2C),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Barra de búsqueda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Buscar bodegas...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 16,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF4A3428),
                      size: 24,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Color(0xFF999999),
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Contador de resultados
            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  bodegasParaMostrar.isEmpty
                      ? 'No se encontraron resultados'
                      : '${bodegasParaMostrar.length} bodega${bodegasParaMostrar.length != 1 ? 's' : ''} encontrada${bodegasParaMostrar.length != 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            if (_searchQuery.isNotEmpty) const SizedBox(height: 10),

            // Grid de bodegas
            Expanded(
              child: bodegasParaMostrar.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No se encontraron bodegas',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Intenta con otro término de búsqueda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: bodegasParaMostrar.length,
                  itemBuilder: (context, index) {
                    final bodegaIndex = bodegas.indexOf(bodegasParaMostrar[index]);
                    return _buildBodegaCard(bodegasParaMostrar[index], bodegaIndex);
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
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
                _buildNavItem(Icons.home, 0),
                _buildNavItem(FontAwesomeIcons.ticket, 1),
                _buildNavItem(Icons.wine_bar, 2),
                _buildNavItem(Icons.favorite_border, 3),
                _buildNavItem(Icons.person_outline, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodegaCard(Bodega bodega, int index) {
    return GestureDetector(
      onTap: () {
        // TODO: Navegar a detalle de bodega
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Abriendo: ${bodega.nombre}'),
            backgroundColor: const Color(0xFF4A3428),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Imagen de fondo
              Positioned.fill(
                child: Image.asset(
                  bodega.imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholderImage(index);
                  },
                ),
              ),

              // Overlay oscuro en la parte inferior
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        bodega.nombre,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              bodega.ubicacion,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Botón de favorito
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => _toggleFavorito(index),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      bodega.isFavorito ? Icons.favorite : Icons.favorite_border,
                      color: bodega.isFavorito ? Colors.red : const Color(0xFF4A3428),
                      size: 20,
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

  Widget _buildPlaceholderImage(int index) {
    final colors = [
      const Color(0xFF8B7355),
      const Color(0xFF6B5D52),
      const Color(0xFF9B8B7E),
      const Color(0xFF7D6E5D),
      const Color(0xFFA89582),
      const Color(0xFF8A7968),
    ];

    return Container(
      color: colors[index % colors.length],
      child: const Center(
        child: Icon(
          Icons.wine_bar,
          size: 50,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
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

class Bodega {
  final String nombre;
  final String imagen;
  final String ubicacion;
  bool isFavorito;

  Bodega({
    required this.nombre,
    required this.imagen,
    required this.ubicacion,
    required this.isFavorito,
  });
}