# Generate Signing Key for Play Store

## Step 1: Generate Keystore

Run this command in terminal:

```bash
keytool -genkey -v -keystore mf-advisor-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias mf-advisor
```

You'll be asked:
- Password (remember this!)
- Your name
- Organization
- City, State, Country

## Step 2: Create key.properties

Create file: `android/key.properties`

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=mf-advisor
storeFile=../mf-advisor-key.jks
```

## Step 3: Update build.gradle

Already configured in android/app/build.gradle

## Step 4: Build Signed APK

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## IMPORTANT:
- Keep mf-advisor-key.jks safe (backup it!)
- Never commit key.properties to git
- Add to .gitignore: *.jks, key.properties
