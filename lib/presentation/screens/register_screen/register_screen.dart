import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _celularController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _celularController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final nombreCompleto = '${_nombreController.text.trim()} ${_apellidoController.text.trim()}';

    final success = await authProvider.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      nombre: nombreCompleto,
      telefono: _celularController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      // Cerrar sesión automáticamente después del registro
      await authProvider.signOut();

      if (!mounted) return;

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Registro exitoso! Ahora inicia sesión con tus credenciales'),
          backgroundColor: Color(0xFF4A3428),
          duration: Duration(seconds: 3),
        ),
      );

      // Esperar un momento para que se vea el mensaje
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      // Navegar de vuelta al login
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Error al registrarse'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A3428)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Logo/Ícono
                  Container(
                    child: ClipRRect(
                      // Usamos el mismo valor que el del Container para que coincidan perfectamente.
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/images/foto_login.png',
                        width: 200,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Título
                  const Text(
                    'MendozaExplorer',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      color: Color(0xFF2C2C2C),
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Subtítulo
                  const Text(
                    'Mendoza te espera!\nIngresemos tus datos aquí abajo.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Campos del formulario
                  _buildTextField(
                    controller: _emailController,
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa tu email';
                      if (!value.contains('@')) return 'Email inválido';
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  _buildTextField(
                    controller: _passwordController,
                    hint: 'Contraseña',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFF999999),
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa tu contraseña';
                      if (value.length < 6) return 'Mínimo 6 caracteres';
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  _buildTextField(
                    controller: _nombreController,
                    hint: 'Nombre',
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa tu nombre';
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  _buildTextField(
                    controller: _apellidoController,
                    hint: 'Apellido',
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa tu apellido';
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  _buildTextField(
                    controller: _celularController,
                    hint: 'Celular',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingresa tu celular';
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),

                  // Botón Registrar
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return GestureDetector(
                        onTap: authProvider.isLoading ? null : _handleRegister,
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A3428),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: authProvider.isLoading
                                ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                                : const Text(
                              'Registrarse',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}