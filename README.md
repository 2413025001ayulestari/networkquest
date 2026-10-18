# Network Quest

Game edukasi jaringan komputer berbasis Flutter. Aplikasi langsung membuka menu utama tanpa daftar, login, atau lupa password.

## Menjalankan

1. Pastikan Flutter SDK sudah terpasang (`flutter doctor`).
2. Buka folder ini di VS Code atau Android Studio.
3. Jalankan `flutter pub get`.
4. Hubungkan emulator/perangkat Android.
5. Jalankan `flutter run`.

## Membuat APK

```bash
flutter build apk --release
```

APK tersedia di `build/app/outputs/flutter-apk/app-release.apk`.

## Fitur

- Menu utama dan peta petualangan 7 level
- Kuis perangkat, kabel, IP Address, ping, troubleshooting, topologi/subnetting, dan ujian akhir
- Skor, tiga nyawa, bintang, penguncian level, dan progress
- Panduan materi jaringan
- Pilihan maskot NETTO/PIXEL
- Pengaturan suara, animasi, mode sulit, dan reset progress
- Penyimpanan progress otomatis secara lokal
- Game Zone mini-game tebak istilah
