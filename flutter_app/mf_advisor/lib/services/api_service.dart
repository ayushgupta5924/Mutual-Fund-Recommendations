import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<FundRecommendation>> getRecommendations(UserProfile profile) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/recommend'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(profile.toJson()),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => FundRecommendation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get recommendations');
    }
  }
}
