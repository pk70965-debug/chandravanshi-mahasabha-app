import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init: $e");
  }
  runApp(const ChandravanshiApp());
}

class ChandravanshiApp extends StatelessWidget {
  const ChandravanshiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B0000), // गहरा महरून/केसरिया राजपूताना रंग
          primary: const Color(0xFF8B0000),
          secondary: const Color(0xFFFF9933),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _familyMembers = [
    {"name": "पवन कुमार राम (चंद्रवंशी)", "relation": "मुखिया", "age": "34", "blood": "O+"},
    {"name": "खुशबू देवी", "relation": "पत्नी", "age": "30", "blood": "B+"},
  ];

  final List<Map<String, dynamic>> _receipts = [
    {
      "receiptNo": "ABCKM/2026/0142",
      "name": "पवन कुमार राम",
      "amount": "501",
      "purpose": "मासिक सदस्यता सहयोग",
      "date": DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
      "status": "सफल (Paid)"
    }
  ];

  void _addFamilyMember(String name, String relation, String age, String blood) {
    setState(() {
      _familyMembers.add({
        "name": name,
        "relation": relation,
        "age": age,
        "blood": blood,
      });
    });
  }

  void _addNewReceipt(String amount, String purpose) {
    final newNo = "ABCKM/2026/0${143 + _receipts.length}";
    setState(() {
      _receipts.insert(0, {
        "receiptNo": newNo,
        "name": "पवन कुमार राम",
        "amount": amount,
        "purpose": purpose,
        "date": DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
        "status": "सफल (Online Paid)"
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B0000),
        title: const Text(
          'चंद्रवंशी क्षत्रिय महासभा',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: Colors.amber),
            onPressed: () {},
          )
        ],
      ),
      body: _currentIndex == 0
          ? _buildDashboard()
          : _currentIndex == 1
              ? _buildFamilyTab()
              : _buildReceiptsTab(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'मुख्य पृष्ठ'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'परिवार'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'रसीदें'),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // शीर्ष आधिकारिक पहचान व नया लोगो
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF8B0000), width: 3),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2)],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'IMG_20260925_175930.png',
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => const Icon(
                          Icons.account_balance,
                          size: 55,
                          color: Color(0xFF8B0000),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8B0000)),
                  ),
                  const Text(
                    'अखिल भारतीय निबंधन संख्या: 2145/30/1912',
                    style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ऑनलाइन दान / सदस्यता शुल्क कार्ड
          Card(
            color: const Color(0xFFFFF4E5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.payment, color: Color(0xFFD97706)),
                      SizedBox(width: 8),
                      Text(
                        'ऑनलाइन सदस्यता शुल्क / सहयोग',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF78350F)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'सुरक्षित डिजिटल भुगतान करें और तुरंत आधिकारिक डिजिटल रसीद प्राप्त करें।',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      minimumSize: const Size.fromHeight(42),
                    ),
                    icon: const Icon(Icons.send_to_mobile),
                    label: const Text('सहयोग राशि जमा करें (Pay Online)'),
                    onPressed: _showPaymentDialog,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyTab() {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF8B0000),
        foregroundColor: Colors.white,
        onPressed: _showAddFamilyDialog,
        icon: const Icon(Icons.person_add),
        label: const Text('सदस्य जोड़ें'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: _familyMembers.length,
        itemBuilder: (ctx, i) {
          final m = _familyMembers[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF8B0000).withOpacity(0.1),
                child: const Icon(Icons.person, color: Color(0xFF8B0000)),
              ),
              title: Text(m['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("संबंध: ${m['relation']} • आयु: ${m['age']} वर्ष • रक्त: ${m['blood']}"),
              trailing: const Icon(Icons.verified, color: Colors.green, size: 20),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReceiptsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: _receipts.length,
      itemBuilder: (ctx, i) {
        final r = _receipts[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      r['receiptNo'],
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8B0000)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(6)),
                      child: Text(r['status'], style: TextStyle(color: Colors.green.shade800, fontSize: 11, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const Divider(height: 18),
                Text("नाम: ${r['name']}", style: const TextStyle(fontSize: 14)),
                Text("राशि: ₹${r['amount']} (${r['purpose']})", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                Text("दिनांक: ${r['date']}", style: const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${r['receiptNo']} की PDF रसीद डाउनलोड हो रही है...")),
                        );
                      },
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('PDF रसीद'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("रसीद WhatsApp पर शेयर की जा रही है...")),
                        );
                      },
                      icon: const Icon(Icons.share, size: 18, color: Colors.green),
                      label: const Text('WhatsApp'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPaymentDialog() {
    final amountCtrl = TextEditingController(text: "501");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ऑनलाइन सहयोग राशि'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'राशि (₹)', prefixText: '₹ '),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B0000), foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(ctx);
              _addNewReceipt(amountCtrl.text, "मासिक सदस्यता सहयोग");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("भुगतान सफल! डिजिटल रसीद जारी कर दी गई है।")),
              );
            },
            child: const Text('जमा करें व रसीद लें'),
          ),
        ],
      ),
    );
  }

  void _showAddFamilyDialog() {
    final nameCtrl = TextEditingController();
    final relCtrl = TextEditingController();
    final ageCtrl = TextEditingController();
    final bloodCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('नया परिवार सदस्य जोड़ें'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'सदस्य का पूरा नाम')),
              TextField(controller: relCtrl, decoration: const InputDecoration(labelText: 'संबंध (जैसे: पुत्र / पुत्री)')),
              TextField(controller: ageCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'उम्र')),
              TextField(controller: bloodCtrl, decoration: const InputDecoration(labelText: 'रक्त समूह (Blood Group)')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B0000), foregroundColor: Colors.white),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                _addFamilyMember(nameCtrl.text, relCtrl.text, ageCtrl.text, bloodCtrl.text);
                Navigator.pop(ctx);
              }
            },
            child: const Text('जोड़ें'),
          ),
        ],
      ),
    );
  }
}
