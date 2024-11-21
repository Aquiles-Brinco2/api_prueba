import 'package:flutter/material.dart';
import 'api_service.dart';

class ComentariosScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  ComentariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comentarios')),
      body: FutureBuilder(
        future: apiService.fetchComentarios(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final comentarios = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: comentarios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comentarios[index]['nombre'] ?? 'Anónimo'),
                  subtitle: Text(comentarios[index]['contenido'] ?? 'Sin contenido'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
