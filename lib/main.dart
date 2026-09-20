import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

// =====================================================
// MAIN APP
// =====================================================

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Weather App',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),

      home: const WeatherHomeScreen(),
    );
  }
}

// =====================================================
// WEATHER HOME SCREEN
// =====================================================

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() =>
      _WeatherHomeScreenState();
}

class _WeatherHomeScreenState
    extends State<WeatherHomeScreen> {

  // ===================================================
  // CONTROLLER
  // ===================================================

  final TextEditingController cityController =
  TextEditingController(text: 'Delhi');

  // ===================================================
  // VARIABLES
  // ===================================================

  bool isLoading = false;

  String? errorMessage;

  String? cityName;

  double? temperature;

  String weatherCondition = '';

  int? weatherCode;

  // ===================================================
  // WEATHER CODE -> CONDITION
  // ===================================================

  String getWeatherCondition(int code) {

    if (code == 0) {
      return 'Clear Sky';
    }

    if (code == 1 ||
        code == 2 ||
        code == 3) {
      return 'Partly Cloudy';
    }

    if (code == 45 ||
        code == 48) {
      return 'Foggy';
    }

    if (code >= 51 &&
        code <= 67) {
      return 'Rainy';
    }

    if (code >= 71 &&
        code <= 77) {
      return 'Snowy';
    }

    if (code >= 80 &&
        code <= 82) {
      return 'Rain Showers';
    }

    if (code >= 85 &&
        code <= 86) {
      return 'Snow Showers';
    }

    if (code >= 95 &&
        code <= 99) {
      return 'Thunderstorm';
    }

    return 'Unknown Weather';
  }

  // ===================================================
  // WEATHER ICON
  // ===================================================

  IconData getWeatherIcon(int code) {

    if (code == 0) {
      return Icons.wb_sunny;
    }

    if (code >= 1 &&
        code <= 3) {
      return Icons.cloud;
    }

    if (code == 45 ||
        code == 48) {
      return Icons.cloud;
    }

    if (code >= 51 &&
        code <= 82) {
      return Icons.umbrella;
    }

    if (code >= 95) {
      return Icons.thunderstorm;
    }

    return Icons.cloud;
  }

  // ===================================================
  // FETCH WEATHER
  // ===================================================

  Future<void> fetchWeather() async {

    final city =
    cityController.text.trim();

    if (city.isEmpty) {

      setState(() {
        errorMessage =
        'Please enter a city name.';
      });

      return;
    }

    // Loading start
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {

      // =================================================
      // STEP 1:
      // GET CITY COORDINATES
      // =================================================

      final geoUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search'
            '?name=${Uri.encodeComponent(city)}'
            '&count=1'
            '&language=en'
            '&format=json',
      );

      final geoResponse =
      await http.get(geoUrl);

      if (geoResponse.statusCode != 200) {
        throw Exception(
          'Unable to find location.',
        );
      }

      final geoData =
      jsonDecode(geoResponse.body);

      if (geoData['results'] == null ||
          geoData['results'].isEmpty) {
        throw Exception(
          'City not found. Please try another city.',
        );
      }

      final location =
      geoData['results'][0];

      final double latitude =
      (location['latitude'] as num)
          .toDouble();

      final double longitude =
      (location['longitude'] as num)
          .toDouble();

      final String foundCity =
          location['name'] ?? city;

      // =================================================
      // STEP 2:
      // GET WEATHER DATA
      // =================================================

      final weatherUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
            '?latitude=$latitude'
            '&longitude=$longitude'
            '&current=temperature_2m,weather_code'
            '&temperature_unit=celsius',
      );

      final weatherResponse =
      await http.get(weatherUrl);

      if (weatherResponse.statusCode != 200) {
        throw Exception(
          'Unable to fetch weather data.',
        );
      }

      final weatherData =
      jsonDecode(weatherResponse.body);

      final current =
      weatherData['current'];

      final double currentTemperature =
      (current['temperature_2m'] as num)
          .toDouble();

      final int currentWeatherCode =
      current['weather_code'] as int;

      // =================================================
      // STEP 3:
      // UPDATE UI
      // =================================================

      if (!mounted) return;

      setState(() {

        cityName = foundCity;

        temperature =
            currentTemperature;

        weatherCode =
            currentWeatherCode;

        weatherCondition =
            getWeatherCondition(
              currentWeatherCode,
            );

        isLoading = false;
      });

    } catch (e) {

      if (!mounted) return;

      setState(() {

        isLoading = false;

        errorMessage =
            e.toString()
                .replaceFirst(
              'Exception: ',
              '',
            );
      });
    }
  }

  // ===================================================
  // DISPOSE
  // ===================================================

  @override
  void dispose() {
    cityController.dispose();

    super.dispose();
  }

  // ===================================================
  // BUILD
  // ===================================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,

            children: [

              // =========================================
              // HEADER
              // =========================================

              const Icon(
                Icons.cloud,
                size: 90,
                color: Colors.blue,
              ),

              const SizedBox(height: 10),

              const Text(
                'Check Current Weather',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Enter a city to get live weather data.',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 25),

              // =========================================
              // SEARCH FIELD
              // =========================================

              TextField(
                controller: cityController,

                textInputAction:
                TextInputAction.search,

                onSubmitted: (_) {
                  fetchWeather();
                },

                decoration: InputDecoration(
                  labelText: 'City Name',

                  hintText:
                  'Example: Delhi',

                  prefixIcon: const Icon(
                    Icons.location_city,
                  ),

                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),

                  suffixIcon: IconButton(
                    onPressed:
                    fetchWeather,

                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // =========================================
              // SEARCH BUTTON
              // =========================================

              SizedBox(
                height: 52,

                child: ElevatedButton.icon(

                  onPressed:
                  isLoading
                      ? null
                      : fetchWeather,

                  icon: isLoading

                      ? const SizedBox(
                    width: 20,
                    height: 20,

                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )

                      : const Icon(
                    Icons.cloud,
                  ),

                  label: Text(
                    isLoading
                        ? 'Loading...'
                        : 'Get Weather',
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // =========================================
              // ERROR MESSAGE
              // =========================================

              if (errorMessage != null)
                Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color:
                    Colors.red.shade50,

                    borderRadius:
                    BorderRadius.circular(15),

                    border: Border.all(
                      color:
                      Colors.red.shade200,
                    ),
                  ),

                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Icon(
                        Icons.error_outline,
                        color:
                        Colors.red.shade700,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          errorMessage!,

                          style: TextStyle(
                            color:
                            Colors.red.shade700,

                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // =========================================
              // WEATHER RESULT
              // =========================================

              if (cityName != null &&
                  temperature != null &&
                  weatherCode != null)
                WeatherCard(
                  cityName: cityName!,
                  temperature: temperature!,
                  condition: weatherCondition,
                  weatherIcon:
                  getWeatherIcon(
                    weatherCode!,
                  ),
                ),

              // =========================================
              // INFORMATION
              // =========================================

              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding:
                  const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      const Row(
                        children: [

                          Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                          ),

                          SizedBox(width: 8),

                          Text(
                            'About this app',

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'This app fetches current weather '
                            'information from a public weather API '
                            'and updates the UI dynamically.',
                        style: TextStyle(
                          color:
                          Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// WEATHER CARD
// =====================================================

class WeatherCard extends StatelessWidget {

  final String cityName;
  final double temperature;
  final String condition;
  final IconData weatherIcon;

  const WeatherCard({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin:
      const EdgeInsets.only(top: 25),

      padding:
      const EdgeInsets.all(25),

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(25),

        gradient: LinearGradient(
          colors: [
            Colors.blue.shade400,
            Colors.blue.shade700,
          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 5),
            color: Colors.black26,
          ),
        ],
      ),

      child: Column(
        children: [

          // Location
          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.location_on,
                color: Colors.white,
              ),

              const SizedBox(width: 5),

              Flexible(
                child: Text(
                  cityName,

                  textAlign: TextAlign.center,

                  overflow:
                  TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Weather icon
          Icon(
            weatherIcon,
            size: 100,
            color: Colors.white,
          ),

          const SizedBox(height: 15),

          // Temperature
          Text(
            '${temperature.toStringAsFixed(1)}°C',

            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Condition
          Text(
            condition,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Current Temperature',

            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}