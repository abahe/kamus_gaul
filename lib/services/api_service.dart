import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kamus_model.dart';

class ApiService {
  // Ganti dengan IP server Laravel kamu
  static const String baseUrl = '';

  /// GET /api/kamus - list semua kata (paginated)
  Future<Map<String, dynamic>> getKamus({
    int page = 1,
    int perPage = 20,
    String? huruf,
    String sort = 'asc',
  }) async {
    final params = <String, String>{
      'page': '$page',
      'per_page': '$perPage',
      'sort': sort,
    };
    if (huruf != null && huruf.isNotEmpty) {
      params['huruf'] = huruf;
    }

    final uri = Uri.parse('$baseUrl/kamus').replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final paginatedData = body['data'];
      final List items = paginatedData['data'] ?? [];
      return {
        'items': items.map((e) => KamusModel.fromJson(e)).toList(),
        'current_page': paginatedData['current_page'] ?? 1,
        'last_page': paginatedData['last_page'] ?? 1,
        'total': paginatedData['total'] ?? 0,
      };
    }
    throw Exception('Gagal memuat data kamus');
  }

  /// GET /api/kamus/{id}
  Future<KamusModel> getKamusDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/kamus/$id'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return KamusModel.fromJson(body['data']);
    }
    throw Exception('Gagal memuat detail kata');
  }

  /// GET /api/kamus-search?q=keyword
  Future<Map<String, dynamic>> searchKamus({
    required String query,
    int page = 1,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/kamus-search',
    ).replace(queryParameters: {'q': query, 'page': '$page'});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final paginatedData = body['data'];
      final List items = paginatedData['data'] ?? [];
      return {
        'items': items.map((e) => KamusModel.fromJson(e)).toList(),
        'current_page': paginatedData['current_page'] ?? 1,
        'last_page': paginatedData['last_page'] ?? 1,
        'total': paginatedData['total'] ?? 0,
      };
    } else if (response.statusCode == 422) {
      return {'items': <KamusModel>[], 'total': 0};
    }
    throw Exception('Gagal mencari kata');
  }

  /// GET /api/kamus-random?count=n
  Future<List<KamusModel>> getRandomKamus({int count = 5}) async {
    final uri = Uri.parse(
      '$baseUrl/kamus-random',
    ).replace(queryParameters: {'count': '$count'});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List items = body['data'] ?? [];
      return items.map((e) => KamusModel.fromJson(e)).toList();
    }
    throw Exception('Gagal memuat kata random');
  }

  /// GET /api/stats
  Future<Map<String, dynamic>> getStats() async {
    final response = await http.get(Uri.parse('$baseUrl/stats'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Gagal memuat statistik');
  }
}
