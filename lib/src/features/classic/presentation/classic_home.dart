import 'package:flutter/material.dart';
import '../../../data/classic/classic_content_repository.dart';
import '../../../domain/classic/classic_models.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/classic_controller.dart';
import '../../premium/premium_access.dart';
import '../../premium/premium_sheet.dart';
import '../../../data/purchases/purchase_gateway.dart';
import 'classic_components.dart';
import 'classic_round_screen.dart';

class ClassicHome extends StatefulWidget {
  const ClassicHome({super.key, this.controller, this.premium});
  final ClassicController? controller;
  final PremiumAccess? premium;
  @override
  State<ClassicHome> createState() => _ClassicHomeState();
}

class _ClassicHomeState extends State<ClassicHome> {
  late final controller =
      widget.controller ??
      ClassicController(
        content: const ClassicContentRepository(),
        config: ClassicConfig(
          players: const [
            ClassicPlayer(id: '1', name: 'Alex'),
            ClassicPlayer(id: '2', name: 'Sam'),
            ClassicPlayer(id: '3', name: 'Robin'),
          ],
          categoryIds: {'food', 'animals', 'sports'},
        ),
      );
  late final premium =
      widget.premium ??
      PremiumAccess(gateway: RevenueCatPurchaseGateway(), entitlement: '');
  late int lastMinutes = controller.config.timerMinutes ?? 3;
  AppLocalizations get l => AppLocalizations.of(context)!;
  ClassicConfig get config => controller.config;
  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    if (widget.premium == null) premium.dispose();
    super.dispose();
  }

  Future<void> showPremium() => showClassicSheet(
    context,
    title: l.classicPremium,
    child: PremiumSheet(access: premium),
  );

  Future<void> editNames() async {
    final players = await showModalBottomSheet<List<ClassicPlayer>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _NamesSheet(players: config.players),
    );
    if (players == null || !mounted) return;
    // A smaller group may invalidate a previous manual selection.
    final maximum = ((players.length - 1) ~/ 2).clamp(1, 6);
    controller.updateConfig(
      config.copyWith(
        players: players,
        manualImpostors: config.manualImpostors?.clamp(1, maximum),
      ),
    );
  }

  Future<void> categories() async {
    final draft = config.categoryIds.toSet();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, refresh) => ListenableBuilder(
          listenable: premium,
          builder: (context, _) => _ConfigSheet(
            title: l.classicCategories,
            footer: ClassicButton(
              label: l.classicConfirm,
              onPressed: draft.isEmpty
                  ? null
                  : () {
                      controller.updateConfig(
                        config.copyWith(categoryIds: draft),
                      );
                      Navigator.pop(sheetContext);
                    },
            ),
            children: [
              Text(l.classicEnglish),
              Wrap(
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: () => refresh(() {
                      draft
                        ..clear()
                        ..addAll(
                          classicCategories
                              .where(
                                (c) => premium.allows(c.id, free: !c.premium),
                              )
                              .map((c) => c.id),
                        );
                    }),
                    child: Text(
                      premium.enabled
                          ? l.classicSelectAll
                          : l.classicSelectFree,
                    ),
                  ),
                  TextButton(
                    onPressed: () => refresh(draft.clear),
                    child: Text(l.classicClear),
                  ),
                ],
              ),
              for (final category in classicCategories)
                CheckboxListTile(
                  key: ValueKey('category-${category.id}'),
                  contentPadding: EdgeInsets.zero,
                  title: Text('${category.emoji} ${category.name}'),
                  secondary:
                      !premium.allows(category.id, free: !category.premium)
                      ? const Icon(Icons.lock_outline)
                      : null,
                  value: draft.contains(category.id),
                  onChanged: (selected) async {
                    if (!premium.allows(category.id, free: !category.premium)) {
                      await showPremium();
                      if (!mounted || !sheetContext.mounted) return;
                      // The sheet remains mounted, retaining draft and scroll.
                      if (premium.allows(
                        category.id,
                        free: !category.premium,
                      )) {
                        refresh(() => draft.add(category.id));
                      }
                      return;
                    }
                    refresh(
                      () => selected!
                          ? draft.add(category.id)
                          : draft.remove(category.id),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> impostors() async {
    int? draft = config.manualImpostors;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, refresh) => _ConfigSheet(
          title: l.classicImpostors,
          footer: ClassicButton(
            label: l.classicDone,
            onPressed: () {
              controller.updateConfig(
                config.copyWith(
                  manualImpostors: draft,
                  autoImpostors: draft == null,
                ),
              );
              Navigator.pop(sheetContext);
            },
          ),
          children: [
            for (final value in [
              null,
              ...List.generate(config.maximumImpostors, (i) => i + 1),
            ])
              ListTile(
                title: Text(value == null ? l.classicAuto : '$value'),
                trailing: value == draft ? const Icon(Icons.check) : null,
                onTap: () => refresh(() => draft = value),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> duration() => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (sheetContext) => StatefulBuilder(
      builder: (context, refresh) => _ConfigSheet(
        title: l.classicDuration,
        footer: ClassicButton(
          label: l.classicDone,
          onPressed: () => Navigator.pop(sheetContext),
        ),
        children: [
          for (var i = 1; i <= 10; i++)
            ListTile(
              title: Text('$i ${l.classicMinutes}'),
              trailing: i == config.timerMinutes
                  ? const Icon(Icons.check)
                  : null,
              onTap: () => refresh(() {
                lastMinutes = i;
                controller.updateConfig(config.copyWith(timerMinutes: i));
              }),
            ),
        ],
      ),
    ),
  );

  Widget option(String title, String value, VoidCallback onTap, {Key? key}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ClassicCard(
          child: Material(
            type: MaterialType.transparency,
            child: ListTile(
              key: key,
              contentPadding: EdgeInsets.zero,
              title: Text(title),
              subtitle: Text(value),
              trailing: const Icon(Icons.chevron_right),
              onTap: onTap,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: Listenable.merge([controller, premium]),
    builder: (context, _) => controller.phase != ClassicPhase.home
        ? ClassicRoundScreen(
            controller: controller,
            onPremium: premium.enabled ? null : showPremium,
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Classic'),
              actions: [
                IconButton(
                  tooltip: l.classicHelp,
                  icon: const Icon(Icons.help_outline),
                  onPressed: () => showClassicSheet(
                    context,
                    title: l.classicHelp,
                    child: Text(l.classicHelpSteps),
                  ),
                ),
                IconButton(
                  tooltip: l.classicSettings,
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => showClassicSheet(
                    context,
                    title: l.classicSettings,
                    child: Column(
                      children: [
                        ClassicButton(
                          label: l.classicResetHistory,
                          onPressed: () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(l.classicResetHistory),
                                content: Text(l.classicResetHistoryBody),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text(l.classicCancel),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text(l.classicConfirm),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed == true) controller.resetHistory();
                          },
                        ),
                        ClassicButton(
                          label: l.classicPremium,
                          onPressed: showPremium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // The transparent dock takes its actual height in the layout, including
            // large text and safe area. Every scroll action can move above it.
            bottomNavigationBar: SafeArea(
              top: false,
              child: Padding(
                key: const Key('classic-dock'),
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!premium.enabled) ...[
                      ClassicButton(
                        label: l.classicPremium,
                        onPressed: showPremium,
                      ),
                      const SizedBox(height: 8),
                    ],
                    ClassicButton(
                      label: l.classicStart,
                      onPressed: () {
                        if (!controller.start() &&
                            controller.phase == ClassicPhase.home) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                controller.accessAdjusted
                                    ? 'Access changed. Selection updated; tap again to continue.'
                                    : l.classicContentMissing,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              bottom: false,
              child: ListView(
                key: const Key('classic-home-scroll'),
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    l.classicTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(l.classicSubtitle),
                  const SizedBox(height: 20),
                  option(
                    '👥 ${l.classicCrew}',
                    '${config.players.length} · ${l.classicNames}',
                    editNames,
                    key: const Key('edit-names'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClassicCard(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          key: const Key('edit-categories'),
                          onTap: categories,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '🗂️ ${l.classicCategories}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  if (config.categoryIds.length ==
                                      classicCategories.length)
                                    Chip(label: Text(l.classicAll))
                                  else
                                    for (final category
                                        in classicCategories.where(
                                          (c) =>
                                              config.categoryIds.contains(c.id),
                                        ))
                                      Chip(
                                        label: Text(
                                          '${category.emoji} ${category.name}',
                                        ),
                                      ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  option(
                    '🥷 ${l.classicImpostors}',
                    config.manualImpostors == null
                        ? '${l.classicAuto} · ${config.impostors}'
                        : '${config.impostors}',
                    impostors,
                    key: const Key('edit-impostors'),
                  ),
                  ClassicSwitch(
                    label: '💡 ${l.classicHint}',
                    value: config.hint,
                    onChanged: (v) =>
                        controller.updateConfig(config.copyWith(hint: v)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          key: const Key('edit-duration'),
                          contentPadding: EdgeInsets.zero,
                          title: Text('⏱️ ${l.classicTimer}'),
                          subtitle: Text(
                            config.timerMinutes == null
                                ? l.classicOff
                                : '${config.timerMinutes} ${l.classicMinutes}',
                          ),
                          onTap: config.timerMinutes == null ? null : duration,
                        ),
                      ),
                      Semantics(
                        label: l.classicTimer,
                        child: Switch(
                          key: const Key('timer-switch'),
                          value: config.timerMinutes != null,
                          onChanged: (v) {
                            controller.updateConfig(
                              config.copyWith(
                                timerMinutes: lastMinutes,
                                timerOff: !v,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ClassicSwitch(
                    label: '😈 ${l.classicTroll}',
                    value: config.troll,
                    onChanged: (v) =>
                        controller.updateConfig(config.copyWith(troll: v)),
                  ),
                  TextButton(onPressed: null, child: Text(l.classicShare)),
                  TextButton(
                    key: const Key('classic-last-action'),
                    onPressed: null,
                    child: Text(l.classicRate),
                  ),
                  Text(l.classicFooter, key: const Key('classic-footer')),
                  const SizedBox(height: 16),
                  Text(l.classicDemoNotice),
                ],
              ),
            ),
          ),
  );
}

/// Bounded scrolling body with actions independent from both scroll and keyboard.
class _ConfigSheet extends StatelessWidget {
  const _ConfigSheet({
    required this.title,
    required this.children,
    required this.footer,
  });
  final String title;
  final List<Widget> children;
  final Widget footer;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: SafeArea(
      top: false,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(title, style: Theme.of(context).textTheme.titleLarge),
              trailing: IconButton(
                tooltip: AppLocalizations.of(context)!.classicClose,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: children,
              ),
            ),
            Padding(padding: const EdgeInsets.all(16), child: footer),
          ],
        ),
      ),
    ),
  );
}

class _NamesSheet extends StatefulWidget {
  const _NamesSheet({required this.players});
  final List<ClassicPlayer> players;
  @override
  State<_NamesSheet> createState() => _NamesSheetState();
}

class _NamesSheetState extends State<_NamesSheet> {
  late final fields = [
    for (final p in widget.players) TextEditingController(text: p.name),
  ];
  late final ids = widget.players.map((p) => p.id).toList();
  int nextId = 0;
  @override
  void dispose() {
    for (final field in fields) {
      field.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return _ConfigSheet(
      title: '${l.classicNames} · ${fields.length}/20',
      footer: ClassicButton(
        label: l.classicSave,
        onPressed: () {
          final players = [
            for (var i = 0; i < fields.length; i++)
              ClassicPlayer(
                id: ids[i],
                name: fields[i].text.trim().isEmpty
                    ? '${l.classicPlayer} ${i + 1}'
                    : fields[i].text.trim(),
              ),
          ];
          Navigator.pop(context, players);
        },
      ),
      children: [
        for (var i = 0; i < fields.length; i++)
          Row(
            key: ValueKey(ids[i]),
            children: [
              Expanded(
                child: TextField(
                  key: ValueKey('name-${ids[i]}'),
                  controller: fields[i],
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: '${l.classicPlayer} ${i + 1}',
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              IconButton(
                tooltip: l.classicRemove,
                onPressed: fields.length <= 3
                    ? null
                    : () {
                        final removed = fields[i];
                        setState(() {
                          fields.removeAt(i);
                          ids.removeAt(i);
                        });
                        // The old TextField must unmount before its controller is disposed.
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) => removed.dispose(),
                        );
                      },
                icon: const Icon(Icons.remove_circle_outline),
              ),
            ],
          ),
        TextButton(
          onPressed: fields.length >= 20
              ? null
              : () => setState(() {
                  String id;
                  do {
                    id = 'new-${nextId++}';
                  } while (ids.contains(id));
                  ids.add(id);
                  fields.add(TextEditingController());
                }),
          child: Text(l.classicAdd),
        ),
      ],
    );
  }
}
