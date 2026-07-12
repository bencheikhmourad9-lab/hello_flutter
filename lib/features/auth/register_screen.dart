import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // المتغيرات التي يحتاجها الكود
  final TextEditingController _associationNameController = TextEditingController();
  final TextEditingController _associationIdController = TextEditingController();
  bool _isDocumentUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // لون خلفية مناسب
      body: SingleChildScrollView(
        child: _buildRegisterScreen(),
      ),
    );
  }

  Widget _buildRegisterScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50), // مسافة من الأعلى
          const Text('التسجيل', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
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

  // الدالة المساعدة التي كانت مفقودة (قم بتعديلها لاحقاً حسب تصميمك)
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
      ),
    );
  }
}