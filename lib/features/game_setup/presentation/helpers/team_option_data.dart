import 'package:flutter/material.dart';

class TeamOptionData {
  final int count;
  final String title;
  final String subtitle;
  final IconData icon;

  const TeamOptionData({
    required this.count,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

const List<TeamOptionData> teamOptions = [
  TeamOptionData(
    count: 2,
    title: '2 فرق',
    subtitle: 'مواجهة ثنائية حماسية (فريق ضد فريق)',
    icon: Icons.people_outline_rounded,
  ),
  TeamOptionData(
    count: 3,
    title: '3 فرق',
    subtitle: 'تحدي ثلاثي مشتعل للمجموعات',
    icon: Icons.groups_outlined,
  ),
  TeamOptionData(
    count: 4,
    title: '4 فرق',
    subtitle: 'بطولة كاملة وتنافس قوي',
    icon: Icons.diversity_3_rounded,
  ),
];