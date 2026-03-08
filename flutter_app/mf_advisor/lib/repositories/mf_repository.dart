import '../models/models.dart';
import '../services/api_service.dart';

class MutualFundRepository {
  final ApiService _apiService = ApiService();

  Future<List<FundRecommendation>> getRecommendations(UserProfile profile) async {
    return await _apiService.getRecommendations(profile);
  }
}
