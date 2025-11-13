import 'package:flutter/material.dart';

class ReservaScreen extends StatefulWidget {
  final String nombreBodega;
  final String ubicacion;

  const ReservaScreen({
    Key? key,
    required this.nombreBodega,
    required this.ubicacion,
  }) : super(key: key);

  @override
  State<ReservaScreen> createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedHorario;
  int _cantidadPersonas = 2;

  final List<String> _horariosDisponibles = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  void _previousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isBeforeToday(DateTime day) {
    final today = DateTime.now();
    final compareDate = DateTime(day.year, day.month, day.day);
    final todayDate = DateTime(today.year, today.month, today.day);
    return compareDate.isBefore(todayDate);
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDay.day;

    List<DateTime> days = [];

    // Agregar días vacíos al inicio
    final firstWeekday = firstDay.weekday % 7; // 0 = domingo
    for (int i = 0; i < firstWeekday; i++) {
      days.add(DateTime(1900, 1, 1)); // Fecha placeholder
    }

    // Agregar todos los días del mes
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i));
    }

    return days;
  }

  String _getMonthName(int month) {
    const months = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    return months[month - 1];
  }

  Widget _buildCalendar() {
    final days = _getDaysInMonth(_focusedDay);
    final monthName = '${_getMonthName(_focusedDay.month)} de ${_focusedDay.year}';

    return Column(
      children: [
        // Header del mes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousMonth,
              ),
              Text(
                monthName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
              ),
            ],
          ),
        ),

        // Días de la semana
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['dom', 'lun', 'mar', 'mié', 'jue', 'vie', 'sáb']
                .map((day) => SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ))
                .toList(),
          ),
        ),

        const SizedBox(height: 8),

        // Grid de días
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];

              // Día placeholder (vacío)
              if (day.year == 1900) {
                return const SizedBox.shrink();
              }

              final isSelected = _selectedDay != null && _isSameDay(day, _selectedDay!);
              final isToday = _isSameDay(day, DateTime.now());
              final isPast = _isBeforeToday(day);

              return GestureDetector(
                onTap: isPast ? null : () {
                  setState(() {
                    _selectedDay = day;
                    _selectedHorario = null; // Reset horario al cambiar día
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.black
                        : isToday
                        ? Colors.black
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 14,
                        color: isPast
                            ? Colors.grey[300]
                            : (isSelected || isToday)
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: (isSelected || isToday)
                            ? FontWeight.w600
                            : FontWeight.normal,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHorarioSelector() {
    if (_selectedDay == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Selecciona un horario',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Color(0xFF2C2C2C),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _horariosDisponibles.map((horario) {
              final isSelected = _selectedHorario == horario;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedHorario = horario;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF4A3428)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4A3428)
                          : Colors.grey[300]!,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    horario,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      color: isSelected ? Colors.white : const Color(0xFF2C2C2C),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonasSelector() {
    if (_selectedDay == null || _selectedHorario == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cantidad de personas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Personas',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Color(0xFF2C2C2C),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _cantidadPersonas > 1
                          ? () {
                        setState(() {
                          _cantidadPersonas--;
                        });
                      }
                          : null,
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: _cantidadPersonas > 1
                              ? const Color(0xFF4A3428).withOpacity(0.1)
                              : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: _cantidadPersonas > 1
                              ? const Color(0xFF4A3428)
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        '$_cantidadPersonas',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _cantidadPersonas < 10
                          ? () {
                        setState(() {
                          _cantidadPersonas++;
                        });
                      }
                          : null,
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: _cantidadPersonas < 10
                              ? const Color(0xFF4A3428).withOpacity(0.1)
                              : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: _cantidadPersonas < 10
                              ? const Color(0xFF4A3428)
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = _selectedDay != null &&
        _selectedHorario != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F1E8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C2C2C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.nombreBodega,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(0xFF2C2C2C),
              ),
            ),
            Text(
              widget.ubicacion,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Selecciona una fecha',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xFF2C2C2C),
                ),
              ),
            ),

            // Calendario
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildCalendar(),
            ),

            const SizedBox(height: 24),

            // Selector de horario
            _buildHorarioSelector(),

            const SizedBox(height: 24),

            // Selector de personas
            _buildPersonasSelector(),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // Botón de guardar
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
            onPressed: canContinue
                ? () {
              final fechaFormateada = '${_selectedDay!.day.toString().padLeft(2, '0')}/${_selectedDay!.month.toString().padLeft(2, '0')}/${_selectedDay!.year}';
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text(
                    '¡Reserva confirmada!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nombreBodega,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fecha: $fechaFormateada',
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      Text(
                        'Horario: $_selectedHorario',
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      Text(
                        'Personas: $_cantidadPersonas',
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Aceptar',
                        style: TextStyle(
                          color: Color(0xFF4A3428),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canContinue
                  ? const Color(0xFF4A3428)
                  : Colors.grey[300],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: canContinue ? 2 : 0,
            ),
            child: const Text(
              'Guardar',
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
}