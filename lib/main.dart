import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          seedColor: const Color(0xFF8B0000),
          primary: const Color(0xFF8B0000),
          secondary: const Color(0xFFFF9933),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: Color(0xFF8B0000))),
          );
        }
        if (snapshot.hasData) {
          return HomeScreen(user: snapshot.data!);
        }
        return const LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? _verificationId;
  bool _isLoading = false;
  bool _otpSent = false;

  void _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया सही 10 अंकों का मोबाइल नंबर दर्ज करें')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('लॉगिन विफल: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _otpSent = true;
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP आपके मोबाइल नंबर पर भेज दिया गया है')),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('त्रुटि: $e')),
      );
    }
  }

  void _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length < 6 || _verificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया 6 अंकों का OTP दर्ज करें')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('अमान्य OTP! कृपया पुनः प्रयास करें')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF8B0000), width: 3),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'IMG_20260925_175930.png',
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => const Icon(
                            Icons.account_balance,
                            size: 50,
                            color: Color(0xFF8B0000),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8B0000)),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'सदस्यता सत्यापन एवं डिजिटल पोर्टल',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const Divider(height: 30),
                    if (!_otpSent) ...[
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          labelText: 'मोबाइल नंबर दर्ज करें',
                          prefixText: '+91 ',
                          prefixIcon: Icon(Icons.phone_android),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _isLoading
                          ? const CircularProgressIndicator(color: Color(0xFF8B0000))
                          : ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B0000),
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: _sendOtp,
                              icon: const Icon(Icons.send),
                              label: const Text('OTP प्राप्त करें'),
                            ),
                    ] else ...[
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(
                          labelText: '6 अंकों का OTP दर्ज करें',
                          prefixIcon: Icon(Icons.lock_clock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _isLoading
                          ? const CircularProgressIndicator(color: Color(0xFF8B0000))
                          : ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade800,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: _verifyOtp,
                              icon: const Icon(Icons.verified_user),
                              label: const Text('सत्यापित करें एवं लॉगिन करें'),
                            ),
                      TextButton(
                        onPressed: () => setState(() => _otpSent = false),
                        child: const Text('मोबाइल नंबर बदलें'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
        actions: [
          IconButton(
            tooltip: 'लॉगआउट',
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
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
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF8B0000), width: 2.5),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'IMG_20260925_175930.png',
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => const Icon(
                          Icons.account_balance,
                          size: 50,
                          color: Color(0xFF8B0000),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8B0000)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'सत्यापित मोबाइल: ${widget.user.phoneNumber ?? ""}',
                    style: const TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
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
                    'क्लाउड डेटाबेस से जुड़ी सुरक्षित डिजिटल रसीद प्राप्त करें।',
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
                    label: const Text('सहयोग राशि दर्ज करें (Live Cloud)'),
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
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .collection('family_members');

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF8B0000),
        foregroundColor: Colors.white,
        onPressed: _showAddFamilyDialog,
        icon: const Icon(Icons.person_add),
        label: const Text('सदस्य जोड़ें'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF8B0000)));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'अभी कोई सदस्य नहीं जुड़ा है।\nनीचे दिए गए बटन से नया सदस्य जोड़ें।',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.all(14),
            itemCount: docs.length,
            itemBuilder: (ctx, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF8B0000).withOpacity(0.1),
                    child: const Icon(Icons.person, color: Color(0xFF8B0000)),
                  ),
                  title: Text(data['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("संबंध: ${data['relation']} • उम्र: ${data['age']} वर्ष • रक्त: ${data['blood']}"),
                  trailing: const Icon(Icons.cloud_done, color: Colors.green, size: 20),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildReceiptsTab() {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .collection('receipts')
        .orderBy('timestamp', descending: true);

    return StreamBuilder<QuerySnapshot>(
      stream: collection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF8B0000)));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'अभी कोई रसीद जारी नहीं हुई है।',
              style: TextStyle(color: Colors.black54),
            ),
          );
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: docs.length,
          itemBuilder: (ctx, i) {
            final r = docs[i].data() as Map<String, dynamic>;
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
                          r['receiptNo'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8B0000)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(6)),
                          child: Text(r['status'] ?? 'सफल', style: TextStyle(color: Colors.green.shade800, fontSize: 11, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    const Divider(height: 18),
                    Text("मोबाइल: ${widget.user.phoneNumber}", style: const TextStyle(fontSize: 14)),
                    Text("राशि: ₹${r['amount']} (${r['purpose']})", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                    Text("दिनांक: ${r['date']}", style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showPaymentDialog() {
    final amountCtrl = TextEditingController(text: "501");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('सहयोग राशि दर्ज करें'),
        content: TextField(
          controller: amountCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'राशि (₹)', prefixText: '₹ '),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B0000), foregroundColor: Colors.white),
            onPressed: () async {
              final amt = amountCtrl.text.trim();
              if (amt.isNotEmpty) {
                Navigator.pop(ctx);
                final docId = DateTime.now().millisecondsSinceEpoch.toString().substring(7);
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.user.uid)
                    .collection('receipts')
                    .add({
                  "receiptNo": "ABCKM/2026/$docId",
                  "amount": amt,
                  "purpose": "मासिक सदस्यता सहयोग",
                  "date": DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
                  "timestamp": FieldValue.serverTimestamp(),
                  "status": "सत्यापित (Live Cloud)"
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("क्लाउड रसीद सफलतापूर्वक जनरेट हो गई!")),
                );
              }
            },
            child: const Text('सुरक्षित सेव करें'),
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
            onPressed: () async {
              if (nameCtrl.text.isNotEmpty) {
                Navigator.pop(ctx);
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.user.uid)
                    .collection('family_members')
                    .add({
                  "name": nameCtrl.text.trim(),
                  "relation": relCtrl.text.trim(),
                  "age": ageCtrl.text.trim(),
                  "blood": bloodCtrl.text.trim(),
                  "createdAt": FieldValue.serverTimestamp(),
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("सदस्य ऑनलाइन डेटाबेस में सुरक्षित जुड़ गया!")),
                );
              }
            },
            child: const Text('क्लाउड में जोड़ें'),
          ),
        ],
      ),
    );
  }
}
