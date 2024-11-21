import 'package:flutter/material.dart';
import 'api_service.dart';

class SoportesScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  SoportesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Soportes')),
      body: FutureBuilder(
        future: apiService.fetchSoportes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final soportes = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: soportes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text(soportes[index]['mensaje'] ?? 'Soporte sin nombre'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
