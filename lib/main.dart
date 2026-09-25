import 'package:flutter/material.dart';

void main() {
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
        primaryColor: const Color(0xFF800000),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF800000),
          primary: const Color(0xFF800000),
        ),
        useMaterial3: true,
      ),
      home: const RoleBasedLoginScreen(),
    );
  }
}

// -------------------------------------------------------------
// 1. लॉगिन व रोल सत्यापन स्क्रीन (सुपर एडमिन / एडमिन / सदस्य)
// -------------------------------------------------------------
class RoleBasedLoginScreen extends StatefulWidget {
  const RoleBasedLoginScreen({super.key});

  @override
  State<RoleBasedLoginScreen> createState() => _RoleBasedLoginScreenState();
}

class _RoleBasedLoginScreenState extends State<RoleBasedLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;
  bool _isAdminLogin = false;

  void _handleSendOtp() {
    if (_phoneController.text.trim().length == 10) {
      setState(() {
        _otpSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP भेजा गया: 1234 (डेमो)')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया सही 10 अंकों का मोबाइल नंबर दर्ज करें')),
      );
    }
  }

  void _handleVerifyAndProceed() {
    String phone = _phoneController.text.trim();
    String role = "MEMBER";
    String? assignedDistrict;

    if (_isAdminLogin) {
      role = "SUPER_ADMIN";
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HierarchyExplorerScreen(
          userRole: role,
          userPhone: phone,
          assignedDistrict: assignedDistrict,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              // आपका असली आधिकारिक लोगो (app_logo.png)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'app_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF800000),
                      child: const Icon(Icons.shield, size: 60, color: Colors.amber),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF800000),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'स्थापित 1906 • निबंधन सं० 2145/30/1912\nडिजिटल समाज प्रबंधन पोर्टल',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.brown, height: 1.3),
              ),
              const SizedBox(height: 25),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChoiceChip(
                            label: const Text('आम सदस्य'),
                            selected: !_isAdminLogin,
                            onSelected: (val) {
                              setState(() => _isAdminLogin = false);
                            },
                          ),
                          const SizedBox(width: 10),
                          ChoiceChip(
                            label: const Text('पदाधिकारी / एडमिन 👑'),
                            selected: _isAdminLogin,
                            selectedColor: Colors.amber.shade200,
                            onSelected: (val) {
                              setState(() => _isAdminLogin = true);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _isAdminLogin
                            ? 'पदाधिकारी / सुपर एडमिन लॉगिन'
                            : 'सदस्य सत्यापन व प्रवेश',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          prefixText: '+91 ',
                          labelText: _isAdminLogin
                              ? 'अपना मोबाइल नंबर दर्ज करें'
                              : '10 अंकों का मोबाइल नंबर',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      if (_otpSent) ...[
                        const SizedBox(height: 10),
                        TextField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            labelText: 'OTP दर्ज करें (1234)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF800000),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _otpSent ? _handleVerifyAndProceed : _handleSendOtp,
                        child: Text(_otpSent ? 'सत्यापित कर आगे बढ़ें' : 'OTP प्राप्त करें'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'एकता • संगठन • विकास\nसमाज का साथ, सशक्त समाज',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xFF800000), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 2. भारत ➔ राज्य ➔ ज़िला ➔ प्रखंड ➔ इकाई चयन व प्रबंधन स्क्रीन
// -------------------------------------------------------------
class HierarchyExplorerScreen extends StatefulWidget {
  final String userRole;
  final String userPhone;
  final String? assignedDistrict;

  const HierarchyExplorerScreen({
    super.key,
    required this.userRole,
    required this.userPhone,
    this.assignedDistrict,
  });

  @override
  State<HierarchyExplorerScreen> createState() => _HierarchyExplorerScreenState();
}

class _HierarchyExplorerScreenState extends State<HierarchyExplorerScreen> {
  Map<String, Map<String, List<String>>> hierarchy = {
    'झारखंड': {
      'कोडरमा': ['झुमरी तिलैया नगर परिषद', 'कोडरमा प्रखंड', 'डोमचांच प्रखंड', 'जयनगर प्रखंड', 'मरकच्चो प्रखंड', 'सतगावां प्रखंड'],
      'हज़ारीबाग': ['हज़ारीबाग सदर', 'बरही', 'चौपारण', 'इचाक'],
      'गिरिडीह': ['गिरिडीह सदर', 'बगोदर', 'डुमरी', 'धनवार'],
      'धनबाद': ['धनबाद नगर निगम', 'झरिया', 'बाघमारा', 'निरसा'],
    },
    'बिहार': {
      'गया': ['गया नगर निगम', 'बोधगया', 'शेरघाटी', 'टेकारी'],
      'पटना': ['पटना नगर निगम', 'दानापुर', 'फतुहा', 'बाढ़'],
    },
  };

  String? selectedState;
  String? selectedDistrict;
  String? selectedBlock;

  void _addNewStateDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('+ नया राज्य जोड़ें'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'राज्य का नाम दर्ज करें'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  hierarchy[controller.text.trim()] = {};
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('जोड़ें'),
          ),
        ],
      ),
    );
  }

  void _addNewDistrictDialog(String state) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('+ नया ज़िला जोड़ें ($state)'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'ज़िले का नाम दर्ज करें'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  hierarchy[state]![controller.text.trim()] = [];
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('जोड़ें'),
          ),
        ],
      ),
    );
  }

  void _addNewBlockDialog(String state, String dist) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('+ प्रखंड/वार्ड जोड़ें ($dist)'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'प्रखंड / पंचायत / वार्ड का नाम'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  hierarchy[state]![dist]!.add(controller.text.trim());
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('जोड़ें'),
          ),
        ],
      ),
    );
  }

  void _assignAdminDialog(String dist) {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController phoneCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('⚙️ $dist ज़िला एडमिन नियुक्त करें'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'पदाधिकारी का नाम')),
            const SizedBox(height: 10),
            TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'मोबाइल नंबर')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${nameCtrl.text} को $dist का एडमिन बनाया गया!')),
              );
            },
            child: const Text('नियुक्त करें'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSuperAdmin = widget.userRole == "SUPER_ADMIN";
    bool isDistrictAdmin = widget.userRole == "DISTRICT_ADMIN";

    return Scaffold(
      appBar: AppBar(
        title: Text(isSuperAdmin
            ? 'सुपर एडमिन पैनल 👑'
            : isDistrictAdmin
                ? 'ज़िला एडमिन (${widget.assignedDistrict})'
                : 'क्षेत्र व इकाई चयन'),
        backgroundColor: const Color(0xFF800000),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RoleBasedLoginScreen()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSuperAdmin ? Colors.amber.shade100 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: isSuperAdmin ? Colors.amber.shade800 : Colors.blue),
              ),
              child: Row(
                children: [
                  Icon(isSuperAdmin ? Icons.stars : Icons.info_outline,
                      color: isSuperAdmin ? Colors.brown : Colors.blue.shade800),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      isSuperAdmin
                          ? 'सुपर एडमिन मोड: आप पूरे भारत में राज्य, ज़िला जोड़ सकते हैं और ज़िला एडमिन नियुक्त कर सकते हैं।'
                          : isDistrictAdmin
                              ? 'ज़िला एडमिन: आप अपने ज़िले (${widget.assignedDistrict}) में नए प्रखंड व वार्ड जोड़ सकते हैं।'
                              : 'सदस्य मोड: अपने राज्य, ज़िला व प्रखंड का चयन करके इकाई में प्रवेश करें।',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('🇮🇳 भारत ➔ राज्य चुनें:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                if (isSuperAdmin)
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Color(0xFF800000)),
                    tooltip: 'नया राज्य जोड़ें',
                    onPressed: _addNewStateDialog,
                  ),
              ],
            ),
            Wrap(
              spacing: 8,
              children: hierarchy.keys.map((st) {
                return ChoiceChip(
                  label: Text(st),
                  selected: selectedState == st,
                  onSelected: (val) {
                    setState(() {
                      selectedState = val ? st : null;
                      selectedDistrict = null;
                      selectedBlock = null;
                    });
                  },
                );
              }).toList(),
            ),
            const Divider(height: 30),

            if (selectedState != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('📍 $selectedState के ज़िले:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  if (isSuperAdmin)
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Color(0xFF800000)),
                      tooltip: 'नया ज़िला जोड़ें',
                      onPressed: () => _addNewDistrictDialog(selectedState!),
                    ),
                ],
              ),
              Column(
                children: hierarchy[selectedState]!.keys.map((dist) {
                  return Card(
                    elevation: selectedDistrict == dist ? 3 : 1,
                    color: selectedDistrict == dist ? Colors.amber.shade50 : Colors.white,
                    child: ListTile(
                      title: Text(dist, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${hierarchy[selectedState]![dist]!.length} प्रखंड / नगर उपलब्ध'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSuperAdmin)
                            IconButton(
                              icon: const Icon(Icons.admin_panel_settings, color: Colors.blue),
                              tooltip: 'ज़िला एडमिन बनाएँ',
                              onPressed: () => _assignAdminDialog(dist),
                            ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          selectedDistrict = dist;
                          selectedBlock = null;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const Divider(height: 30),
            ],

            if (selectedDistrict != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('🏛️ $selectedDistrict के प्रखंड / वार्ड:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  if (isSuperAdmin || (isDistrictAdmin && widget.assignedDistrict == selectedDistrict))
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Color(0xFF800000)),
                      tooltip: 'नया प्रखंड / वार्ड जोड़ें',
                      onPressed: () => _addNewBlockDialog(selectedState!, selectedDistrict!),
                    ),
                ],
              ),
              Column(
                children: hierarchy[selectedState]![selectedDistrict]!.map((blk) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_city, color: Color(0xFF800000)),
                      title: Text(blk),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF800000), foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => UnitDashboardScreen(
                                state: selectedState!,
                                district: selectedDistrict!,
                                block: blk,
                                userRole: widget.userRole,
                              ),
                            ),
                          );
                        },
                        child: const Text('प्रवेश करें'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. स्थानीय इकाई डैशबोर्ड (8 विकल्प)
// -------------------------------------------------------------
class UnitDashboardScreen extends StatelessWidget {
  final String state;
  final String district;
  final String block;
  final String userRole;

  const UnitDashboardScreen({
    super.key,
    required this.state,
    required this.district,
    required this.block,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('चंद्रवंशी क्षत्रिय महासभा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('$block • $district ($state)', style: const TextStyle(fontSize: 11, color: Colors.amber)),
          ],
        ),
        backgroundColor: const Color(0xFF800000),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.asset(
                      'app_logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.shield, color: Color(0xFF800000)),
                    ),
                  ),
                ),
                title: Text('$block इकाई'),
                subtitle: const Text('हमारा समाज • हमारी पहचान'),
                trailing: Chip(
                  label: Text(userRole == 'SUPER_ADMIN' ? 'सुपर एडमिन' : userRole == 'DISTRICT_ADMIN' ? 'एडमिन' : 'सदस्य'),
                  backgroundColor: Colors.amber.shade100,
                ),
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.3,
              children: [
                _buildCard(Icons.people, 'सदस्य सूची', Colors.blue.shade700),
                _buildCard(Icons.currency_rupee, 'जमा-बाकी हिसाब', Colors.green.shade700),
                _buildCard(Icons.receipt_long, 'रसीद', Colors.orange.shade800),
                _buildCard(Icons.campaign, 'सूचना / नोटिस', Colors.red.shade700),
                _buildCard(Icons.calendar_month, 'कार्यक्रम', Colors.purple.shade700),
                _buildCard(Icons.photo_library, 'फोटो गैलरी', Colors.teal.shade700),
                _buildCard(Icons.badge, 'पदाधिकारी', Colors.pink.shade700),
                _buildCard(Icons.menu_book, 'समाज के नियम', Colors.indigo.shade700),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(IconData icon, String title, Color color) {
    return Card(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
