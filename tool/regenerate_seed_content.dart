// Regenerates both banks from word-specific localized situations.
// Run from any directory. Requires Python 3; no translation service is used.
import 'dart:io';

void main() {
  final root = File.fromUri(Platform.script).parent.parent.path;
  final result = Process.runSync('python3', [
    'tool/rewrite_content.py',
  ], workingDirectory: root);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exitCode = result.exitCode;
}
