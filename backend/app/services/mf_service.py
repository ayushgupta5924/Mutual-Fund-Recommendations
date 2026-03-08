import requests
from typing import List, Dict, Optional

class MutualFundService:
    BASE_URL = "https://api.mfapi.in"
    
    def get_all_schemes(self) -> List[Dict]:
        """Fetch all available mutual fund schemes"""
        response = requests.get(f"{self.BASE_URL}/mf")
        return response.json() if response.status_code == 200 else []
    
    def get_scheme_details(self, scheme_code: str) -> Optional[Dict]:
        """Fetch specific scheme details with NAV history"""
        response = requests.get(f"{self.BASE_URL}/mf/{scheme_code}")
        return response.json() if response.status_code == 200 else None
    
    def calculate_returns(self, nav_data: List[Dict], years: int) -> Optional[float]:
        """Calculate returns for given period"""
        if not nav_data or len(nav_data) < 2:
            return None
        
        days_required = years * 365
        if len(nav_data) < days_required:
            return None
        
        try:
            current_nav = float(nav_data[0]['nav'])
            past_nav = float(nav_data[min(days_required, len(nav_data)-1)]['nav'])
            returns = ((current_nav - past_nav) / past_nav) * 100
            return round(returns, 2)
        except:
            return None
    
    def filter_schemes_by_category(self, schemes: List[Dict], categories: List[str]) -> List[Dict]:
        """Filter schemes by category keywords"""
        filtered = []
        for scheme in schemes:
            scheme_name = scheme.get('schemeName', '').lower()
            if any(cat.lower() in scheme_name for cat in categories):
                filtered.append(scheme)
        return filtered
