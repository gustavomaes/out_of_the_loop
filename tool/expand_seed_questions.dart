// Deprecated entry point; use regenerate_seed_content.dart instead.
// Delegates to the same source so old expansion cannot restore generic prompts
// or embed the secret word in questions.
import 'regenerate_seed_content.dart' as regenerate;

void main() => regenerate.main();
