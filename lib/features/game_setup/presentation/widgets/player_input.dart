import 'package:flutter/material.dart';

import '../../../../core/theme/appColors.dart';
import '../../../../core/widgets/appTextField.dart';

class PlayerInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  final bool enabled;

  const PlayerInput({
    super.key,
    required this.controller,
    required this.onAdd,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Apptextfield(
            hintText: 'اسم اللاعب',
            obscureText: false,
            controller: controller,
            keyboardType: TextInputType.text,
          ),
        ),

        const SizedBox(width: 10),

        IconButton(
          onPressed: enabled ? onAdd : null,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}