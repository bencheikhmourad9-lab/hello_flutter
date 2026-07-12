class CaseCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap; // إذا كنت تحتاج لحدث الضغط

  const CaseCard({super.key, required this.item, required this.onTap});

  @override
     Widget _buildCaseCard(Map<String, dynamic> item) {
    final isFatwa = item['type'] == 'FATWA_ASK';
    final isVerified = (item['status'] ?? 'مثبتة') == 'مثبتة';
    
    Color accentColor = const Color(0xFF00B0FF); 
    if (item['type'] == 'MEDICAL_URGENT') accentColor = const Color(0xFF00E676); 
    if (isFatwa) accentColor = const Color(0xFFFF9100); 
    if (item['type'] == 'PROTECTION_MISSING') accentColor = const Color(0xFFFF5252); 

    // معايير حساب الميزة الثانية: مؤشرات التقدم
    double target = (item['target'] ?? 0).toDouble();
    double current = (item['current'] ?? 0).toDouble();
    bool showProgress = target > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
        child: Row(
          children: [
            Container(width: 5, height: showProgress ? 180 : 145, color: accentColor),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(item['icon'] ?? _getCaseIcon(item['type']), color: accentColor, size: 16),
                            const SizedBox(width: 6),
                            Text(item['typeName'] ?? '', style: TextStyle(color: accentColor, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isVerified ? Colors.green.withValues(alpha: 0.15) : Colors.orange.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: isVerified ? Colors.green : Colors.orange, width: 0.5),
                          ),
                          child: Text(item['status'] ?? 'مثبتة', style: TextStyle(color: isVerified ? Colors.greenAccent : Colors.orangeAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(item['title_ar'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    
                    // الميزة الثانية: مؤشر التقدم التفاعلي (LinearProgressIndicator) للحالات المادية والعينية
                    if (showProgress) ...[
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('التقدم المحقق: ${current.toStringAsFixed(0)} دج / ${target.toStringAsFixed(0)} دج', style: const TextStyle(color: Colors.white60, fontSize: 11)),
                          Text('${((current / target) * 100).toStringAsFixed(0)}%', style: TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (current / target).clamp(0.0, 1.0),
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                          valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                          minHeight: 6,
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.orangeAccent, size: 14),
                            const SizedBox(width: 4),
                            Text(item['location_ar'] ?? '', style: const TextStyle(color: Colors.orangeAccent, fontSize: 12)),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor.withValues(alpha: 0.15), foregroundColor: accentColor, elevation: 0,
                            side: BorderSide(color: accentColor.withValues(alpha: 0.3)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => _openChatRoom(item), 
                          child: Text(isFatwa ? 'تقديم استشارة والمحادثة' : 'عرض التفاصيل والتواصل', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // ضع الكود الخاص بـ _buildCaseCard هنا
  }
}