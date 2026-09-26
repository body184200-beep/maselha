import 'package:flutter/material.dart';
import 'package:maselha/core/widgets/appButton.dart';

import '../../../../core/theme/appColors.dart';
import 'TeamSetup_screen.dart';

class TeamcountScreen extends StatefulWidget {
  const TeamcountScreen({super.key});

  @override
  State<TeamcountScreen> createState() => _TeamcountScreenState();
}

class _TeamcountScreenState extends State<TeamcountScreen> {
  int counter = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.groups_rounded,
                size: 70,
                color: AppColors.secondary,
              ),

              const SizedBox(height: 24),

              const Text(
                'إعداد اللعبة',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightGray,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'كام فريق هيلعب؟',
                style: TextStyle(fontSize: 17, color: AppColors.orange),
              ),

              const SizedBox(height: 35),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$counter',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: counter > 2
                        ? () {
                            setState(() {
                              counter--;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.remove, color: AppColors.white),
                    iconSize: 30,
                  ),

                  const SizedBox(width: 40),

                  IconButton(
                    onPressed: counter < 10
                        ? () {
                            setState(() {
                              counter++;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.add, color: AppColors.white),
                    iconSize: 30,
                  ),
                ],
              ),

              const SizedBox(height: 35),

              AppButton(text: 'التالي', onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamsetupScreen(teamCount: counter)),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
