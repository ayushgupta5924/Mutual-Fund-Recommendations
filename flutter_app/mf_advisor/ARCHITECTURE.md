# MVVM Architecture Structure

## Folder Structure

```
lib/
├── models/              # Data models (Model layer)
│   └── models.dart
├── views/               # UI screens (View layer)
│   ├── info_screen.dart
│   ├── input_screen.dart
│   └── results_screen.dart
├── viewmodels/          # Business logic (ViewModel layer)
│   └── recommendation_viewmodel.dart
├── repositories/        # Data access layer
│   └── mf_repository.dart
├── services/            # API services
│   └── api_service.dart
├── widgets/             # Reusable widgets
├── utils/               # Constants and helpers
│   └── constants.dart
└── main.dart
```

## Architecture Layers

### Model
- Data structures and business entities
- Located in `models/`

### View
- UI components and screens
- Located in `views/`
- Observes ViewModel for state changes

### ViewModel
- Business logic and state management
- Located in `viewmodels/`
- Communicates with Repository

### Repository
- Data access abstraction
- Located in `repositories/`
- Calls API services

### Services
- External API communication
- Located in `services/`
