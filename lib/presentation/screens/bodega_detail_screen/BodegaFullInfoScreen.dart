import 'package:flutter/material.dart';

class BodegaFullInfoScreen extends StatelessWidget {
  final String nombre;
  final String ubicacion;
  final String imagen;

  const BodegaFullInfoScreen({
    Key? key,
    required this.nombre,
    required this.ubicacion,
    required this.imagen,
  }) : super(key: key);

  String _getDescripcionCompleta() {
    final descripciones = {
      'Domaine Bousquet': '''Una bodega boutique ubicada en el Valle de Uco de Mendoza, Argentina. Reconocida mundialmente por sus vinos orgánicos y biodinámicos. Con más de 4 generaciones dedicadas a la viticultura, Domaine Bousquet combina tradición francesa con la pasión argentina.

Historia
Fundada por la familia Bousquet, esta bodega ha mantenido un compromiso inquebrantable con la producción orgánica desde sus inicios. La visión de Jean Bousquet de crear vinos excepcionales respetando el medio ambiente ha transformado la región.

El restaurante Gaia ofrece una experiencia gastronómica única con maridajes excepcionales, donde cada plato está diseñado para realzar las características únicas de nuestros vinos premium.''',
      'Bodega Bianchi': '''Con más de 120 años de historia, Bodega Bianchi es una de las bodegas más prestigiosas de Argentina. Ubicada en San Rafael, Mendoza, combina tradición italiana con técnicas modernas de vinificación.

Sus vinos han ganado reconocimientos internacionales y representan la excelencia de la vitivinicultura argentina. La familia Bianchi ha pasado su pasión por el vino de generación en generación, manteniendo los más altos estándares de calidad.

La bodega cuenta con instalaciones de última generación y ofrece tours educativos que muestran el proceso completo desde la vid hasta la botella.''',
      'Bodega Sabores de Maipu': '''Una experiencia boutique en el corazón de Maipú. Esta bodega familiar se especializa en vinos de alta gama con procesos artesanales.

Sus tours incluyen degustaciones personalizadas y recorridos por viñedos centenarios donde se pueden apreciar las técnicas tradicionales que han sido perfeccionadas durante décadas.

El compromiso con la calidad y la atención personalizada hace de cada visita una experiencia memorable e íntima.''',
      'Bodega Catena Zapata': '''Ícono arquitectónico del Valle de Uco, inspirado en las pirámides mayas. Pioneros en el desarrollo de Malbec de altura, producen vinos de clase mundial.

La familia Catena ha revolucionado la industria vitivinícola argentina, llevando el Malbec argentino a la cima del reconocimiento internacional. Su investigación sobre terroir y microclimas ha establecido nuevos estándares en la región.

La bodega combina arquitectura impresionante con innovación enológica, creando vinos que expresan la esencia única de los Andes.''',
      'Bodega Trapiche': '''Una de las bodegas más antiguas y prestigiosas de Argentina, fundada en 1883. Trapiche es sinónimo de innovación y calidad, con viñedos en las mejores regiones de Mendoza.

Con más de 140 años de experiencia, ha sido pionera en técnicas de vinificación y ha establecido estándares de excelencia reconocidos mundialmente. Su portafolio incluye desde vinos accesibles hasta etiquetas ultra premium.''',
      'Bodega Casa de Uco': '''Ubicada en el Valle de Uco, ofrece vistas panorámicas de los Andes. Esta bodega boutique se especializa en vinos premium de terroir único, con una arquitectura moderna que se integra al paisaje.

Cada vino refleja las características únicas del suelo y clima de altura, creando expresiones complejas y elegantes. La experiencia de visita incluye degustaciones exclusivas con vistas espectaculares de la cordillera.'''
    };

    return descripciones[nombre] ??
        '''Una bodega excepcional ubicada en Mendoza, Argentina. Combina tradición y modernidad en la producción de vinos de alta calidad.

Ofrece experiencias únicas de degustación y tours por sus instalaciones, donde los visitantes pueden aprender sobre el proceso de vinificación y la historia de la región.''';
  }

  Map<String, String> _getInfoAdicional() {
    return {
      'Acerca del espacio': '''Ubicado en Valle de Uco, Tupungato, a 90 km de Mendoza, a los pies de la Cordillera de los Andes.

• Terruño único con Domaine Bousquet, bodega orgánica líder en vinos premium y de exportación.
• Experiencia única en contacto con la naturaleza.
• Servicio de conserjería personalizado, traslados, seguridad privada y estacionamiento gratuito.''',
      'Alojamiento': '''Gaia Lodge dispone de 5 habitaciones dobles y 2 cuádruples, modernas y sofisticadas. Todas cuentan con wifi, aire acondicionado, minibar, cava de vinos, cafetera Nespresso, secador de pelo y escritorio. Sus espacios ofrecen vistas privilegiadas a los viñedos y a la Cordillera de los Andes. Además, cada habitación tiene baño privado con artículos de tocador de cortesía y se sirve un desayuno casero preparado con productos frescos de huerta orgánica.''',
      'Restaurante': '''Gaia Restaurante es un referente en la gastronomía del Valle de Uco. Dirigido por el chef ejecutivo Adrián Boggio, propone un menú de autor elaborado con ingredientes seleccionados de la huerta orgánica. Cada plato se sirve con la sugerencia de los vinos locales y armonizar con los vinos de Domaine Bousquet.''',
    };
  }

  @override
  Widget build(BuildContext context) {
    final descripcionCompleta = _getDescripcionCompleta();
    final infoAdicional = _getInfoAdicional();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A3428),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          nombre,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ubicación
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 20,
                        color: Color(0xFF4A3428),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          ubicacion,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Descripción completa
                  const Text(
                    'Sobre Nosotros',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    descripcionCompleta,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.8,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Secciones adicionales
                  ...infoAdicional.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF2C2C2C),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                entry.value,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.8,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}