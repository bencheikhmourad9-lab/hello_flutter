import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../../core/models/charity_case_model.dart';
import '../data/cases_repository.dart';

class HomeController extends ChangeNotifier {
  // الحالة الحالية (State)
  List<CharityCase> _cases = CasesRepository.allCases;
  
  String selectedFilterWilaya = 'الكل';
  String selectedFilterType = 'الكل';
  TextEditingController searchController = TextEditingController();

  // الفلترة الذكية
  List<CharityCase> get filteredCases {
    return _cases.where((c) {
      bool matchWilaya = selectedFilterWilaya == 'الكل' || c.location == selectedFilterWilaya;
      bool matchType = selectedFilterType == 'الكل' || c.type == selectedFilterType;
      
      String query = searchController.text.toLowerCase();
      bool matchSearch = query.isEmpty || 
                         c.title.toLowerCase().contains(query) || 
                         c.description.toLowerCase().contains(query);
      
      return matchWilaya && matchType && matchSearch;
    }).toList();
  }

  // النسخ الاحتياطي
  void backupData(BuildContext context) {
    String jsonOutput = jsonEncode(_cases.map((c) => c.toJson()).toList());
    Clipboard.setData(ClipboardData(text: jsonOutput));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📥 تم النسخ للحافظة!')));
  }

  // الاسترجاع
  void restoreData(String jsonStr, BuildContext context) {
    try {
      List<dynamic> decodedList = jsonDecode(jsonStr);
      _cases = decodedList.map((item) => CharityCase.fromJson(item)).toList();
      notifyListeners(); // تحديث الواجهة تلقائياً
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ تم الاسترجاع!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('❌ خطأ في البيانات')));
    }
  }
}
// أضف هذه الدوال داخل كلاس HomeController

void notifyExistingVerifiedCases() {
  debugPrint("تمت مطابقة نطاق التنبيهات الجغرافية للمحسن على ولاية: $donorWilaya");
}

void addNewCase(String title, String desc, String type, String location) {
  if (title.trim().isEmpty || desc.trim().isEmpty) return;
  
  // قم بإضافة الكائن الجديد لقائمة الـ _cases الموجودة في الـ Controller
  _cases.insert(0, CharityCase(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    type: type,
    // (بقية المتغيرات هنا...)
  ));
  notifyListeners(); // هذا السطر يخبر الواجهة أن البيانات تغيرت
}

void openChatRoom(CharityCase item) {
  activeChatCase = item;
  chatMessages.clear();
  chatMessages.add({
    'sender': 'system',
    'text': 'مرحباً بك في القناة الآمنة...',
    'time': ''
  });
  notifyListeners();
}
void _sendMessage() {
    if (_chatMessageController.text.trim().isEmpty) return;
    setState(() {
      _chatMessages.add({
        'sender': 'me',
        'text': _chatMessageController.text.trim(),
        'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      });
      _chatMessageController.clear();
    });
  }
