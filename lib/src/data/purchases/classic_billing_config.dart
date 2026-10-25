import 'dart:convert';

/// No implicit lifetime/category mapping. Supply only audited SDK entitlement IDs.
Map<String, Set<String>> classicLegacyRights(String source) {
  try {
    final data = jsonDecode(source) as Map<String, dynamic>;
    return {
      for (final entry in data.entries)
        if (entry.key.isNotEmpty &&
            entry.value is List &&
            (entry.value as List).every((id) => id is String))
          entry.key: (entry.value as List).cast<String>().toSet(),
    };
  } on Object {
    return const {};
  }
}

String? purchaseEntitlement({
  required String packageId,
  required String productId,
  required Map<String, String> subscriptions,
  required Map<String, String> packages,
}) => subscriptions[productId] ?? packages[packageId];
