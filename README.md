# Servisin Aja — Flutter Mobile Booking Service

Aplikasi mobile **Servisin Aja** merupakan implementasi Flutter untuk studi kasus **Mobile Booking Service Kendaraan** berdasarkan rancangan UI/UX pada Figma.

Project ini mencakup alur utama booking kendaraan secara end-to-end, mulai dari pemilihan kendaraan, konfigurasi service, pemilihan part/oli, workshop, jadwal service, review booking, hingga booking success dan tracking.

---

## 🎨 Figma Design

**Public Figma Design:**

https://www.figma.com/design/iwMwf5OnGPlX3LW7FKh9Mc/Servisin-Aja-%E2%80%94-Mobile-Booking-Service-UI-UX

> Pastikan permission Figma diatur menjadi **Anyone with the link → Can view** sebelum submission.

Target design:

* Frame: **390 × 844 px**
* Typeface: **Inter**
* Primary: `#F26114`
* Soft Orange: `#FFF0E3`
* Background: `#F9F9FA`
* Dark: `#14171F`
* Muted: `#6B707A`
* Border: `#DEE0E5`
* Card Radius: `16 px`
* Control Radius: `12 px`
* Button Radius: `14 px`
* Horizontal Padding: `24 px`

---

# ✨ Features

## Core Booking Flow

* Home
* Multi-vehicle selection
* Per-vehicle service configuration
* Part / Oli catalog
* Workshop detail
* Workshop selection
* Date selection
* Time selection
* Booking review
* Booking confirmation
* Booking success ticket
* Service tracking

## Additional Features

* Mechanic tracking
* Invoice
* Rating
* Booking history
* Notifications
* Profile
* Vehicle detail
* Service catalog
* UI states / edge cases

---

# 🧭 Booking Flow

```text
Home
 │
 ▼
Vehicle Selection
 │
 ▼
Vehicle Service Configuration
 │
 ▼
Part / Oli
 │
 ▼
Workshop
 │
 ▼
Date & Time
 │
 ▼
Review Booking
 │
 ▼
Booking Success
 │
 ▼
Service Tracking
 │
 ├── Mechanic Tracking
 │
 └── Invoice
      │
      ▼
    Rating
```

Multi-vehicle booking:

```text
Booking
├── Vehicle 1
│   └── Service Configuration
│
└── Vehicle 2
    └── Service Configuration
```

---

# 🏗️ Project Architecture

Project menggunakan pemisahan tanggung jawab antara **Core, Domain, Data, State, dan Presentation**.

```text
lib/
├── core/
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── formatters.dart
│
├── data/
│   └── mock/
│       ├── mock_booking_repository.dart
│       └── mock_data.dart
│
├── domain/
│   ├── entities/
│   │   ├── booking.dart
│   │   ├── service.dart
│   │   ├── vehicle.dart
│   │   └── workshop.dart
│   │
│   ├── repositories/
│   │   └── booking_repository.dart
│   │
│   └── models.dart
│
├── state/
│   └── booking_controller.dart
│
├── presentation/
│   ├── widgets/
│   │   └── app_components.dart
│   │
│   └── screens/
│       ├── booking/
│       │   ├── booking_success_screen.dart
│       │   ├── review_booking_screen.dart
│       │   ├── tracking_screen.dart
│       │   ├── vehicle_selection_screen.dart
│       │   ├── vehicle_service_screen.dart
│       │   └── workshop_schedule_screen.dart
│       │
│       ├── bonus/
│       │   ├── booking_history_screen.dart
│       │   ├── invoice_screen.dart
│       │   ├── mechanic_tracking_screen.dart
│       │   ├── rating_screen.dart
│       │   ├── service_catalog_screen.dart
│       │   ├── vehicle_detail_screen.dart
│       │   └── workshop_detail_screen.dart
│       │
│       ├── home_screen.dart
│       ├── notifications_screen.dart
│       ├── profile_screen.dart
│       └── ui_states_screen.dart
│
└── main.dart
```

---

# 📂 Folder Responsibilities

### `core/`

Berisi komponen dasar aplikasi yang digunakan lintas fitur.

```text
core/
├── theme/
│   └── app_theme.dart
└── utils/
    └── formatters.dart
```

`app_theme.dart` digunakan untuk mengelola theme dan design token.

`formatters.dart` berisi utility untuk formatting data seperti currency, date, dan informasi lainnya.

---

### `domain/`

Berisi struktur inti aplikasi yang tidak bergantung pada UI.

```text
domain/
├── entities/
├── repositories/
└── models.dart
```

Entity utama:

* `Booking`
* `Service`
* `Vehicle`
* `Workshop`

Repository contract:

```text
domain/repositories/booking_repository.dart
```

Repository digunakan sebagai abstraction layer antara business logic dan sumber data.

---

### `data/`

Berisi implementasi sumber data.

```text
data/
└── mock/
    ├── mock_booking_repository.dart
    └── mock_data.dart
```

Untuk technical assessment ini, repository menggunakan **mock data** sehingga aplikasi dapat berjalan tanpa backend.

---

### `state/`

State management menggunakan:

**Provider + ChangeNotifier**

Controller utama:

```text
state/booking_controller.dart
```

`BookingController` menangani state booking seperti:

* Selected vehicles
* Active booking
* Vehicle service configuration
* Selected service
* Selected part / oli
* Selected workshop
* Selected date
* Selected time
* Booking status

---

### `presentation/`

Berisi seluruh UI aplikasi.

```text
presentation/
├── widgets/
└── screens/
```

Reusable UI component ditempatkan pada:

```text
presentation/widgets/app_components.dart
```

Screen dipisahkan berdasarkan feature.

---

# 📱 Booking Screens

```text
presentation/screens/booking/

├── vehicle_selection_screen.dart
├── vehicle_service_screen.dart
├── workshop_schedule_screen.dart
├── review_booking_screen.dart
├── booking_success_screen.dart
└── tracking_screen.dart
```

Screen tersebut membentuk core booking flow dari pemilihan kendaraan sampai tracking service.

---

# ⭐ Additional / Bonus Screens

Fitur tambahan dikelompokkan pada:

```text
presentation/screens/bonus/
```

Berisi:

```text
├── booking_history_screen.dart
├── invoice_screen.dart
├── mechanic_tracking_screen.dart
├── rating_screen.dart
├── service_catalog_screen.dart
├── vehicle_detail_screen.dart
└── workshop_detail_screen.dart
```

---

# 🗃️ Mock Data

Mock data utama tersedia pada:

```text
assets/mock_data.json
```

Data digunakan untuk menyediakan:

* Vehicles
* Services
* Parts / Oli
* Workshops
* Available dates
* Available time slots
* Booking information

Aplikasi tidak membutuhkan backend untuk menjalankan prototype.

---

# 🎨 Design System

Design token dipusatkan pada:

```text
lib/core/theme/app_theme.dart
```

Reusable components dipusatkan pada:

```text
lib/presentation/widgets/app_components.dart
```

Dengan pendekatan tersebut, perubahan terhadap:

* Color
* Typography
* Radius
* Spacing
* Button
* Card
* Input
* Component

dapat dilakukan secara terpusat untuk membantu menjaga konsistensi visual dengan Figma.

---

# 📦 Requirements

Pastikan environment telah memiliki:

* Flutter SDK
* Dart SDK
* Android SDK
* Android Studio
* Android Emulator atau Android Device
* Git

Verifikasi instalasi:

```bash
flutter doctor
```

Verifikasi versi:

```bash
flutter --version
```

---

# 🚀 Installation

Clone repository:

```bash
git clone <PUBLIC_GITHUB_REPOSITORY_URL>
```

Masuk ke project:

```bash
cd servis_in_aja_flutter
```

Install dependency:

```bash
flutter pub get
```

---

# ▶️ Run Project

Cek device:

```bash
flutter devices
```

Jalankan aplikasi:

```bash
flutter run
```

Untuk Android release mode:

```bash
flutter run --release
```

---

# 🧪 Analyze & Test

Static analysis:

```bash
flutter analyze
```

Run test:

```bash
flutter test
```

Recommended verification sebelum submission:

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run
```

---

# 📱 Build APK

Build release APK:

```bash
flutter build apk --release
```

APK akan tersedia di:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

# 📥 APK Download

**Release APK:**

> [ISI LINK GOOGLE DRIVE ATAU GITHUB RELEASE DI SINI]

APK disediakan agar tim reviewer dapat langsung meng-install dan menguji aplikasi pada perangkat Android.

---

# 💻 Public GitHub Repository

**Repository:**

> [ISI LINK GITHUB PUBLIC DI SINI]

Repository harus bersifat public dan mencakup:

* Source code
* Assets
* Mock data
* Test
* README
* Flutter configuration
* Commit history

---

# 📝 Commit History

Commit dibuat dengan deskripsi yang menjelaskan perubahan.

Contoh:

```text
feat: implement multi vehicle selection
feat: add vehicle service configuration
feat: implement workshop schedule selection
feat: add booking review flow
feat: implement booking success screen
feat: add service tracking
feat: add invoice and rating
feat: add booking history
feat: add notification screen
feat: add profile screen
fix: synchronize booking controller state
refactor: extract reusable app components
style: adjust UI spacing to match Figma
docs: update README
```

---

# 📐 Pixel Precision

Implementasi UI mengikuti design reference pada Figma dengan target:

```text
390 × 844 px
```

Perhatian utama diberikan pada:

* Layout
* Spacing
* Typography
* Font weight
* Color
* Border
* Border radius
* Icon size
* Button size
* Card size
* Component alignment

Design token dan reusable component dipusatkan agar proses fine-tuning terhadap Figma dapat dilakukan secara konsisten.

---

# ✅ Submission Checklist

## Figma

* [ ] Public Figma link
* [ ] Anyone with the link → Can view
* [ ] Home tersedia
* [ ] Multi-vehicle flow tersedia
* [ ] Service configuration tersedia
* [ ] Workshop & schedule tersedia
* [ ] Review booking tersedia
* [ ] Booking success tersedia

## GitHub

* [ ] Repository public
* [ ] Source code lengkap
* [ ] Struktur folder terorganisir
* [ ] Mock data tersedia
* [ ] README tersedia
* [ ] Commit history deskriptif

## APK

* [ ] Release APK berhasil dibuat
* [ ] APK dapat di-install
* [ ] APK dapat dijalankan
* [ ] APK tersedia melalui Google Drive / GitHub Releases

## Flutter

* [ ] `flutter pub get`
* [ ] `flutter analyze`
* [ ] `flutter test`
* [ ] `flutter run`
* [ ] `flutter build apk --release`

---

# ⚠️ Notes

Project ini merupakan **Flutter functional prototype** yang menggunakan mock repository.

Tidak diperlukan backend untuk menjalankan alur utama aplikasi.

Data mock tersedia pada:

```text
assets/mock_data.json
```

Project juga memiliki platform configuration Flutter untuk:

* Android
* iOS
* Web
* Windows
* macOS
* Linux

Untuk technical assessment mobile, platform utama yang ditargetkan adalah **Android**.

---

# 👤 Author

**Dewi Laylaturrohmah**

Flutter • Laravel • TypeScript • React.js • REST API • MySQL

---

# 🔗 Submission Links

| Requirement | Link              |
| ----------- | ----------------- |
| 🎨 Figma    | [ISI LINK FIGMA]  |
| 💻 GitHub   | [ISI LINK GITHUB] |
| 📱 APK      | [ISI LINK APK]    |
