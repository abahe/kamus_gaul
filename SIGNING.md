# Android Signing Configuration

## Setup untuk Release Build

Untuk menjalankan release build dan upload ke Play Store, ikuti langkah berikut:

### 1. Siapkan Keystore File
- Tempatkan file `kamus_gaul.jks` di direktori `android/` (root Android folder)
- File ini **TIDAK akan di-commit** ke git (ada di `.gitignore`)

### 2. Konfigurasi Properties
- Copy file `android/keystore.properties.example` menjadi `android/keystore.properties`
- **Edit** `keystore.properties` dengan nilai asli Anda:
  ```properties
  storeFile=../kamus_gaul.jks
  storePassword=your_actual_store_password
  keyAlias=your_actual_key_alias
  keyPassword=your_actual_key_password
  ```

### 3. Build Release APK
```bash
flutter build apk --release
```

### 4. Build Release App Bundle (untuk Play Store)
```bash
flutter build appbundle --release
```

## Security Notes
⚠️ **JANGAN pernah commit nilai berikut ke git:**
- File `.jks` (keystore file)
- File `keystore.properties` dengan password asli
- Hardcoded passwords/credentials

✅ File yang di-gitignore:
- `*.jks` - Keystore files
- `*.keystore` - Alternative keystore format
- `keystore.properties` - Configuration file dengan credentials

✅ File yang di-commit:
- `keystore.properties.example` - Template untuk developer lain

## For CI/CD Deployment
Jika menggunakan CI/CD (GitHub Actions, etc), tambahkan secrets:
- Store keystore file content dalam secrets
- Store keystore.properties content dalam secrets
- Decode dan inject saat build time

Contoh GitHub Actions akan disediakan di workflow file terpisah.
