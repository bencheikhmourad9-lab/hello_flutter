import 'package:flutter/material.dart';
import '../logic/home_controller.dart'; // مسار الـ Controller
import '../../../core/models/charity_case_model.dart'; // مسار الموديل

// في أعلى الملف
import 'package:hello_flutter/features/home/widgets/safe_chat_overlay.dart';
import 'package:hello_flutter/features/home/widgets/case_card.dart';
class HomeScreen extends StatefulWidget {{
  const HomeScreen({super.key});
// أضف هذه المتغيرات في أعلى الكلاس:

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  String _getText(String text) {
  return text; 
}
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. المتغيرات (لقد قمت بهذا الجزء بشكل صحيح)
  String _selectedRole = 'none';
  int _currentIndex = 0;
  bool _hasAcceptedCharter = false;
  String? _donorWilaya;
  final List<String> _algerianWilayas = [
    'الجزائر', 'وهران', 'عنابة', 'قسنطينة', 'سطيف', 'باتنة', 'الوادي', 'غرداية', 'ورقلة'
  ];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بوابة التكافل"),
      ),
      body: Center(
        child: Text("هنا ستظهر الحالات قريباً"),
      ),
    );
   
}
    {
    // ignore: strict_top_level_inference, prefer_typing_uninitialized_variables
    var _selectedRole;
    if (_selectedRole == 'benefactor' && _currentIndex != 2) { _currentIndex = 2; }
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Stack(
            children: [
              !_hasAcceptedCharter 
                  ? _buildCharterScreen() 
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 90.0), 
                      child: IndexedStack(
                        index: _currentIndex,
                        children: [
                          _buildRegisterScreen(), 
                          _buildUploadScreen(),   
                          _buildWallScreen(),          
                        ],
                      ),
                    ),
              if (_hasAcceptedCharter && _activeChatCase == null) _buildCustomFloatingNavbar(),
              if (_activeChatCase != null) _buildSafeChatOverlay(),
            ],
          ),
        ),
      ),
    );
  }
  
Widget _buildCustomFloatingNavbar() {
    return Positioned(
      bottom: 20, left: 20, right: 20,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF112240).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (_selectedRole == 'association') ...[
              _buildNavbarItem(0, Icons.assignment_ind, _getText('nav_register')),
              _buildNavbarItem(1, Icons.add_circle_outline, _getText('nav_upload')),
            ],
            _buildNavbarItem(2, Icons.dashboard, _getText('nav_wall')),
          ],
        ),
      ),
    );
  }
Widget _buildNavbarItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF64FFDA) : Colors.white60, size: 22),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Color(0xFF64FFDA), fontSize: 12, fontWeight: FontWeight.bold)),
            ]
          ],
        ),
      ),
    );
  }      
Widget _buildCharterScreen() { 
    if (_selectedRole == 'none') {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF112240),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_circle, color: Color(0xFF64FFDA), size: 55),
                const SizedBox(height: 15),
                const Text('بوابة التكافل الرقمية الشاملة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('الرجاء اختيار صفة الولوج لتخصيص التجربة وبنود المسؤولية التضامنية الشاملة والمحددة:', style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4), textAlign: TextAlign.center),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity, height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    label: const Text('أنا باغي خير (محسن / متطوع مستقل)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    onPressed: () => setState(() => _selectedRole = 'benefactor'),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity, height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1D3557), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), side: const BorderSide(color: Color(0xFF64FFDA), width: 0.8)),
                    icon: const Icon(Icons.business, color: Color(0xFF64FFDA)),
                    label: const Text('أنا جمعية خيرية معتمدة (مؤسسة)', style: TextStyle(color: Color(0xFF64FFDA), fontWeight: FontWeight.bold, fontSize: 13)),
                    onPressed: () => setState(() => _selectedRole = 'association'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
final isBenefactor = _selectedRole == 'benefactor';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: const Color(0xFF112240), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white12)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_border, color: Colors.orangeAccent),
                    const SizedBox(width: 10),
                    Expanded(child: Text(isBenefactor ? 'ميثاق النزاهة وحماية الخصوصية للمحسن' : 'ميثاق المسؤولية القانونية والتدقيق للجمعيات', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold))),
                  ],
                ),
                const Divider(color: Colors.white12),
                if (isBenefactor) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('📍 حدد ولاية تواجدك لتلقي تنبيهات الحالات المثبتة بنطاقك:', style: TextStyle(color: Color(0xFF64FFDA), fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                    child: DropdownButton<String>(
                      value: _donorWilaya,
                      dropdownColor: const Color(0xFF112240),
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: _algerianWilayas.map((String wilaya) {
                        return DropdownMenuItem<String>(value: wilaya, child: Text(wilaya, style: const TextStyle(color: Colors.white, fontSize: 13)));
                      }).toList(),
                      onChanged: (val) => setState(() => _donorWilaya = val!),
                    ),
                  ),
                ],
                Text(isBenefactor ? 'بصفتك محسناً أو متطوعاً يسعى لفعل الخير، يُرجى الالتزام بالضوابط الأخلاقية والشرعية التالية لحماية كرامة وخصوصية العائلات المعوزة بالتطبيق:' : 'بصفتكم جهة مؤسساتية معتمدة، يجب الالتزام بالضوابط القانونية والميدانية الصارمة لضمان مصداقية البيانات المرفوعة وبث النداءات المعتمدة المعيارية:', style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
                const SizedBox(height: 15),
                if (isBenefactor) ...[
                  _buildCharterBullet('🛑 حماية كرامة المستفيدين والخصوصية العمومية:', 'يُمنع منعاً باتاً نشر أو مشاركة معلومات شخصية، أو صور تكشف هويات العائلات وأماكن إقامتهم علناً على جدار المنصة المعروض.'),
                  _buildCharterBullet('🔍 التنسيق الحذر عبر القنوات الآمنة:', 'التزام تام بعدم تداول أرقام الهواتف أو البيانات الشخصية الحساسة عشوائياً، واستخدام قنوات الدردشة الآمنة للتنسيق المباشر والمحمي.'),
                  _buildCharterBullet('🤝 تعهد النزاهة الشخصية والالتزام بالمسؤولية:', 'بصفتي مستخدماً، أقر بوجوب التزامي الكامل بالصدق التام في الإشعار عن الحالات والحذر الشديد من مغبة التزييف أو المخالفة الميدانية العميقة.'),
                ] else ...[
                  _buildCharterBullet('⚖️ الالتزام التام بالغطاء القانوني الرسمي:', 'تتعهد الجمعية بممارسة نشاطها وبث الحالات تحت غطاء اعتمادها الرسمي الصادر عن وزارة الداخلية وتحت مسؤوليتها المدنية والجزائية الكاملة.'),
                  _buildCharterBullet('🔎 إلزامية التثبت والتحقق الميداني الصارم:', 'تتعهد المؤسسة الخيرية بعدم تغيير وسم أي حالة إلى "مثبتة" إلا بعد إجراء زيارة ميدانية دقيقة للمقر، والاطلاع الفعلي على الوثائق الرسمية للوضعية الإنسانية المعنية.'),
                  _buildCharterBullet('🔒 حماية وسرية ملفات المواطنين والمعوزين:', 'الالتزام الصارم بمعالجة وحفظ التقارير الطبية، كشوف الحسابات، وقرارات الإعانة المرفوعة بسرية مهنية تامة ومطلقة وعدم إخراجها خارج نطاق المنصة الرقمية.'),
                ],
                const SizedBox(height: 25),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white60), onPressed: () => setState(() => _selectedRole = 'none')),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
                          onPressed: () => setState(() {
                            _hasAcceptedCharter = true;
                            _currentIndex = isBenefactor ? 2 : 0; 
                            if (isBenefactor) { _notifyExistingVerifiedCases(); }
                          }),
                          child: Text(isBenefactor ? 'أوافق، وأتعهد بالنزاهة والالتزام كمحسن' : 'نوافق، ونلتزم بالمسؤولية القانونية والتدقيق كجمعية', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharterBullet(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF64FFDA), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                children: [
                  TextSpan(text: '$title ', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF64FFDA))),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildRegisterScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_getText('nav_register'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 20),
          _buildTextField('اسم الجمعية / المؤسسة الخيرية المعتمدة', _associationNameController, Icons.business),
          const SizedBox(height: 20),
          _buildTextField('رقم الاعتماد الرسمي الصادر عن وزارة الداخلية', _associationIdController, Icons.vpn_key),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () => setState(() => _isDocumentUploaded = true),
            child: Container(
              height: 120, width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08), 
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _isDocumentUploaded ? Colors.greenAccent : Colors.white12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, color: _isDocumentUploaded ? Colors.greenAccent : const Color(0xFF64FFDA)),
                  const SizedBox(height: 8),
                  Text(_isDocumentUploaded ? 'تم إدراج نسخة قرار الاعتماد (PDF)' : 'إرفاق نسخة ممسوحة ضوئياً من قرار الاعتماد الوزاري', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildUploadScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_getText('upload_title'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                child: DropdownButton<String>(
                  value: _selectedCaseType,
                  dropdownColor: const Color(0xFF112240),
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'MEDICAL_URGENT', child: Text('🏥 خدمات طبية مستعجلة وشؤون الجنائز', style: TextStyle(color: Colors.white, fontSize: 13))),
                    DropdownMenuItem(value: 'ECONOMIC_SUPPORT', child: Text('📦 تمكين مهني واقتصادي ومساعدات عينية', style: TextStyle(color: Colors.white, fontSize: 13))),
                    DropdownMenuItem(value: 'MOSQUE_SEASONAL', child: Text('🕌 إعمار مساجد ومشاريع مطاعم الرحمة', style: TextStyle(color: Colors.white, fontSize: 13))),
                    DropdownMenuItem(value: 'FATWA_ASK', child: Text('⚖️ طلب استشارة فقهية وتضامنية (لجنة الأئمة)', style: TextStyle(color: Colors.white, fontSize: 13))),
                    DropdownMenuItem(value: 'PROTECTION_MISSING', child: Text('🚨 حالات خاصة، غائبين ونداءات المفقودين', style: TextStyle(color: Colors.white, fontSize: 13))),
                  ],
                  onChanged: (val) => setState(() => _selectedCaseType = val!),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.teal.withValues(alpha: 0.2))),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Color(0xFF64FFDA), size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_getShortHint(_selectedCaseType), style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4))),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _buildTextField('عنوان الطلب أو النداء المدمج والمحدد', _caseTitleController, Icons.title),
              const SizedBox(height: 15),
              _buildTextField('تفاصيل الوضعية ومستنداتها الإدارية والشرعية المعيارية', _caseDescController, Icons.description, maxLines: 3),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.orangeAccent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                      child: DropdownButton<String>(
                        value: _selectedWilaya,
                        dropdownColor: const Color(0xFF112240),
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: _algerianWilayas.map((String wilaya) {
                          return DropdownMenuItem<String>(value: wilaya, child: Text(wilaya, style: const TextStyle(color: Colors.white, fontSize: 13)));
                        }).toList(),
                        onChanged: (val) => setState(() => _selectedWilaya = val!),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
                  onPressed: _addNewCase,
                  child: const Text('بث الطلب المحدث على جدار التكافل الاجتماعي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget _buildWallScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_getText('title'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              if (_selectedRole == 'benefactor')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                  child: Text('🔔 نطاق التنبيه: $_donorWilaya', style: const TextStyle(color: Color(0xFF64FFDA), fontSize: 11, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          
          // الميزة الأولى: شريط البحث الفوري والذكي المحدث لتصفية الحالات في نفس اللحظة
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            onChanged: (val) => setState(() {}), // تحديث فوري لواجهة جدار الأمل عند الكتابة
            decoration: InputDecoration(
              hintText: '🔍 ابحث فوراً في العناوين والنداءات المفعّلة...',
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              suffixIcon: _searchController.text.isNotEmpty 
                  ? IconButton(icon: const Icon(Icons.clear, color: Colors.white38, size: 18), onPressed: () => setState(() { _searchController.clear(); }))
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterDropdown('الولاية', _selectedFilterWilaya, ['الكل', '01- أدرار', '16- الجزائر', '25- قسنطينة', '30- ورقلة', '55- تقرت', '68- بوسعادة'], (val) {
                  setState(() => _selectedFilterWilaya = val!);
                }),
                const SizedBox(width: 8),
                _buildFilterDropdown('نوع الحالة', _selectedFilterType, ['الكل', 'MEDICAL_URGENT', 'ECONOMIC_SUPPORT', 'MOSQUE_SEASONAL', 'FATWA_ASK', 'PROTECTION_MISSING'], (val) {
                  setState(() => _selectedFilterType = val!);
                }),
                const SizedBox(width: 8),
                _buildFilterDropdown('التثبت', _selectedFilterStatus, ['الكل', 'مثبتة', 'قيد التثبت'], (val) {
                  setState(() => _selectedFilterStatus = val!);
                }),
              ],
            ),
          ),
          const SizedBox(height: 10),
          
          // الميزة الثالثة: أزرار التحكم في الحفظ والاسترجاع الفوري لقاعدة البيانات التضامنية (JSON Backup & Restore)
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.05), foregroundColor: const Color(0xFF64FFDA), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(vertical: 8)),
                  icon: const Icon(Icons.copy_all, size: 16),
                  label: const Text('نسخ احتياطي (JSON)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  onPressed: _backupData,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.05), foregroundColor: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(vertical: 8)),
                  icon: const Icon(Icons.restart_alt, size: 16),
                  label: const Text('استرجاع الجدار', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  onPressed: _showRestoreDialog,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Expanded(
            child: filteredCases.isEmpty
                ? const Center(child: Text('لا توجد حالات مطابقة لمعايير البحث حالياً', style: TextStyle(color: Colors.white38, fontSize: 13)))
                : ListView.builder(
                    itemCount: filteredCases.length,
                    itemBuilder: (context, index) {
                      return _buildCaseCard(filteredCases[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
Widget _buildFilterDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: const Color(0xFF112240), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
      child: DropdownButton<String>(
        value: value, dropdownColor: const Color(0xFF112240), underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF64FFDA), size: 18),
        style: const TextStyle(color: Colors.white, fontSize: 12),
        items: items.map((String val) {
          String display = val;
          if (val == 'MEDICAL_URGENT') display = 'طبية وجنائز';
          if (val == 'ECONOMIC_SUPPORT') display = 'تمكين ومساعدات';
          if (val == 'MOSQUE_SEASONAL') display = 'إعمار ومطاعم';
          if (val == 'FATWA_ASK') display = 'فتاوى واستشارات';
          if (val == 'PROTECTION_MISSING') display = 'حالات خاصة';
          if (val == 'الكل') display = '$label: الكل';
          return DropdownMenuItem<String>(value: val, child: Text(display));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
// هذا هو الكود القديم (مكان الاستدعاء)
_buildSafeChatOverlay(),
  
Widget _buildTextField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: controller, maxLines: maxLines, style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label, labelStyle: const TextStyle(color: Colors.white60, fontSize: 13),
        prefixIcon: Icon(icon, color: const Color(0xFF64FFDA)), filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
