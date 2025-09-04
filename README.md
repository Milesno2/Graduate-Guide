# Newly Graduate Hub

A comprehensive Flutter mobile application designed to help newly graduated students navigate their career journey. The app provides tools for skill development, job searching, resume building, and professional networking.

## Features

### 🎯 Core Features
- **Preloader & Onboarding**: Beautiful animated preloader and onboarding experience
- **User Authentication**: Secure registration and login with Supabase backend
- **Profile Management**: Complete user profile with photo upload capability
- **Dashboard**: Comprehensive dashboard with quick actions and progress tracking
- **Skills Development**: Skills assessment and learning path recommendations
- **Job Search**: Curated job opportunities for graduates
- **Resume Builder**: Professional resume creation tools

### 🎨 UI/UX Features
- **Modern Design**: Clean, intuitive interface with Material Design 3
- **Smooth Animations**: Flutter Animate for engaging user interactions
- **Responsive Layout**: Optimized for various screen sizes
- **Asset Integration**: Properly integrated preloader and page assets
- **Google Fonts**: Beautiful typography with Poppins font family

## Screenshots

### Preloader & Onboarding
- Animated preloader with cycling images
- Multi-step onboarding with beautiful illustrations
- Smooth transitions and progress indicators

### Authentication
- Modern login screen with validation
- Comprehensive registration form
- Profile photo upload functionality
- Password visibility toggle

### Dashboard
- Quick action cards for main features
- Recent activity feed
- Progress statistics
- Bottom navigation with 4 main sections

## Setup Instructions

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd newly_graduate_hub
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   - Create a Supabase project at [supabase.com](https://supabase.com)
   - Get your project URL and anon key
   - Update `lib/services/supabase_service.dart`:
     ```dart
     static const String _supabaseUrl = 'YOUR_SUPABASE_URL';
     static const String _supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
     ```

4. **Set up Supabase Database**
   Create the following table in your Supabase database:
   ```sql
   CREATE TABLE profiles (
     id UUID REFERENCES auth.users(id) PRIMARY KEY,
     email TEXT,
     name TEXT,
     phone TEXT,
     gender TEXT,
     university TEXT,
     graduation_year TEXT,
     course TEXT,
     avatar_url TEXT,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
     updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
   );
   ```

5. **Set up Supabase Storage**
   - Create a storage bucket named `avatars`
   - Set up storage policies for profile images

6. **Run the application**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── preloader_screen.dart # Animated preloader
│   ├── onboarding_screen.dart # Multi-step onboarding
│   ├── login_screen.dart     # User login
│   ├── register_screen.dart  # User registration
│   └── home_screen.dart      # Main dashboard
└── services/
    └── supabase_service.dart # Backend integration
```

## Assets

### Preloader Assets
- `preloader assets/Preloader1 (1).png`
- `preloader assets/Preloader2 (1).png`
- `preloader assets/Preloader3 (1).png`
- `preloader assets/Preloader4 (1).png`
- `preloader assets/Charco Education.png`
- `preloader assets/Fresh Folk Teaching.png`
- `preloader assets/Happy Bunch Chat.png`
- `preloader assets/Olá Playing Video Games.png`

### Page Assets
- `pages assets/login (1).png`
- `pages assets/UserCircle.png`
- `pages assets/Resume Buider (1).png`
- `pages assets/Skills.png`
- `pages assets/job task.png`
- `pages assets/updates.png`
- `pages assets/Me.png`
- And many more...

## Dependencies

### Core Dependencies
- `flutter`: Flutter SDK
- `supabase_flutter`: Backend as a Service
- `shared_preferences`: Local data storage
- `image_picker`: Image selection and capture
- `provider`: State management

### UI/UX Dependencies
- `flutter_animate`: Smooth animations
- `google_fonts`: Beautiful typography
- `cached_network_image`: Image caching
- `flutter_svg`: SVG support
- `lottie`: Lottie animations

### Utility Dependencies
- `http`: HTTP requests
- `intl`: Internationalization
- `url_launcher`: External link handling
- `file_picker`: File selection

## Backend Integration

### Supabase Features Used
- **Authentication**: User registration and login
- **Database**: User profiles and data storage
- **Storage**: Profile image uploads
- **Real-time**: Live data updates

### Netlify Functions (Serverless Backend)

This project includes lightweight backend endpoints using Netlify Functions.

- Endpoints (after deploy or `netlify dev`):
  - `/.netlify/functions/check` (GET)
  - `/.netlify/functions/contact` (POST)

#### Local development

1. Install Netlify CLI (one-time):
   ```bash
   npm install -g netlify-cli
   ```
2. Run local dev server (serves Flutter web build and functions):
   ```bash
   flutter build web --release
   netlify dev
   ```

Netlify dev will proxy requests to functions at `http://localhost:8888/.netlify/functions/*`.

#### Test with curl

```bash
curl -s http://localhost:8888/.netlify/functions/check | jq

curl -s -X POST \
  -H 'Content-Type: application/json' \
  -d '{"name":"Alice","email":"alice@example.com","message":"Hi"}' \
  http://localhost:8888/.netlify/functions/contact | jq
```

#### Flutter usage example

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendContact(String name, String email, String message) async {
  final uri = Uri.parse('/.netlify/functions/contact');
  final res = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name, 'email': email, 'message': message}),
  );
  if (res.statusCode != 200) {
    throw Exception('Contact failed: \'${res.statusCode}\'');
  }
}
```

Notes:
- CORS is enabled globally for functions via `netlify.toml` and per-function handlers.
- Functions live in `netlify/functions/` and are bundled with esbuild on deploy.

### Database Schema
```sql
profiles (
  id UUID PRIMARY KEY,
  email TEXT,
  name TEXT,
  phone TEXT,
  gender TEXT,
  university TEXT,
  graduation_year TEXT,
  course TEXT,
  profession TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
)
```

## Development

### Code Style
- Follows Flutter best practices
- Uses Google Fonts for consistent typography
- Implements Material Design 3 principles
- Proper error handling and loading states

### State Management
- Provider pattern for state management
- Local state for UI components
- Supabase for backend state

### Navigation
- Named routes for clean navigation
- Proper back navigation handling
- Route guards for authenticated sections

## Future Enhancements

### Planned Features
- [ ] Skills assessment quizzes
- [ ] Job application tracking
- [ ] Resume builder with templates
- [ ] Networking features
- [ ] Push notifications
- [ ] Offline support
- [ ] Multi-language support

### Technical Improvements
- [ ] Unit and widget tests
- [ ] CI/CD pipeline
- [ ] Performance optimization
- [ ] Accessibility improvements
- [ ] Dark mode support

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

## Acknowledgments

- Flutter team for the amazing framework
- Supabase for the backend infrastructure
- The design assets creators
- The open-source community

---

**Built with ❤️ for newly graduated students** 