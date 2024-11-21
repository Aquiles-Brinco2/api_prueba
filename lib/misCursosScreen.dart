import 'package:flutter/material.dart';
import 'api_service.dart';

class MisCursosScreen extends StatefulWidget {
  final int userId;

  const MisCursosScreen({super.key, required this.userId});

  @override
  _MisCursosScreenState createState() => _MisCursosScreenState();
}

class _MisCursosScreenState extends State<MisCursosScreen> {
  late Future<List<dynamic>> _misCursos;

  @override
  void initState() {
    super.initState();
    _misCursos =
        ApiService().fetchMisCursos(widget.userId); // Cargar los cursos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Cursos'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _misCursos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No estás inscrito en ningún curso.'));
          } else {
            var cursos = snapshot.data!;
            return ListView.builder(
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                var curso = cursos[index];
                return ListTile(
                  title: Text(curso['tituloCurso']),
                  subtitle: Text(curso['descripcionCurso']),
                  trailing: Text(curso['calificacion'] != null
                      ? 'Calificación: ${curso['calificacion']}'
                      : 'Sin Calificación'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
