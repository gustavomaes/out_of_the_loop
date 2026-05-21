/// Firebase Analytics event and parameter names.
abstract final class AnalyticsEvents {
  static const selectCategory = 'select_category';
  static const configureMatch = 'configure_match';
  static const startMatch = 'start_match';
  static const completeVoting = 'complete_voting';
  static const submitGuess = 'submit_guess';
  static const completeRound = 'complete_round';
  static const cancelMatch = 'cancel_match';
  static const matchFinished = 'match_finished';
  static const rematchStarted = 'rematch_started';
  static const changeSetting = 'change_setting';

  static const categoryId = 'category_id';
  static const playerCount = 'player_count';
  static const roundCount = 'round_count';
  static const questionsPerPlayer = 'questions_per_player';
  static const language = 'language';
  static const roundNumber = 'round_number';
  static const outFoundMajority = 'out_found_majority';
  static const guessCorrect = 'guess_correct';
  static const isMatchEnd = 'is_match_end';
  static const rematchType = 'rematch_type';
  static const settingName = 'setting_name';
  static const settingValue = 'setting_value';

  static const rematchTypeKeepCategory = 'keep_category';
  static const rematchTypeChangeCategory = 'change_category';

  static const settingLanguage = 'language';
  static const settingMusicEnabled = 'music_enabled';
  static const settingSoundEffectsEnabled = 'sound_effects_enabled';
}
