import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://b015-181-41-144-234.ngrok-free.app/api';

// Método para iniciar sesión
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/Usuarios/Login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Email': email,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, retorna la información del usuario
      return json.decode(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      // Si la respuesta es error de autenticación
      throw Exception('Login fallido: Usuario o contraseña incorrectos');
    } else {
      // Si hay otro tipo de error
      throw Exception('Error en el servidor: ${response.statusCode}');
    }
  }

////Register
// Método para registrar un usuario
  Future<void> register(String nombre, String email, String password,
      String tipo, String? imagenBase64) async {
    final url = Uri.parse('$baseUrl/Usuarios/Register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Nombre': nombre,
        'Email': email,
        'Password': password,
        'Tipo': tipo,
        'ImagenBase64': imagenBase64,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }

  Future<List<dynamic>> fetchMisCursos(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Cursos/MisCursos?userId=$userId'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // Devuelve la lista de cursos
    } else if (response.statusCode == 400) {
      throw Exception('ID de usuario inválido');
    } else if (response.statusCode == 404) {
      throw Exception('No se encontraron cursos');
    } else {
      throw Exception('Error al obtener los cursos');
    }
  }

  Future<List<dynamic>> fetchCursos() async {
    final response = await http.get(Uri.parse('$baseUrl/Cursoes'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load cursos');
    }
  }

  Future<List<dynamic>> fetchSoportes() async {
    final response = await http.get(Uri.parse('$baseUrl/Soportes'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load soportes');
    }
  }

  Future<List<dynamic>> fetchComentarios() async {
    final response = await http.get(Uri.parse('$baseUrl/Comentarios'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Comentarios');
    }
  }

  Future<List<dynamic>> fetchLecciones() async {
    final response = await http.get(Uri.parse('$baseUrl/Lecciones'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Lecciones');
    }
  }
}
