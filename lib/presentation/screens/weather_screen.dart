import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/theme/theme_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/additional_info_item.dart';
import 'package:weather_app/presentation/widgets/hourly_forecast_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String selectedCity = 'New Delhi';
  final List<String> indianCities = [
    'New Delhi',
    'Mumbai',
    'Bangalore',
    'Hyderabad',
    'Chennai',
    'Kolkata',
    'Pune',
    'Jaipur',
    'Ahmedabad',
    'Lucknow'
  ];

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    context.read<WeatherBloc>().add(WeatherFetched(cityName: selectedCity));
  }

  void _toggleTheme() {
    final currentBrightness = Theme.of(context).brightness;
    context
        .read<ThemeBloc>()
        .add(ThemeChanged(isDarkMode: currentBrightness != Brightness.dark));
  }

  String _formatHour(int hour) {
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return '${displayHour} ${hour < 12 ? 'AM' : 'PM'}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[50],
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherFailure) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 16,
                ),
              ),
            );
          }

          if (state is! WeatherSuccess) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            );
          }

          final data = state.weatherModel;
          final tempCelsius = (data.currentTemp - 273.15).toStringAsFixed(1);

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text(
                  'Weather Forecast',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                centerTitle: true,
                floating: true,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: _toggleTheme,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: _fetchWeather,
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildCitySelector(theme, isDarkMode),
                  _buildWeatherCard(
                      theme, isDarkMode, tempCelsius, data.currentSky),
                  _buildHourlyForecast(
                      isDarkMode, data.currentSky, data.currentTemp),
                  _buildAdditionalInfo(
                    isDarkMode,
                    data.currentHumidity,
                    data.currentWindSpeed,
                    data.currentPressure,
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCitySelector(ThemeData theme, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedCity,
        items: indianCities
            .map((city) => DropdownMenuItem(
                  value: city,
                  child: Text(
                    city,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (city) => setState(() {
          selectedCity = city!;
          _fetchWeather();
        }),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Select City',
          labelStyle: TextStyle(
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
      ),
    );
  }

  Widget _buildWeatherCard(
      ThemeData theme, bool isDarkMode, String temp, String sky) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [Colors.blueGrey[800]!, Colors.blueGrey[900]!]
              : [Colors.blue[100]!, Colors.blue[200]!],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            selectedCity,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$temp°C',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    sky,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getWeatherIcon(sky),
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast(bool isDarkMode, String sky, double temp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 16, bottom: 8),
          child: Text(
            'HOURLY FORECAST',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 8,
            itemBuilder: (context, index) {
              final hour = (DateTime.now().hour + index) % 24;
              return HourlyForecastItem(
                time: _formatHour(hour),
                temperature:
                    '${(temp - 273.15 + index - 4).toStringAsFixed(1)}°C',
                icon: _getWeatherIcon(sky),
                isDayTime: hour > 6 && hour < 18,
                isDarkMode: isDarkMode,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo(
      bool isDarkMode, double humidity, double windSpeed, double pressure) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AdditionalInfoItem(
            icon: Icons.water_drop,
            label: 'Humidity',
            value: '${humidity.toString()}%',
            color: Colors.blue,
            isDarkMode: isDarkMode,
          ),
          AdditionalInfoItem(
            icon: Icons.air,
            label: 'Wind',
            value: '${windSpeed.toString()} km/h',
            color: Colors.green,
            isDarkMode: isDarkMode,
          ),
          AdditionalInfoItem(
            icon: Icons.speed,
            label: 'Pressure',
            value: '${pressure.toString()} hPa',
            color: Colors.orange,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.umbrella;
      case 'clear':
        return Icons.wb_sunny;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
        return Icons.cloud_queue;
      default:
        return Icons.wb_sunny;
    }
  }
}
