import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produto.dart';

class ApiService {
  final String baseUrl = "http://SEU_IP:3000";

  Future<List<Produto>> buscarProdutos() async {
    final response = await http.get(Uri.parse("$baseUrl/produtos"));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => Produto.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao buscar produtos");
    }
  }
}