// lib/features/home/data/cases_repository.dart
import 'package:flutter/material.dart';
import '../../../../core/models/charity_case_model.dart';

class CasesRepository {
  static final List<CharityCase> allCases = [
    CharityCase(
      id: '255001',
      type: 'PROTECTION_MISSING',
      typeName: 'حالة خاصة / مفقودين',
      title: 'نداء إنساني سري: حالة بحث وتنسيق هوية (مفقودين / مجهولي النسب)',
      description: 'تتكفل الجمعية بمرافقة حالة إنسانية خاصة لربط وتدقيق معطيات نسب وهويات غائبة بالتنسيق مع المصالح القانونية المختصة.',
      location: '25- قسنطينة',
      icon: Icons.security,
      status: 'مثبتة',
      target: 0,
      current: 0,
    ),
    CharityCase(
      id: '553003',
      type: 'MOSQUE_SEASONAL',
      typeName: 'إعمار ومطاعم رحمة',
      title: 'مشروع تجهيز وتفريش مسجد قيد الإنشاء وبث مطعم رحمة',
      description: 'مسجد في منطقة ظل يحتاج إلى تفريش سجاد صلاة ودعم مطبخ الوجبات الساخنة.',
      location: '55- تقرت',
      icon: Icons.mosque,
      status: 'مثبتة',
      target: 500000,
      current: 350000,
    ),
    // يمكنك إضافة بقية الحالات بنفس الطريقة هنا
  ];
}