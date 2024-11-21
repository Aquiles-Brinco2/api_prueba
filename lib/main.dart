import 'package:api_prueba/misCursosScreen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';  // Importa la pantalla de Login

import 'cursos_screen.dart';
import 'soportes_screen.dart';
import 'comentarios_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta API App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      // Definir la pantalla de login como la pantalla principal.
      home: LoginScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final int id;
  final String nombre;
  final String email;
  final String tipo;

  // Constructor para recibir los datos del usuario
  const HomeScreen({
    required this.id,
    required this.nombre,
    required this.email,
    required this.tipo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título de bienvenida
              const Text(
                'Bienvenido a la App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Mostrar información del usuario
              Text(
                'ID: $id',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Nombre: $nombre',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Email: $email',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Tipo: $tipo',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Botones de navegación
              _buildMenuButton(context, 'Explorar Cursos', CursosScreen()),
              _buildMenuButton(context, 'Soporte', SoportesScreen()),
              _buildMenuButton(context, 'Comentarios', ComentariosScreen()),
              _buildMenuButton(context, 'Mis Cursos', MisCursosScreen(userId: id,)),

            ],
          ),
        ),
      ),
    );
  }

  // Widget reusable para botones del menú
  Widget _buildMenuButton(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent, // Fondo del botón
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
