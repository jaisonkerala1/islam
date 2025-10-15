# Islamic Spiritual App

A comprehensive Islamic spiritual companion app built with Flutter and BLoC architecture.

## Features

### 🕌 Pray Tab
- **Daily Duas**: Collection of essential Islamic prayers
- **Qibla Finder**: GPS-based direction to Kaaba in Mecca
- **Tasbeeh Counter**: Digital dhikr counter with haptic feedback

### 📚 Learn Tab
- **Holy Quran**: Read and listen to Quranic verses
- **Islamic Courses**: Learn from expert teachers
- **Test Predictions**: Test your Islamic knowledge

### 👥 Community Tab
- **Discussions**: Engage with the Muslim community
- **Charity**: Support various Islamic causes
- **Articles**: Read insightful Islamic content

### 🔍 Search Tab
- **Find Mosques**: Discover mosques near your location
- **Halal Finder**: Locate halal restaurants and stores nearby
- **Islamic Products**: Shop for Islamic items and books

### 🌙 Dashboard (Central Tab)
- **Islamic Greeting**: As-salamu alaykum with Hijri calendar
- **Prayer Tracking**: Real-time prayer times with countdown
- **Check-in System**: Daily check-in with stars rewards
- **Weekly Streak**: Track your consistency over 7 days
- **Today's Prayers**: Navigate to detailed prayer times page
- **Deen Journey**: Monitor your spiritual progress
- **Quick Access**: Fast shortcuts to key features

## New Features ✨

### Prayer Tracking Dashboard
- **Current Prayer Time Card**: Dark teal card showing current time (4:33 pm), prayer (Asr), location (Mangaluru 🇮🇳), and next prayer countdown
- **Check-in Completion**: Track daily check-ins with star rewards system
- **Weekly Streak Tracker**: Visual 7-day progress with flame icon on current day
- **Today's Prayers Page**: Dedicated full-screen page with:
  - Gradient header with date and Hijri calendar
  - Progress summary with circular indicator
  - Special times (Imsak & Sunrise)
  - 5 daily prayers with emoji icons (✨☀️☁️🌅🌙)
  - "Now" badge for current prayer
  - Countdown timer for next prayer
  - Completion checkmarks and alarm settings

### Deen Journey Progress
- **Today's Progress Metrics**: Prayers (3/5), Quran (0/10 mins), Check-in (Done)
- **Achievements Cards**: Daily Streak (1-day 🔥), Prayer Journey (1-day 📗)
- **Share Feature**: Share your progress with the community

## Architecture

The app follows **BLoC (Business Logic Component)** architecture pattern for clean separation of concerns and testability.

### Project Structure
```
lib/
├── core/
│   ├── services/
│   │   ├── mongo_service.dart
│   │   ├── jwt_service.dart
│   │   └── twilio_service.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── widgets/
│       ├── custom_card.dart
│       └── circular_progress_painter.dart
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       ├── bloc/
│   │       └── pages/
│   ├── pray/
│   ├── learn/
│   ├── community/
│   ├── store/ (Search)
│   └── dashboard/
│       ├── data/
│       │   └── models/
│       │       └── prayer_tracking_model.dart
│       └── presentation/
│           ├── bloc/
│           └── pages/
│               ├── dashboard_page.dart
│               └── today_prayers_page.dart
└── main.dart
```

## Tech Stack

- **Flutter**: Cross-platform mobile framework
- **BLoC**: State management
- **MongoDB**: Database (with mongo_dart) - Backend ready
- **JWT**: Authentication tokens
- **Twilio**: OTP verification
- **Geolocator**: Location services
- **Audioplayers**: Audio playback
- **Video Player**: Video playback
- **Intl**: Date and time formatting

## Color Scheme

The app uses a modern **Teal & Amber** Islamic theme:

- **Primary**: `#0D9488` (Teal)
- **Secondary**: `#F59E0B` (Amber)
- **Background**: `#F0FDF4` (Very light green-white)
- **Base 200**: `#DCFCE7` (Lighter green)
- **Base 300**: `#BBF7D0` (Light green)
- **Text Primary**: `#1F2937` (Dark gray)
- **Text Secondary**: `#4B5563` (Medium gray)

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode
- JDK 17 (for Android builds)
- MongoDB instance (optional for testing)

### Installation

1. Clone the repository
```bash
git clone https://github.com/jaisonkerala1/islam.git
cd islam
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

### Build for Production

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

## Authentication

The app uses **Twilio OTP** for phone number verification:

- Test credentials are included for development
- OTP code for testing: `123456`
- Any phone number can be used in test mode

## Backend Services

### MongoDB Configuration
Update the connection string in `lib/core/services/mongo_service.dart`:
```dart
static const String connectionString = 'mongodb://your-server:27017/islamic_app';
```

### JWT Configuration
Update the secret key in `lib/core/services/jwt_service.dart`:
```dart
static const String _secretKey = 'your-production-secret-key';
```

### Twilio Configuration
Update credentials in `lib/core/services/twilio_service.dart`:
```dart
static const String accountSid = 'YOUR_ACCOUNT_SID';
static const String authToken = 'YOUR_AUTH_TOKEN';
static const String twilioNumber = 'YOUR_TWILIO_NUMBER';
```

## UI/UX Design

- **Modern Cards**: Gradient-based rounded cards with unique color schemes
- **Smooth Animations**: Fluid transitions and AnimatedSwitcher
- **Flat Minimal Icons**: Material Design icons with Islamic moon & star
- **Islamic Theme**: Teal and amber color palette
- **Glassmorphism**: Backdrop blur effects on key components
- **MuslimPro-Inspired**: Prayer tracking interface with dark teal cards
- **Responsive Design**: Touch-friendly tap targets
- **Custom Painters**: Circular progress rings with gradients

## Mock Data Structure

All prayer tracking features use local mock data that can be easily migrated to API:

```dart
// Prayer Tracking
PrayerTrackingData.mock()

// Daily Prayers
DailyPrayerData.mock()

// Deen Journey
DeenJourneyData.mock()
```

Future integration with **Aladhan API** for real prayer times is planned.

## Testing

Run tests with:
```bash
flutter test
```

## Contributing

Contributions are welcome! Please read the contributing guidelines first.

## License

This project is licensed under the MIT License.

## Acknowledgments

- Islamic content sourced from authentic hadith and Quranic references
- Icons from Material Design
- Community support and feedback
- Inspired by MuslimPro's prayer tracking UI/UX

## Repository

**GitHub**: [https://github.com/jaisonkerala1/islam.git](https://github.com/jaisonkerala1/islam.git)

## Contact

For support or queries, please open an issue on GitHub.

---

**May Allah accept this work and make it beneficial for the Ummah. Ameen.**
