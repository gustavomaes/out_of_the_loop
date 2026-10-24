import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/models/models.dart';
import 'local_content_repository.dart';

class GameNightPack {
  const GameNightPack({
    required this.id,
    required this.description,
    required this.content,
  });
  final String id;
  final String description;
  final ContentCategory content;
  Category get category => content.category;
  String get title => category.name.valueFor(SupportedLanguage.en);
}

class UsPackCatalog {
  UsPackCatalog({this.seedJson});
  final String? seedJson;
  static const bundleId = 'game_night_collection';
  static const contentVersion = 'us-1';
  static const ids = ['us_backyard', 'us_roadtrip', 'us_holidays'];
  List<GameNightPack>? _cache;
  Future<List<GameNightPack>> load() async {
    if (_cache != null) return _cache!;
    final data =
        jsonDecode(
              seedJson ??
                  await rootBundle.loadString(
                    'assets/content/us_game_night.json',
                  ),
            )
            as Map<String, dynamic>;
    final seed = ContentSeed.fromJson(data);
    final raw = (data['categories'] as List).cast<Map<String, dynamic>>();
    return _cache = List.unmodifiable(
      seed.categories.map(
        (c) => GameNightPack(
          id: c.category.id,
          content: c,
          description:
              raw.firstWhere(
                    (item) => item['id'] == c.category.id,
                  )['description']
                  as String,
        ),
      ),
    );
  }

  Future<GameNightPack?> find(String id) async {
    for (final pack in await load()) {
      if (pack.id == id) return pack;
    }
    return null;
  }
}
