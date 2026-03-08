# Mutual Fund Recommendation Backend

## Setup

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run the server:
```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

## API Endpoints

- `POST /api/recommend` - Get fund recommendations
- `GET /api/schemes` - Get all available schemes
- `GET /api/scheme/{scheme_code}` - Get scheme details

## Data Source

Uses MFApi (https://api.mfapi.in) - Free Indian mutual fund data with real-time NAV updates.
