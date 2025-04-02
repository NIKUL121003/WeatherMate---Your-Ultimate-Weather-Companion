# 🌤️ WeatherMate - Your Ultimate Weather Companion

Welcome to **WeatherMate**, a beautifully designed and powerful weather app that delivers real-time weather updates with an intuitive and engaging experience. Whether you’re planning your day, a trip, or just curious about global weather conditions, WeatherMate has got you covered. 🌍☁️  

---

## ⚙️ How It Works  

🔹 **Live Weather Data** – Fetches real-time weather updates from OpenWeather API, including temperature, humidity, wind speed, and forecasts.  
🔹 **Seamless UI & Theming** – Enjoy a smooth experience with dark/light mode support and adaptive UI for all devices.  
🔹 **State-of-the-Art BLoC Architecture** – Ensuring predictable state management and a highly responsive app.  
🔹 **Error Handling** – Smart detection of network issues, invalid locations, and failed API responses.  
🔹 **Offline Mode** – View your last-fetched weather details even without an internet connection.  

---

## 🌎 Key Features  

✅ **Multi-City Support** – Track weather from multiple locations at once.  
✅ **Dynamic Forecasting** – Get hourly and daily weather insights at a glance.  
✅ **Realistic Weather Animations** – Enhancing the user experience with interactive visuals.  
✅ **Live Theme Toggle** – Auto-adapting themes based on time of day or user preferences.  
✅ **Custom Widgets** – Beautiful and functional UI elements for an engaging experience.  

---

## 🚀 Getting Started  

### Prerequisites  
Ensure you have:  
- Flutter SDK (≥3.0.0)  
- Dart SDK (≥2.17.0)  
- API key for OpenWeather (stored securely in `.env` file)  

### Installation  
```sh
# Clone the repository
git clone https://github.com/yourusername/weathermate.git
cd weathermate

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🔗 API Configuration  
Create a `.env` file in the root directory:  
```env
API_BASE_URL=https://api.openweathermap.org/data/2.5/
API_KEY=your_secret_api_key
```

Sample API Request:  
```
GET /weather?q=London&appid=your_api_key
```

---

## 🛠️ Build & Deployment  

### Android Build:  
```sh
flutter build apk --release
```

### iOS Build:  
```sh
flutter build ios --release
```

### Web Build:  
```sh
flutter build web --release
```

---

## 🧪 Running Tests  
```sh
flutter test
```
Example test:  
```dart
test('Weather API returns data', () async {
  final weatherData = await WeatherRepository().fetchWeather("New York");
  expect(weatherData.temperature, isNotNull);
});
```

---

## 🎯 Future Enhancements  

🚀 **AI-Powered Weather Predictions**  
🌍 **Global Weather Maps**  
🗓 **7-Day Forecast with Graphs**  
📍 **GPS-based Auto Location Detection**  

---

🌦️ **WeatherMate** – Because knowing the weather should be a delightful experience! ☀️💨
