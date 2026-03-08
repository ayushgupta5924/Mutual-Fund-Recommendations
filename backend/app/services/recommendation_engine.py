from app.models.user import UserProfile, FundRecommendation, RiskTolerance, InvestmentGoal
from app.services.mf_service import MutualFundService
from typing import List

class RecommendationEngine:
    def __init__(self):
        self.mf_service = MutualFundService()
    
    def get_recommendations(self, profile: UserProfile) -> List[FundRecommendation]:
        """Generate fund recommendations based on user profile"""
        allocation = self._get_allocation_strategy(profile)
        recommendations = []
        
        # Predefined top schemes for faster response
        scheme_map = {
            'Equity': '120503',
            'Debt': '118989',
            'Hybrid': '118590',
            'Liquid': '120505',
            'Mid Cap': '119551',
            'Large Cap': '120503',
        }
        
        total_percentage = 0
        for category, percentage in allocation.items():
            scheme_code = scheme_map.get(category)
            if scheme_code:
                try:
                    details = self.mf_service.get_scheme_details(scheme_code)
                    if details and details.get('data'):
                        nav_data = details['data']
                        meta = details.get('meta', {})
                        recommendations.append(FundRecommendation(
                            scheme_name=meta.get('scheme_name', f'{category} Fund'),
                            scheme_code=scheme_code,
                            category=category,
                            nav=float(nav_data[0]['nav']),
                            returns_1y=self.mf_service.calculate_returns(nav_data, 1),
                            returns_3y=self.mf_service.calculate_returns(nav_data, 3),
                            returns_5y=self.mf_service.calculate_returns(nav_data, 5),
                            risk_level=self._map_risk_level(category),
                            allocation_percentage=percentage,
                            allocation_amount=profile.budget * (percentage / 100),
                            reason=self._get_reason(category, profile)
                        ))
                        total_percentage += percentage
                except Exception as e:
                    print(f"Error fetching {category}: {e}")
                    continue
        
        # Ensure allocations sum to 100%
        if recommendations and total_percentage != 100:
            adjustment = 100 - total_percentage
            recommendations[0].allocation_percentage += adjustment
            recommendations[0].allocation_amount = profile.budget * (recommendations[0].allocation_percentage / 100)
        
        return recommendations
    
    def _get_categories_for_profile(self, profile: UserProfile) -> List[str]:
        """Map user profile to fund categories"""
        categories = []
        
        if profile.risk_tolerance == RiskTolerance.LOW:
            categories.extend(['Debt', 'Liquid', 'Ultra Short'])
        elif profile.risk_tolerance == RiskTolerance.MODERATE:
            categories.extend(['Hybrid', 'Balanced', 'Debt'])
        else:
            categories.extend(['Equity', 'Large Cap', 'Mid Cap'])
        
        if InvestmentGoal.TAX_SAVING in profile.goals:
            categories.append('ELSS')
        
        if profile.investment_horizon < 3:
            categories.extend(['Liquid', 'Short Duration'])
        
        return categories
    
    def _get_allocation_strategy(self, profile: UserProfile) -> dict:
        """Determine allocation percentages based on risk and budget"""
        budget = profile.budget
        horizon = profile.investment_horizon
        
        # Dynamic fund count based on budget
        if budget < 5000:
            # Very small: 1 fund
            if profile.risk_tolerance == RiskTolerance.LOW:
                return {'Debt': 100}
            elif profile.risk_tolerance == RiskTolerance.MODERATE:
                return {'Hybrid': 100}
            else:
                return {'Equity': 100}
        
        elif budget < 10000:
            # Small: 2 funds
            if profile.risk_tolerance == RiskTolerance.LOW:
                return {'Debt': 70, 'Liquid': 30}
            elif profile.risk_tolerance == RiskTolerance.MODERATE:
                return {'Hybrid': 60, 'Debt': 40}
            else:
                return {'Equity': 70, 'Debt': 30}
        
        elif budget < 25000:
            # Medium: 3 funds
            if profile.risk_tolerance == RiskTolerance.LOW:
                return {'Debt': 50, 'Liquid': 30, 'Hybrid': 20}
            elif profile.risk_tolerance == RiskTolerance.MODERATE:
                return {'Hybrid': 50, 'Debt': 30, 'Equity': 20}
            else:
                return {'Equity': 50, 'Mid Cap': 30, 'Debt': 20}
        
        elif budget < 50000:
            # Large: 4 funds
            if profile.risk_tolerance == RiskTolerance.LOW:
                return {'Debt': 40, 'Liquid': 30, 'Hybrid': 20, 'Equity': 10}
            elif profile.risk_tolerance == RiskTolerance.MODERATE:
                return {'Hybrid': 35, 'Debt': 30, 'Equity': 25, 'Liquid': 10}
            else:
                return {'Equity': 40, 'Mid Cap': 30, 'Large Cap': 20, 'Debt': 10}
        
        else:
            # Very large: 5+ funds
            if profile.risk_tolerance == RiskTolerance.LOW:
                return {'Debt': 35, 'Liquid': 25, 'Hybrid': 20, 'Equity': 15, 'Large Cap': 5}
            elif profile.risk_tolerance == RiskTolerance.MODERATE:
                return {'Hybrid': 30, 'Equity': 25, 'Debt': 20, 'Mid Cap': 15, 'Liquid': 10}
            else:
                return {'Equity': 35, 'Mid Cap': 25, 'Large Cap': 20, 'Hybrid': 10, 'Debt': 10}
    
    def _map_risk_level(self, category: str) -> str:
        """Map category to risk level"""
        if any(x in category.lower() for x in ['equity', 'mid cap', 'small cap']):
            return 'High'
        elif any(x in category.lower() for x in ['hybrid', 'balanced']):
            return 'Moderate'
        return 'Low'
    
    def _get_reason(self, category: str, profile: UserProfile) -> str:
        """Generate recommendation reason"""
        budget_note = ''
        if profile.budget < 10000:
            budget_note = ' Focused allocation suitable for smaller investments.'
        elif profile.budget < 50000:
            budget_note = ' Balanced diversification for medium investments.'
        else:
            budget_note = ' Full diversification for optimal risk management.'
        
        reasons = {
            'Equity': 'High growth potential for long-term wealth creation.' + budget_note,
            'Debt': 'Stable returns with lower risk.' + budget_note,
            'Hybrid': 'Balanced approach with moderate risk.' + budget_note,
            'Liquid': 'High liquidity for short-term needs.' + budget_note,
            'Mid Cap': 'Higher growth potential with increased volatility.' + budget_note,
            'ELSS': 'Tax benefits under Section 80C.' + budget_note
        }
        return reasons.get(category, 'Suitable for your investment profile.' + budget_note)
