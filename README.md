# 📚 Kamus Gaul - Indonesian Slang Dictionary App

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![License](https://img.shields.io/badge/license-MIT-green)

**Jelajahi dunia bahasa gaul Indonesia dengan aplikasi yang intuitif dan user-friendly** 🇮🇩

[Download di Play Store](#-download) • [Website](#-website) • [Fitur](#-fitur-utama)

</div>

---

## 📖 Tentang Aplikasi

**Kamus Gaul** adalah aplikasi kamus digital yang menyediakan kumpulan lengkap kata-kata dan istilah gaul Indonesia. Aplikasi ini dirancang untuk membantu Anda memahami, mempelajari, dan menguasai bahasa gaul yang sering digunakan dalam percakapan sehari-hari.

Dengan antarmuka yang modern dan intuitif, Kamus Gaul memberikan pengalaman pengguna yang menyenangkan dalam menjelajahi dunia slang bahasa Indonesia.

---

## 🎯 Fitur Utama

✨ **Pencarian Cepat** - Cari kata atau istilah gaul dengan mudah menggunakan fitur search yang responsif

❤️ **Favorit Pribadi** - Simpan kata-kata favorit Anda untuk akses cepat di kemudian hari

🌙 **Mode Gelap** - Fitur dark mode untuk kenyamanan membaca di malam hari

📚 **Database Komprehensif** - Ribuan kata dan istilah gaul Indonesia dengan penjelasan lengkap

⚡ **Performa Cepat** - Aplikasi offline-first dengan loading yang super cepat

🎨 **Desain Modern** - UI/UX yang indah dan mudah digunakan

---

## 📥 Download

<table align="center">
<tr>
<td align="center" width="200">
<a href="https://play.google.com/store/apps/details?id=id.my.kamusgaul.kamusgaul_app">
<img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" alt="Google Play Store" width="150"/>
</a>
<br/><b>Google Play Store</b>
</td>
<td align="center" width="200">
<a href="https://kamusgaul.ideas.my.id/">
<img src="https://img.shields.io/badge/Visit-Website-blue?style=for-the-badge" alt="Website"/>
</a>
<br/><b>Landing Page</b>
</td>
</tr>
</table>

---

## 🛠️ Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Provider
- **Database**: SQLite (sqflite)
- **Shared Preferences**: Local data storage
- **Platform**: Android & iOS

---

## 📦 Dependensi Utama

```yaml
provider: ^6.0.0
sqflite: ^2.0.0
shared_preferences: ^2.0.0
go_router: ^7.0.0
```

Lihat `pubspec.yaml` untuk daftar lengkap dependensi.

---

## 🚀 Instalasi & Setup untuk Developer

### Prerequisites
- Flutter SDK (versi 3.x atau lebih baru)
- Dart SDK
- Android Studio / Xcode
- Emulator atau physical device

### Langkah-Langkah

1. **Clone Repository**
   ```bash
   git clone https://github.com/abahe/kamus_gaul.git
   cd kamus_gaul
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Localizations** (jika diperlukan)
   ```bash
   flutter gen-l10n
   ```

4. **Run Application**
   ```bash
   flutter run
   ```

5. **Build APK** (Android)
   ```bash
   flutter build apk --release
   ```

6. **Build IPA** (iOS)
   ```bash
   flutter build ios --release
   ```

---

## 📁 Struktur Proyek

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/                   # Data models
│   └── kamus_model.dart
├── providers/                # State management
│   ├── home_provider.dart
│   ├── search_provider.dart
│   ├── favorite_provider.dart
│   ├── theme_provider.dart
│   ├── browse_provider.dart
│   └── navigation_provider.dart
├── screens/                  # UI Screens
│   ├── main_shell.dart
│   ├── home_screen.dart
│   ├── search_screen.dart
│   ├── detail_screen.dart
│   ├── favorite_screen.dart
│   └── settings_screen.dart
├── services/                 # Business logic
├── theme/                    # Theme configuration
└── widgets/                  # Reusable components
```

---

## 🎮 Cara Menggunakan

1. **Buka Aplikasi** - Launch Kamus Gaul di device Anda
2. **Jelajahi Beranda** - Lihat kata-kata populer dan rekomendasi
3. **Cari Kata** - Gunakan fitur search untuk mencari istilah spesifik
4. **Baca Detail** - Tap pada kata untuk membaca penjelasan lengkap
5. **Simpan Favorit** - Bookmark kata-kata menarik untuk dibaca nanti
6. **Atur Tema** - Pilih light atau dark mode sesuai preferensi

---

## 🤝 Kontribusi

Kami sangat menghargai kontribusi dari komunitas! Untuk berkontribusi:

1. Fork repository ini
2. Buat branch fitur (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan Anda (`git commit -m 'Add AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

---

## 📝 Lisensi

Proyek ini dilisensikan di bawah lisensi MIT - lihat file LICENSE untuk detail lebih lanjut.

---

## 👨‍💻 Autor

**Kamus Gaul App**  
Repository: [abahe/kamus_gaul](https://github.com/abahe/kamus_gaul)

---

## 📞 Support

Jika Anda memiliki pertanyaan atau saran, silakan:
- Buka [GitHub Issues](https://github.com/abahe/kamus_gaul/issues)
- Kunjungi [Landing Page](https://kamusgaul.ideas.my.id/)
- Hubungi kami melalui aplikasi

---

<div align="center">

Made with ❤️ by the Kamus Gaul Team

⭐ Jangan lupa untuk memberikan bintang jika aplikasi ini bermanfaat bagi Anda!

</div>
