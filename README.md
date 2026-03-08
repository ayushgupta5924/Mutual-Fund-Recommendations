# Mutual Fund Advisor

A Flutter app with Python backend that provides personalized mutual fund recommendations based on user profile, budget, and investment goals using real-time market data.

## Architecture

- **Frontend**: Flutter (Mobile/Web)
- **Backend**: Python FastAPI
- **Data Source**: MFApi (https://api.mfapi.in) - Free Indian mutual fund data with real-time NAV

## Features

- User profiling (budget, age, risk tolerance, investment horizon)
- Goal-based recommendations (retirement, wealth creation, education, tax saving)
- Real-time mutual fund data
- Portfolio allocation strategy
- Performance metrics (1Y, 3Y, 5Y returns)
- Risk-based fund categorization

## Setup Instructions

### Backend Setup

1. Navigate to backend directory:
```bash
cd backend
```

2. Install Python dependencies:
```bash
pip install -r requirements.txt
```

3. Run the FastAPI server:
```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Server will run at: http://localhost:8000

### Flutter App Setup

1. Navigate to Flutter app directory:
```bash
cd flutter_app/mf_advisor
```

2. Get Flutter dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

For web:
```bash
flutter run -d chrome
```

## API Endpoints

- `POST /api/recommend` - Get personalized fund recommendations
- `GET /api/schemes` - Get all available mutual fund schemes
- `GET /api/scheme/{scheme_code}` - Get detailed scheme information

## Usage

1. Start the backend server
2. Launch the Flutter app
3. Enter your investment details:
   - Budget
   - Age
   - Investment horizon
   - Risk tolerance (Low/Moderate/High)
   - Investment goals
4. Get personalized recommendations with allocation strategy

## Data Source

Uses **MFApi** - A free API providing real-time Indian mutual fund data including:
- NAV (Net Asset Value)
- Historical performance
- Scheme details
- Daily updates

No API key required!

## Project Structure

```
MF analyzer/
├── backend/
│   ├── app/
│   │   ├── models/
│   │   │   └── user.py
│   │   ├── services/
│   │   │   ├── mf_service.py
│   │   │   └── recommendation_engine.py
│   │   └── routes/
│   │       └── recommendations.py
│   ├── main.py
│   └── requirements.txt
└── flutter_app/
    └── mf_advisor/
        ├── lib/
        │   ├── models/
        │   │   └── models.dart
        │   ├── services/
        │   │   └── api_service.dart
        │   ├── screens/
        │   │   ├── input_screen.dart
        │   │   └── results_screen.dart
        │   └── main.dart
        └── pubspec.yaml
```

## Notes

- Backend must be running before launching the Flutter app
- For production, update the API base URL in `lib/services/api_service.dart`
- MFApi provides Indian mutual fund data only
