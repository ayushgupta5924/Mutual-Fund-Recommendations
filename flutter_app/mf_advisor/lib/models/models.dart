class UserProfile {
  final double budget;
  final String riskTolerance;
  final int investmentHorizon;
  final List<String> goals;
  final int age;
  final double? monthlyIncome;

  UserProfile({
    required this.budget,
    required this.riskTolerance,
    required this.investmentHorizon,
    required this.goals,
    required this.age,
    this.monthlyIncome,
  });

  Map<String, dynamic> toJson() => {
    'budget': budget,
    'risk_tolerance': riskTolerance,
    'investment_horizon': investmentHorizon,
    'goals': goals,
    'age': age,
    'monthly_income': monthlyIncome,
  };
}

class FundRecommendation {
  final String schemeName;
  final String schemeCode;
  final String category;
  final double nav;
  final double? returns1y;
  final double? returns3y;
  final double? returns5y;
  final String riskLevel;
  final double allocationPercentage;
  final double allocationAmount;
  final String reason;

  FundRecommendation({
    required this.schemeName,
    required this.schemeCode,
    required this.category,
    required this.nav,
    this.returns1y,
    this.returns3y,
    this.returns5y,
    required this.riskLevel,
    required this.allocationPercentage,
    required this.allocationAmount,
    required this.reason,
  });

  factory FundRecommendation.fromJson(Map<String, dynamic> json) {
    return FundRecommendation(
      schemeName: json['scheme_name'],
      schemeCode: json['scheme_code'],
      category: json['category'],
      nav: json['nav'].toDouble(),
      returns1y: json['returns_1y']?.toDouble(),
      returns3y: json['returns_3y']?.toDouble(),
      returns5y: json['returns_5y']?.toDouble(),
      riskLevel: json['risk_level'],
      allocationPercentage: json['allocation_percentage'].toDouble(),
      allocationAmount: json['allocation_amount'].toDouble(),
      reason: json['reason'],
    );
  }
}
