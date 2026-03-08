import 'package:flutter/material.dart';
import '../models/models.dart';
import '../repositories/mf_repository.dart';

class RecommendationViewModel extends ChangeNotifier {
  final MutualFundRepository _repository = MutualFundRepository();
  
  List<FundRecommendation> _recommendations = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<FundRecommendation> get recommendations => _recommendations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchRecommendations(UserProfile profile) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _recommendations = await _repository.getRecommendations(profile);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
