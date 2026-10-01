import 'package:flutter/material.dart';

import '../../../../../core/theme/appColors.dart';

class ReadyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Back is allowed only before the game starts. Once a turn has been
  /// played, going back would land on the setup screens mid-game.
  final bool showBack;

  const ReadyAppBar({super.key, required this.showBack});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.white,
        ),
        onPressed: () => Navigator.pop(context),
      )
          : null,
    );
  }
}