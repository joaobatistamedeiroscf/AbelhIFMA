import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import 'theme/app_theme.dart';

class AbelhIFMA extends StatelessWidget {
  const AbelhIFMA({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AbelhIFMA',
    theme: AppTheme.light,
    home: const LoginScreen(),
  );
}
