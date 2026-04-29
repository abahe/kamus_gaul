# Gradle Configuration

## Overview
Konfigurasi Gradle untuk project ini disimpan di beberapa file untuk security dan flexibility:

## File Konfigurasi

### 1. `gradle.properties` (Di-commit ✅)
File ini di-commit ke Git dan berisi default configuration untuk semua developer.

**Konfigurasi yang ada:**
- `android.ndkVersion` - NDK version yang digunakan

**Format:**
```properties
android.ndkVersion=27.0.12077973
```

### 2. `local.properties` (Tidak di-commit ❌)
File ini **tidak di-commit** ke Git dan berisi configuration lokal developer.

**Biasanya berisi:**
```properties
sdk.dir=E:\\Android\\Sdk
flutter.sdk=E:\\flutter
flutter.buildMode=debug
flutter.versionName=1.0.0
flutter.versionCode=2
```

**Cara setup:**
- File ini dibuat otomatis saat pertama kali jalankan project
- Atau buat manual dengan Android Studio: File → Project Structure

### 3. `keystore.properties` (Tidak di-commit ❌)
File ini **tidak di-commit** ke Git dan berisi credentials signing configuration.

**Setup:**
```bash
cp android/keystore.properties.example android/keystore.properties
```

## Cara mengubah NDK Version

### Opsi 1: Global (untuk semua developer)
Edit `android/gradle.properties`:
```properties
android.ndkVersion=27.0.12077973
```
Commit ke Git ✅

### Opsi 2: Local only (hanya untuk device Anda)
Edit `android/local.properties`:
```properties
android.ndkVersion=YOUR_VERSION
```
**Tidak di-commit** ❌

## Build Configuration Priority
Gradle membaca konfigurasi dengan urutan priority:

1. **local.properties** (highest) - Lokal development
2. **gradle.properties** - Project-wide defaults
3. **Environment variables** (lowest)

Contoh: Jika `android.ndkVersion` ada di kedua file, nilai dari `local.properties` yang digunakan.

## Troubleshooting

### "Could not find android.ndkVersion"
- Pastikan `gradle.properties` ada di `android/` folder
- Rebuild: `flutter clean && flutter pub get`

### NDK version mismatch
- Check: `android/gradle.properties` vs `android/local.properties`
- Check: Android Studio SDK Manager untuk NDK version yang terinstall
- Gunakan versi yang sesuai dengan target API level
