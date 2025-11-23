import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  // Coordenadas de Mendoza (centro de la provincia)
  static const LatLng _mendozaCenter = LatLng(-32.8895, -68.8458);

  // Marcadores de las bodegas
  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('domaine_bousquet'),
      position: const LatLng(-33.3890, -69.1420),
      infoWindow: const InfoWindow(
        title: 'Domaine Bousquet',
        snippet: 'Valle de Uco',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: const MarkerId('bodega_bianchi'),
      position: const LatLng(-34.6177, -68.3350),
      infoWindow: const InfoWindow(
        title: 'Bodega Bianchi',
        snippet: 'San Rafael',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: const MarkerId('sabores_maipu'),
      position: const LatLng(-32.9833, -68.7833),
      infoWindow: const InfoWindow(
        title: 'Bodega Sabores de Maipú',
        snippet: 'Maipú',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: const MarkerId('catena_zapata'),
      position: const LatLng(-33.4020, -69.1280),
      infoWindow: const InfoWindow(
        title: 'Bodega Catena Zapata',
        snippet: 'Valle de Uco',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: const MarkerId('trapiche'),
      position: const LatLng(-33.0167, -68.8667),
      infoWindow: const InfoWindow(
        title: 'Bodega Trapiche',
        snippet: 'Maipú',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: const MarkerId('casa_de_uco'),
      position: const LatLng(-33.6500, -69.2000),
      infoWindow: const InfoWindow(
        title: 'Bodega Casa de Uco',
        snippet: 'Valle de Uco',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    print('🎉 ¡MAPA CREADO EXITOSAMENTE!');
  }

  void _centerOnMendoza() {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: _mendozaCenter,
          zoom: 9.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      body: Stack(
        children: [
          // Mapa completo
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _mendozaCenter,
              zoom: 9.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: true,
          ),

          // Header con título y botón de cerrar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bodegas de Mendoza',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF4A3428),
                        size: 20,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),

          // Botones flotantes
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                // Botón para centrar en Mendoza
                FloatingActionButton(
                  heroTag: 'center',
                  onPressed: _centerOnMendoza,
                  backgroundColor: Colors.white,
                  elevation: 4,
                  child: const Icon(
                    Icons.my_location,
                    color: Color(0xFF4A3428),
                  ),
                ),
                const SizedBox(height: 12),
                // Botón de zoom in
                FloatingActionButton.small(
                  heroTag: 'zoom_in',
                  onPressed: () {
                    _mapController?.animateCamera(CameraUpdate.zoomIn());
                  },
                  backgroundColor: Colors.white,
                  elevation: 4,
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF4A3428),
                  ),
                ),
                const SizedBox(height: 8),
                // Botón de zoom out
                FloatingActionButton.small(
                  heroTag: 'zoom_out',
                  onPressed: () {
                    _mapController?.animateCamera(CameraUpdate.zoomOut());
                  },
                  backgroundColor: Colors.white,
                  elevation: 4,
                  child: const Icon(
                    Icons.remove,
                    color: Color(0xFF4A3428),
                  ),
                ),
              ],
            ),
          ),

          // Card inferior con información
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Indicador de arrastre
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A3428).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.wine_bar,
                            color: Color(0xFF4A3428),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_markers.length} Bodegas',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF2C2C2C),
                                ),
                              ),
                              Text(
                                'Explora las mejores bodegas de Mendoza',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}