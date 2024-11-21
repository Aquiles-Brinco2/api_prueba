import 'package:flutter/material.dart';
import 'api_service.dart';

class CursosScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  CursosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
        backgroundColor:
            Colors.blueAccent, // Cambié el color para hacerlo más visual
      ),
      body: FutureBuilder(
        future: apiService.fetchCursos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final cursos = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color:
                        Colors.blueGrey[900], // Fondo oscuro para las tarjetas
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        cursos[index]['titulo'] ?? 'Curso sin nombre',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        cursos[index]['descripcion'] ?? 'Sin descripción',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // Acción cuando se toca la tarjeta (por ejemplo, abrir los detalles del curso)
                        print('Curso seleccionado: ${cursos[index]['titulo']}');
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
