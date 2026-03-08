# Mutual Fund Advisor

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Python](https://img.shields.io/badge/Python-3.8+-green.svg)
![FastAPI](https://img.shields.io/badge/FastAPI-0.104+-teal.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

A Flutter mobile app with Python FastAPI backend that provides personalized mutual fund recommendations based on user profile, budget, and investment goals using real-time market data.

## 🎯 Features

- **Smart Recommendations** - AI-powered fund selection based on 4 key factors
- **Real-time Data** - Live NAV and historical returns from MFApi
- **Dynamic Allocation** - Fund count varies from 1-5+ based on investment amount
- **Risk-Based Strategy** - Low, Moderate, and High risk portfolios
- **Goal-Oriented** - Retirement, wealth creation, tax saving, education
- **Modern UI** - Beautiful gradient design with MVVM architecture
- **Direct Investment Links** - One-tap access to fund investment pages

## 📱 Screenshots

*Add screenshots here*

## 🏗️ Architecture

### Frontend
- **Framework**: Flutter (MVVM Architecture)
- **State Management**: ChangeNotifier
- **UI**: Material Design 3

### Backend
- **Framework**: Python FastAPI
- **API**: RESTful
- **Data Source**: MFApi (https://api.mfapi.in)

### Folder Structure
```
MF analyzer/
├── backend/
│   ├── app/
│   │   ├── models/
│   │   ├── services/
│   │   ├── routes/
│   │   └── __init__.py
│   ├── main.py
│   └── requirements.txt
└── flutter_app/mf_advisor/
    ├── lib/
    │   ├── models/
    │   ├── views/
    │   ├── viewmodels/
    │   ├── repositories/
    │   ├── services/
    │   ├── utils/
    │   └── main.dart
    └── pubspec.yaml
```

## Features

- User profiling (budget, age, risk tolerance, investment horizon)
- Goal-based recommendations (retirement, wealth creation, education, tax saving)
- Real-time mutual fund data
- Portfolio allocation strategy
- Performance metrics (1Y, 3Y, 5Y returns)
- Risk-based fund categorization

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- Flutter 3.0+
- Git

### Backend Setup

1. Clone the repository:
```bash
git clone <your-repo-url>
cd "MF analyzer/backend"
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Run the server:
```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Server runs at: http://localhost:8000

### Flutter App Setup

1. Navigate to Flutter directory:
```bash
cd "../flutter_app/mf_advisor"
```

2. Install dependencies:
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

## 🧠 How It Works

The app analyzes **4 key factors** to recommend funds:

### 1. Risk Tolerance
- **Low**: 70% Debt + 30% Liquid
- **Moderate**: 50% Hybrid + 30% Debt + 20% Equity
- **High**: 60% Equity + 25% Mid Cap + 15% Debt

### 2. Investment Horizon
- **< 3 years**: Liquid & Short Duration funds
- **3-5 years**: Balanced allocation
- **> 5 years**: Higher equity exposure

### 3. Investment Goals
- Retirement → Long-term equity
- Tax Saving → ELSS funds
- Wealth Creation → Growth equity
- Short-term → Debt & liquid

### 4. Dynamic Fund Allocation
- **< ₹5,000**: 1 fund
- **₹5,000 - ₹10,000**: 2 funds
- **₹10,000 - ₹25,000**: 3 funds
- **₹25,000 - ₹50,000**: 4 funds
- **> ₹50,000**: 5+ funds

## 📡 API Endpoints

- `POST /api/recommend` - Get personalized recommendations
- `GET /api/schemes` - List all mutual fund schemes
- `GET /api/scheme/{code}` - Get scheme details

## 📊 Data Source

**MFApi** (https://api.mfapi.in)
- Free Indian mutual fund data
- Real-time NAV updates
- Historical performance
- No API key required

## 📝 License

MIT License - see [LICENSE](LICENSE) file

## 👤 Author

Created with ❤️ for smart investing

## ⭐ Show Your Support

Give a ⭐ if this project helped you!
