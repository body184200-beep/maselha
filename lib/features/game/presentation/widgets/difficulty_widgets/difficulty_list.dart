import 'package:flutter/material.dart';

import '../../../data/models/difficulty_model.dart';
import 'difficulty_card.dart';

class DifficultyList extends StatelessWidget {
  final List<DifficultyModel> difficulties;
  final DifficultyModel? selected;
  final ValueChanged<DifficultyModel> onSelect;

  const DifficultyList({
    super.key,
    required this.difficulties,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: difficulties.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => DifficultyCard(
        difficulty: difficulties[i],
        isSelected: selected?.id == difficulties[i].id,
        onTap: () => onSelect(difficulties[i]),
      ),
    );
  }
}