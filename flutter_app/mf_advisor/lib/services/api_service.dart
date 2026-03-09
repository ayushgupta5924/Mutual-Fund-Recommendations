import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<FundRecommendation>> getRecommendations(UserProfile profile) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/recommend'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(profile.toJson()),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => FundRecommendation.fromJson(json)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Cannot connect to server. Make sure backend is running at ${AppConstants.baseUrl}');
    } on TimeoutException {
      throw Exception('Connection timeout. Check your network connection.');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
