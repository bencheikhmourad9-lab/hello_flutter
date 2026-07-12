// lib/core/models/charity_case_model.dart
import 'package:flutter/material.dart';

class CharityCase {
  final String id;
  final String type;
  final String typeName;
  final String title;
  final String description;
  final String location;
  final IconData icon;
  final String status;
  final double target;
  final double current;

  CharityCase({
    required this.id,
    required this.type,
    required this.typeName,
    required this.title,
    required this.description,
    required this.location,
    required this.icon,
    required this.status,
    required this.target,
    required this.current,
  });
}
// أضف هذه الدوال داخل كلاس CharityCase
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'type': type,
    'typeName': typeName,
    'title': title,
    'description': description,
    'location': location,
    'status': status,
    'target': target,
    'current': current,
  };
}

// دالة مساعدة لإعادة بناء الكائن من البيانات المخزنة
factory CharityCase.fromJson(Map<String, dynamic> json) {
  return CharityCase(
    id: json['id'],
    type: json['type'],
    typeName: json['typeName'],
    title: json['title'],
    description: json['description'],
    location: json['location'],
    status: json['status'],
    target: json['target'],
    current: json['current'],
    icon: _getIconByType(json['type']), // سنستخدم دالة مساعدة للأيقونة
  );
}

// دالة تعيد الأيقونة بناءً على النوع
static IconData _getIconByType(String type) {
  switch (type) {
    case 'PROTECTION_MISSING': return Icons.security;
    case 'FATWA_ASK': return Icons.gavel;
    case 'MOSQUE_SEASONAL': return Icons.mosque;
    case 'ECONOMIC_SUPPORT': return Icons.work;
    case 'MEDICAL_URGENT': return Icons.local_hospital;
    default: return Icons.help;
  }
}
// داخل كلاس CharityCase
String get shortHint {
  switch (this.type) {
    case 'MEDICAL_URGENT': return 'تشمل تأمين الأدوية، الأجهزة الطبية مستعجلة، وتجهيز شؤون الجنائز للأسر المعوزة.';
    case 'ECONOMIC_SUPPORT': return 'تشمل قفف مؤونة، مشاريع مصغرة، آلات خياطة، وتأهيل مهني للأسر المعوزة.';
    case 'MOSQUE_SEASONAL': return 'تشمل فرش وترميم المساجد بالقرى ومناطق الظل، وتجهيز مطاعم عابري السبيل.';
    case 'FATWA_ASK': return 'إرسال مجهول الهوية للجنة الأئمة للحصول على تكييف فقهي تضامني دقيق.';
    case 'PROTECTION_MISSING': return 'تنسيق محمي بالكامل لحالات ضياع الوثائق، غياب الهوية، أو نداءات المفقودين.';
    default: return '';
  }
}
// أضف هذه الـ Getters داخل كلاس CharityCase
String get typeName {
  switch (this.type) {
    case 'MEDICAL_URGENT': return 'حالة طبية مستعجلة';
    case 'ECONOMIC_SUPPORT': return 'تمكين واقتصاد عيني';
    case 'MOSQUE_SEASONAL': return 'إعمار ومطاعم رحمة';
    case 'FATWA_ASK': return 'استشارة شرعية';
    default: return 'حالة خاصة / مفقودين';
  }
}

IconData get icon {
  switch (this.type) {
    case 'MEDICAL_URGENT': return Icons.local_hospital;
    case 'ECONOMIC_SUPPORT': return Icons.work;
    case 'MOSQUE_SEASONAL': return Icons.mosque;
    case 'FATWA_ASK': return Icons.gavel;
    default: return Icons.security;
  }
}