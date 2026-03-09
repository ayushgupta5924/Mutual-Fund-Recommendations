# Troubleshooting Guide

## App Shows "Bug" Error

If your phone shows the app has a bug, follow these steps:

### 1. Check Backend is Running
```bash
cd "MF analyzer/backend"
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

You should see:
```
INFO:     Uvicorn running on http://0.0.0.0:8000
```

### 2. Verify Network Connection
- Ensure your phone and PC are on the **same WiFi network**
- Check your PC's IP address hasn't changed:
```bash
ipconfig
```
Look for IPv4 Address under your WiFi adapter (should be 192.168.31.92)

### 3. Update IP Address if Changed
If your PC's IP changed, update `constants.dart`:
```dart
// File: flutter_app/mf_advisor/lib/utils/constants.dart
static const String baseUrl = 'http://YOUR_NEW_IP:8000/api';
```

Then rebuild:
```bash
flutter build apk --debug
```

### 4. Test Backend Connection
Open browser on your phone and visit:
```
http://192.168.31.92:8000/docs
```

If this doesn't load, the backend isn't reachable.

### 5. Check Firewall
Windows Firewall might be blocking port 8000. Allow Python through firewall:
- Windows Security → Firewall & network protection → Allow an app through firewall
- Find Python and check both Private and Public networks

### 6. Install Updated APK
The new APK with better error messages is at:
```
flutter_app/mf_advisor/build/app/outputs/flutter-apk/app-debug.apk
```

Transfer to phone and install. The app will now show detailed error messages.

## Common Error Messages

### "Cannot connect to server"
- Backend is not running
- Wrong IP address in constants.dart
- Phone and PC on different networks

### "Connection timeout"
- Firewall blocking connection
- Backend crashed or stopped
- Network issues

### "Server error: 500"
- Backend code error
- Check backend terminal for error logs

## Quick Test Checklist
- [ ] Backend running on PC
- [ ] Phone and PC on same WiFi
- [ ] IP address correct in constants.dart
- [ ] Firewall allows Python
- [ ] Can access http://YOUR_IP:8000/docs from phone browser
- [ ] Latest APK installed on phone
