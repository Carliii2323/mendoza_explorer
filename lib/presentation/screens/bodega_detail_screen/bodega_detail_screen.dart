import 'package:flutter/material.dart';
import '../reserva_screen/ReservaScreen.dart';
import 'BodegaFullInfoScreen.dart';

class BodegaDetailScreen extends StatefulWidget {
  final String nombre;
  final String ubicacion;
  final String imagen;
  final bool isFavorito;

  const BodegaDetailScreen({
    Key? key,
    required this.nombre,
    required this.ubicacion,
    required this.imagen,
    this.isFavorito = false,
  }) : super(key: key);

  @override
  State<BodegaDetailScreen> createState() => _BodegaDetailScreenState();
}

class _BodegaDetailScreenState extends State<BodegaDetailScreen> {
  late bool _isFavorito;

  @override
  void initState() {
    super.initState();
    _isFavorito = widget.isFavorito;
  }

  void _toggleFavorito() {
    setState(() {
      _isFavorito = !_isFavorito;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorito
              ? '${widget.nombre} agregado a favoritos'
              : '${widget.nombre} eliminado de favoritos',
        ),
        backgroundColor: const Color(0xFF4A3428),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Map<String, List<String>> _getDescripcionesPorPuntos() {
    return {
      'Domaine Bousquet': [
        'Bodega boutique ubicada en el Valle de Uco de Mendoza, Argentina',
        'Reconocida mundialmente por sus vinos orgánicos y biodinámicos',
        'Más de 4 generaciones dedicadas a la viticultura',
        'Combina tradición francesa con la pasión argentina',
        'El restaurante Gaia ofrece una experiencia gastronómica única con maridajes excepcionales'
      ],
      'Bodega Bianchi': [
        'Más de 120 años de historia',
        'Una de las bodegas más prestigiosas de Argentina',
        'Ubicada en San Rafael, Mendoza',
        'Combina tradición italiana con técnicas modernas de vinificación',
        'Vinos con reconocimientos internacionales'
      ],
      'Bodega Sabores de Maipu': [
        'Experiencia boutique en el corazón de Maipú',
        'Bodega familiar especializada en vinos de alta gama',
        'Procesos artesanales de vinificación',
        'Tours con degustaciones personalizadas',
        'Recorridos por viñedos centenarios'
      ],
      'Bodega Catena Zapata': [
        'Ícono arquitectónico del Valle de Uco inspirado en las pirámides mayas',
        'Pioneros en el desarrollo de Malbec de altura',
        'Producen vinos de clase mundial',
        'La familia Catena ha revolucionado la industria vitivinícola argentina'
      ],
      'Bodega Trapiche': [
        'Una de las bodegas más antiguas de Argentina, fundada en 1883',
        'Sinónimo de innovación y calidad',
        'Viñedos en las mejores regiones de Mendoza',
        'Reconocimiento internacional'
      ],
      'Bodega Casa de Uco': [
        'Ubicada en el Valle de Uco con vistas panorámicas de los Andes',
        'Bodega boutique especializada en vinos premium',
        'Terroir único de la región',
        'Arquitectura moderna integrada al paisaje'
      ],
    };
  }

  List<String> _getDescripcionBodega() {
    final descripciones = _getDescripcionesPorPuntos();
    return descripciones[widget.nombre] ?? [
      'Bodega excepcional ubicada en Mendoza, Argentina',
      'Combina tradición y modernidad en la producción de vinos',
      'Vinos de alta calidad',
      'Experiencias únicas de degustación y tours'
    ];
  }

  List<String> _getCaracteristicas() {
    return [
      'Top 10 de las bodegas mejor ranqueadas',
      'Tours guiados en español e inglés',
      'Ubicación accesible',
      'Estacionamiento disponible',
      'Restaurante gourmet',
      'Tienda de vinos',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final caracteristicas = _getCaracteristicas();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar con imagen fija
          SliverAppBar(
            expandedHeight: 250,
            collapsedHeight: 120,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF4A3428),
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.share,
                    color: Color(0xFF4A3428),
                    size: 20,
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Compartiendo bodega...'),
                      backgroundColor: Color(0xFF4A3428),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isFavorito ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorito ? Colors.red : const Color(0xFF4A3428),
                    size: 20,
                  ),
                ),
                onPressed: _toggleFavorito,
              ),
            ],
            flexibleSpace: ClipRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.imagen,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF8B7355),
                        child: const Center(
                          child: Icon(
                            Icons.wine_bar,
                            size: 80,
                            color: Colors.white70,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenido scrolleable
          SliverToBoxAdapter(

            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F1E8),
                /*borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),*/
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y ubicación
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nombre,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xFF2C2C2C),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: Color(0xFF4A3428),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                widget.ubicacion,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF666666),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A3428).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '4 generaciones • vinos premium • restaurante',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF4A3428),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Separador
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Características
                  ...caracteristicas.take(3).map((caracteristica) {
                    IconData icono;
                    if (caracteristica.contains('Top 10')) {
                      icono = Icons.star;
                    } else if (caracteristica.contains('Tours')) {
                      icono = Icons.tour;
                    } else {
                      icono = Icons.location_on;
                    }
                    return _buildFeatureItem(icono, caracteristica);
                  }),

                  const SizedBox(height: 4),

                  // Separador
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),

                  // Sobre la bodega
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sobre Nosotros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xFF2C2C2C),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ..._getDescripcionBodega().map((punto) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4A3428),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  punto,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    height: 1.6,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),

                  // Botón Mostrar más
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BodegaFullInfoScreen(
                              nombre: widget.nombre,
                              ubicacion: widget.ubicacion,
                              imagen: widget.imagen,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Mostrar más',
                        style: TextStyle(
                          color: Color(0xFF4A3428),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Mapa
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dónde vas a estar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xFF2C2C2C),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Container(
                                  color: const Color(0xFFE8DCC8),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.map,
                                          size: 60,
                                          color: const Color(0xFF4A3428).withOpacity(0.5),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          widget.ubicacion,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  right: 12,
                                  child: FloatingActionButton.small(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Abriendo direcciones...'),
                                          backgroundColor: Color(0xFF4A3428),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    backgroundColor: Colors.white,
                                    elevation: 4,
                                    child: const Icon(
                                      Icons.directions,
                                      color: Color(0xFF4A3428),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],

      ),

      // Botón flotante de reserva
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F1E8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservaScreen(
                    nombreBodega: widget.nombre,
                    ubicacion: widget.ubicacion,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A3428),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Reservar experiencia',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4A3428).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFF4A3428),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2C2C2C),
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}