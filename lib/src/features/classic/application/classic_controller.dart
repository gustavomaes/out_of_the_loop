import 'package:flutter/foundation.dart';
import '../../../domain/classic/classic_models.dart';
import '../../../data/classic/classic_content_repository.dart';

/// Configuration only. Round creation arrives in stage three.
class ClassicController extends ChangeNotifier {
  ClassicController({required this.content, required ClassicConfig config})
    : _config = config;
  final ClassicContentRepository content;
  ClassicConfig _config;
  ClassicConfig get config => _config;
  ClassicPhase get phase => ClassicPhase.home;
  bool updateConfig(ClassicConfig candidate) {
    if (!candidate.isValid ||
        candidate.categoryIds.any(
          (id) => !classicCategories.any((c) => c.id == id),
        ) ||
        candidate.contentLanguage != 'en') {
      return false;
    }
    _config = candidate;
    notifyListeners();
    return true;
  }
}
