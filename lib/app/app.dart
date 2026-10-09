import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

class AbelhIFMA extends StatelessWidget {
  const AbelhIFMA({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AbelhIFMA',
      theme: AppTheme.light,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/favos.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const SafeArea(
            child: Center(
              child: Text(
                'AbelhIFMA',
              ),
            ),
          ),
        ),
      ),
    );
  }
}