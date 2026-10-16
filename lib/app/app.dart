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
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/backgrounds/favos.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SafeArea(
              child: Center(
                child: Text('AbelhIFMA'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}