import 'package:flutter/material.dart';
// 1. استيراد الملف الجديد
import 'features/auth/register_screen.dart';

void main() {
  runApp(const BasmaApp());
}

class BasmaApp extends StatelessWidget {
  const BasmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // 2. تعيين الشاشة الجديدة كصفحة رئيسية
      home: RegisterScreen(), 
    );
  }
}