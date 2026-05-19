import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_shell.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../theme/app_tokens.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({this.onDone, super.key});

  final VoidCallback? onDone;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      routeName: AppRoutes.howToPlay,
      title: 'How To Play',
      child: ListView(
        children: [
          Text('COMO JOGAR', style: AppTypography.emphasis),
          const SizedBox(height: AppSpacing.xs),
          const Text('Como Jogar', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Descubra quem esta fora do circulo antes que essa pessoa entenda a palavra secreta.',
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.lg),
          const _RuleCard(
            icon: Icons.lock_outline,
            title: 'O SEGREDO',
            body:
                'Um jogador esta fora do loop. Todos os outros recebem a mesma palavra secreta.',
            accented: true,
          ),
          const _RuleCard(
            icon: Icons.question_answer_outlined,
            title: 'A PERGUNTA',
            body:
                'Cada jogador responde em voz alta uma pergunta sobre a palavra sem revelar demais.',
          ),
          const _RuleCard(
            icon: Icons.how_to_vote_outlined,
            title: 'A VOTACAO',
            body:
                'Cada pessoa vota secretamente em quem acredita estar fora. Maioria significa mais da metade dos jogadores.',
          ),
          const _RuleCard(
            icon: Icons.emoji_events_outlined,
            title: 'O DESFECHO',
            body:
                'Votos corretos valem 25 pontos. Se a maioria acha o fora, os de dentro ganham 100. Se nao, o fora ganha 50 e pode tentar adivinhar a palavra por mais 125.',
          ),
          const SizedBox(height: AppSpacing.lg),
          OtlButton.primary(
            label: 'ENTENDI',
            onPressed: onDone ?? () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  const _RuleCard({
    required this.icon,
    required this.title,
    required this.body,
    this.accented = false,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool accented;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: OtlCard(
        accented: accented,
        accentColor: AppColors.secondaryMain,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: accented ? AppColors.secondaryMain : AppColors.primaryMain,
              size: 32,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.h3),
                  const SizedBox(height: AppSpacing.xs),
                  Text(body, style: AppTypography.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
