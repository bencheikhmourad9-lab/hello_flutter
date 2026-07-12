import 'package:flutter/material.dart';

class SafeChatOverlay extends StatelessWidget {
  final Map<String, dynamic> item;
  final List<Map<String, dynamic>> messages;
  final TextEditingController controller;
  final VoidCallback onClose;
  final VoidCallback onSend;
  final IconData Function(String) getCaseIcon;

  const SafeChatOverlay({
    super.key,
    required this.item,
    required this.messages,
    required this.controller,
    required this.onClose,
    required this.onSend,
    required this.getCaseIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isFatwa = item['type'] == 'FATWA_ASK';
    Color accentColor = const Color(0xFF00B0FF);
    if (item['type'] == 'MEDICAL_URGENT') accentColor = const Color(0xFF00E676);
    if (isFatwa) accentColor = const Color(0xFFFF9100);
    if (item['type'] == 'PROTECTION_MISSING') accentColor = const Color(0xFFFF5252);

    return Container(
      color: const Color(0xFF0A192F),
      width: double.infinity,
      height: double.infinity,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A192F),
        appBar: AppBar(
          title: Text(
            isFatwa ? 'غرفة الاستشارة الشرعية حية (#${item['id']})' : 'قناة التنسيق والدردشة الآمنة (#${item['id']})',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF112240),
          centerTitle: true,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: onClose),
          elevation: 0,
        ),
        body: Column(
          children: [
            // رأس الشات
            _buildHeader(accentColor),
            // تذكرة الأمان
            Container(
              width: double.infinity, color: Colors.black38, padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.lock, size: 14, color: accentColor),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('بموجب ميثاق النزاهة؛ يُرجى الحذر من مشاركة بيانات الهوية الحساسة عشوائياً.', style: TextStyle(color: Colors.white38, fontSize: 10, height: 1.3))),
                ],
              ),
            ),
            // قائمة الرسائل
            Expanded(child: _buildMessageList()),
            // حقل الإدخال
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color accentColor) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(14), color: const Color(0xFF112240).withValues(alpha: 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [Icon(getCaseIcon(item['type']), color: accentColor, size: 16), const SizedBox(width: 6), Text(item['typeName'] ?? '', style: TextStyle(color: accentColor, fontSize: 12, fontWeight: FontWeight.bold))]),
              Text('ولاية: ${item['location_ar']}', style: const TextStyle(color: Colors.orangeAccent, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(item['title_ar'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(item['desc_ar'] ?? '', style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    if (messages.isEmpty) return const Center(child: Text('لا توجد رسائل حالياً', style: TextStyle(color: Colors.white38)));
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isSystem = msg['sender'] == 'system';
        final isMe = msg['sender'] == 'me';

        if (isSystem) {
          return Center(child: Container(margin: const EdgeInsets.symmetric(vertical: 10), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)), child: Text(msg['text'] ?? '', style: const TextStyle(color: Colors.white70, fontSize: 12), textAlign: TextAlign.center)));
        }

        return Align(
          alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5), padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isMe ? const Color(0xFF00796B) : const Color(0xFF112240), borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(msg['text'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 13)), const SizedBox(height: 4), Text(msg['time'] ?? '', style: const TextStyle(color: Colors.white38, fontSize: 10))]),
          ),
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12), color: const Color(0xFF112240),
      child: Row(
        children: [
          Expanded(child: TextField(controller: controller, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: 'اكتب رسالتك هنا...', hintStyle: TextStyle(color: Colors.white38), border: InputBorder.none))),
          IconButton(icon: const Icon(Icons.send, color: Color(0xFF64FFDA)), onPressed: onSend),
        ],
      ),
    );
  }
}