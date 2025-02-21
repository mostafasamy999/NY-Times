# NY Times News App 📰

A modern, cross-platform news application that delivers New York City news articles and videos using clean architecture principles and cutting-edge mobile development practices.

![Platform Support](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-blue)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-green)
![State Management](https://img.shields.io/badge/State%20Management-Cubit-purple)



[<!-- Uploading "WhatsApp Video 2025-02-21 at 16.21.08_2dad6e92.mp4"... -->
](https://github.com/user-attachments/assets/8db95029-0807-4a04-9100-8a5a8ae194d2)

## 🌟 Features

- **Rich Content Delivery**
  - Latest NYC news articles with dynamic content loading
  - Video support with seamless playback integration
  - Shimmer loading effects for enhanced UX
  - Responsive design adapting to all screen sizes

- **Technical Implementation**
  - Clean Architecture with MVVM pattern
  - Cubit state management for predictable state flows
  - Dependency Injection for better testability
  - Symbolic integration for resource optimization

## 🏗️ Architecture Overview

The application follows Clean Architecture principles with the following layers:

```
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── sources/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── cubits/
    ├── pages/
    └── widgets/
```

### Layer Details

1. **Presentation Layer**
   - Implements MVVM pattern
   - Uses Cubit for state management
   - Contains reusable UI components
   - Handles responsive layouts

2. **Domain Layer**
   - Pure business logic
   - Use cases implementation
   - Repository interfaces

3. **Data Layer**
   - API integration
   - Local storage
   - Repository implementations

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- iOS Development tools (for iOS build)

### Installation

1. Clone the repository
```bash
git clone https://github.com/mostafasamy999/NY-Times.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 📱 Platform-Specific Features

### Android
- Material 3 design implementation
- Native video player integration
- Android 13 theme adaptation
- Custom shimmer effects

### iOS
- Native iOS UI components
- Video kit integration
- Adaptive layout support


## 🔄 State Management

The app uses Cubit for state management with the following structure:

```dart
└── lib/
    └── presentation/
        └── cubits/
            ├── article_cubit.dart
            ├── video_cubit.dart
            └── theme_cubit.dart
```

### Example Cubit Implementation:

```dart
class ArticleCubit extends Cubit<ArticleState> {
  final GetArticlesUseCase getArticles;
  
  ArticleCubit(this.getArticles) : super(ArticleInitial());
  
  Future<void> loadArticles() async {
    emit(ArticleLoading());
    try {
      final articles = await getArticles();
      emit(ArticleLoaded(articles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
```

## 🎨 UI Components

The app includes custom UI components with shimmer effects:

```dart
class ShimmerArticleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ArticleCardLayout(),
    );
  }
}
```
## 📚 Dependencies

- `flutter_bloc`: ^9.0.0
- `http`: ^1.3.0
- `get_it`: ^8.0.3
- `intl`: ^0.20.2
- `share_plus`: ^10.1.4
- `shimmer`: ^3.0.0

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
