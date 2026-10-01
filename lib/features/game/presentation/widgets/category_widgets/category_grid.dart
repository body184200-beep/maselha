import 'package:flutter/material.dart';

import '../../../data/models/category_model.dart';
import 'category_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  const CategoryGrid({
    super.key,
    required this.categories,
    required this.selectedIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (_, i) => CategoryCard(
        category: categories[i],
        isSelected: selectedIds.contains(categories[i].id),
        onTap: () => onToggle(categories[i].id),
      ),
    );
  }
}