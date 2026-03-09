# App Icon Setup

1. Create a 512x512 PNG icon for your app
2. Use a tool like: https://appicon.co/ or https://icon.kitchen/
3. Replace the default icon in:
   - android/app/src/main/res/mipmap-*/ic_launcher.png

Or use flutter_launcher_icons package:

1. Add to pubspec.yaml:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
```

2. Run: flutter pub run flutter_launcher_icons
