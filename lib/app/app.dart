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
      home: const Scaffold(
        body: Center(
          child: Text(
            'AbelhIFMA',
          ),
        ),
      ),
    );
  }
}