import 'package:flutter/material.dart';

IconData categoryIconFor(String? iconKey) {
  return switch (iconKey) {
    'restaurant' => Icons.restaurant,
    'movies' => Icons.movie_creation_outlined,
    'sports' => Icons.sports_basketball,
    'music_note' => Icons.music_note_outlined,
    'flight' => Icons.flight,
    'pets' => Icons.pets,
    'work' => Icons.work_outline,
    'place' => Icons.place_outlined,
    'category' => Icons.category_outlined,
    'park' => Icons.park_outlined,
    'devices' => Icons.devices,
    'sports_esports' => Icons.sports_esports_outlined,
    'school' => Icons.school_outlined,
    'celebration' => Icons.celebration_outlined,
    'checkroom' => Icons.checkroom_outlined,
    'health_and_safety' => Icons.health_and_safety_outlined,
    'home' => Icons.home_outlined,
    'directions_car' => Icons.directions_car_outlined,
    'auto_fix_high' => Icons.auto_fix_high_outlined,
    'mood' => Icons.mood_outlined,
    _ => Icons.category_outlined,
  };
}

Color contrastingForeground(Color background) {
  return background.computeLuminance() > 0.55 ? Colors.black : Colors.white;
}
