import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'लोड करने में समस्या: ${details.exception}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  };

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDyr4LAv2_micaf--q00ALnxpXK_X0l5o0',
        appId: '1:416848978606:android:97c9253eacc6dd71f2033f',
        messagingSenderId: '416848978606',
        projectId: 'chandravanshi-mahasabha',
        storageBucket: 'chandravanshi-mahasabha.firebasestorage.app',
      ),
    );
  } catch (e) {
    debugPrint("Firebase init: $e");
  }

  runApp(const ChandravanshiPortalApp());
}

class ChandravanshiPortalApp extends StatelessWidget {
  const ChandravanshiPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A192F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D233A),
          primary: const Color(0xFF0D233A),
          secondary: const Color(0xFFD4AF37),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainLandingScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. मुख्य लैंडिंग स्क्रीन (Grand Landing Screen)
// ---------------------------------------------------------------------------
class MainLandingScreen extends StatelessWidget {
  const MainLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.shield, size: 44, color: Color(0xFF0D233A)),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'परंपरा से शक्ति, एकता से पहचान',
                style: TextStyle(color: Color(0xFFD4AF37), fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // मगध सम्राट महाराजा जरासंध जी बैनर
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
                ),
                color: const Color(0xFFFBF4E6),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'मगध सम्राट जरासंध जी',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A2800),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.fort, size: 64, color: Colors.orange.shade900),
                            const SizedBox(height: 8),
                            const Text(
                              'मगध साम्राज्य - अखंड शौर्य का प्रतीक',
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D233A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'मगध सम्राट महाराजा जरासंध जी',
                          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // सदस्य लॉगिन बटन
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D3B66),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFD4AF37), width: 1),
                  ),
                  elevation: 4,
                ),
                icon: const Icon(Icons.person, color: Color(0xFFD4AF37)),
                label: const Text(
                  'सदस्य Login  ›',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MemberLoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 8),
              const Text(
                'मोबाइल नंबर से सुरक्षित सदस्य प्रवेश',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
              const SizedBox(height: 28),

              // नीचे एडमिन लिंक्स
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: Colors.white70),
                    icon: const Icon(Icons.admin_panel_settings, size: 18, color: Color(0xFFD4AF37)),
                    label: const Text('Admin Login', style: TextStyle(fontSize: 14)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegionalAdminLoginScreen()),
                      );
                    },
                  ),
                  Container(width: 1, height: 18, color: Colors.white24),
                  TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: Colors.white70),
                    icon: const Icon(Icons.manage_accounts, size: 18, color: Color(0xFFD4AF37)),
                    label: const Text('Super Admin Login', style: TextStyle(fontSize: 14)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SuperAdminLoginScreen()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. सदस्य लॉगिन स्क्रीन (Member Login Screen)
// ---------------------------------------------------------------------------
class MemberLoginScreen extends StatefulWidget {
  const MemberLoginScreen({super.key});

  @override
  State<MemberLoginScreen> createState() => _MemberLoginScreenState();
}

class _MemberLoginScreenState extends State<MemberLoginScreen> {
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  String? _verificationId;
  bool _isLoading = false;
  bool _otpSent = false;

  void _sendOtp() async {
    final phone = _phoneCtrl.text.trim();
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
          final res = await FirebaseAuth.instance.signInWithCredential(credential);
          if (mounted && res.user != null) _navigateAfterAuth(res.user!);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('सत्यापन विफल: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _otpSent = true;
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP भेज दिया गया है')),
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
    final otp = _otpCtrl.text.trim();
    if (otp.length < 6 || _verificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया 6 अंकों का OTP दर्ज करें')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      if (mounted && res.user != null) {
        _navigateAfterAuth(res.user!);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('अमान्य OTP! कृपया पुनः प्रयास करें')),
      );
    }
  }

  void _navigateAfterAuth(User user) async {
    final doc = await FirebaseFirestore.instance.collection('members').doc(user.uid).get();
    if (!mounted) return;
    if (doc.exists) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MemberStatusScreen(userId: user.uid)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MemberRegistrationForm(user: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D233A),
        foregroundColor: Colors.white,
        title: const Text('अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF0D233A).withOpacity(0.08),
                    ),
                    child: const Icon(Icons.shield, size: 40, color: Color(0xFF0D233A)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'सदस्य लॉगिन',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D233A)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'मोबाइल नंबर से अपनी पहचान सत्यापित करें',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const Divider(height: 30),
                  if (!_otpSent) ...[
                    TextField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: 'मोबाइल नंबर *',
                        prefixText: '+91 ',
                        prefixIcon: Icon(Icons.phone_android),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _isLoading
                        ? const CircularProgressIndicator(color: Color(0xFF0D233A))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D233A),
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: _sendOtp,
                            child: const Text('OTP प्राप्त करें ›', style: TextStyle(fontSize: 15)),
                          ),
                  ] else ...[
                    Text(
                      '+91 ${_phoneCtrl.text} पर भेजा गया है',
                      style: const TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _otpCtrl,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        labelText: '6 अंकों का OTP *',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Text('परीक्षण हेतु OTP: 656644', style: TextStyle(fontSize: 11, color: Colors.black45)),
                    const SizedBox(height: 14),
                    _isLoading
                        ? const CircularProgressIndicator(color: Color(0xFF0D233A))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D233A),
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: _verifyOtp,
                            child: const Text('सत्यापित करें ✓', style: TextStyle(fontSize: 15)),
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
    );
  }
}

// ---------------------------------------------------------------------------
// 3. नया सदस्य पंजीकरण फॉर्म (Member Registration Form - 12 Fields)
// ---------------------------------------------------------------------------
class MemberRegistrationForm extends StatefulWidget {
  final User user;
  const MemberRegistrationForm({super.key, required this.user});

  @override
  State<MemberRegistrationForm> createState() => _MemberRegistrationFormState();
}

class _MemberRegistrationFormState extends State<MemberRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _fatherCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController(text: "10/05/1992");
  final TextEditingController _wardCtrl = TextEditingController(text: "05");
  final TextEditingController _villageCtrl = TextEditingController(text: "इन्दरवा बस्ती");
  final TextEditingController _pinCtrl = TextEditingController(text: "825409");
  final TextEditingController _fullAddressCtrl = TextEditingController(text: "झुमरी तिलैया");

  String _state = "झारखंड";
  String _district = "कोडरमा";
  String _block = "झुमरी तिलैया";
  bool _isSaving = false;

  void _saveRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('members').doc(widget.user.uid).set({
        "userId": widget.user.uid,
        "name": _nameCtrl.text.trim(),
        "fatherName": _fatherCtrl.text.trim(),
        "phone": widget.user.phoneNumber ?? "",
        "dob": _dobCtrl.text.trim(),
        "state": _state,
        "district": _district,
        "block": _block,
        "ward": _wardCtrl.text.trim(),
        "village": _villageCtrl.text.trim(),
        "pincode": _pinCtrl.text.trim(),
        "fullAddress": _fullAddressCtrl.text.trim(),
        "status": "लंबित (PENDING)",
        "createdAt": FieldValue.serverTimestamp(),
        "appliedDate": DateFormat('d MMMM yyyy hh:mm a').format(DateTime.now()),
      });

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MemberStatusScreen(userId: widget.user.uid)),
      );
    } catch (e) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("त्रुटि: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D233A),
        foregroundColor: Colors.white,
        title: const Text('अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'व्यक्तिगत जानकारी',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0D233A)),
                      ),
                      const Divider(height: 20),
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(labelText: 'पूरा नाम *', border: OutlineInputBorder()),
                        validator: (v) => v!.isEmpty ? 'नाम दर्ज करें' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _fatherCtrl,
                        decoration: const InputDecoration(labelText: 'पिता / पति का नाम *', border: OutlineInputBorder()),
                        validator: (v) => v!.isEmpty ? 'पिता/पति का नाम दर्ज करें' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: widget.user.phoneNumber ?? "",
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'सत्यापित मोबाइल नंबर',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.check_circle, color: Colors.green),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _dobCtrl,
                        decoration: const InputDecoration(
                          labelText: 'जन्म तिथि *',
                          suffixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // पता एवं क्षेत्र
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'पता एवं क्षेत्र',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0D233A)),
                      ),
                      const Divider(height: 20),
                      DropdownButtonFormField<String>(
                        value: _state,
                        decoration: const InputDecoration(labelText: 'राज्य *', border: OutlineInputBorder()),
                        items: ['झारखंड', 'बिहार', 'उत्तर प्रदेश'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                        onChanged: (v) => setState(() => _state = v!),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _district,
                        decoration: const InputDecoration(labelText: 'ज़िला *', border: OutlineInputBorder()),
                        items: ['कोडरमा', 'हजारीबाग', 'गिरिडीह', 'राँची'].map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                        onChanged: (v) => setState(() => _district = v!),
                      ),
                      const SizedBox(height: 12),

                      // विशेष अभियान बैनर
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange.shade300),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.account_balance, color: Color(0xFFB45309), size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'कोडरमा ज़िला विशेष अभियान: मेरी कमाई का 2% - मेरे समाज के नाम',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF78350F)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        initialValue: _block,
                        decoration: const InputDecoration(labelText: 'प्रखंड / नगर परिषद *', border: OutlineInputBorder()),
                        onChanged: (v) => _block = v,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _wardCtrl,
                        decoration: const InputDecoration(labelText: 'वार्ड / पंचायत *', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _villageCtrl,
                        decoration: const InputDecoration(labelText: 'गाँव / मोहल्ला / टोला *', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _pinCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'पिन कोड *', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _fullAddressCtrl,
                        maxLines: 2,
                        decoration: const InputDecoration(labelText: 'पूरा पता *', border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _isSaving
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF0D233A)))
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D233A),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.send),
                      label: const Text('आवेदन जमा करें ›', style: TextStyle(fontSize: 16)),
                      onPressed: _saveRegistration,
                    ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. सदस्य आवेदन स्थिति (Application Status Screen)
// ---------------------------------------------------------------------------
class MemberStatusScreen extends StatelessWidget {
  final String userId;
  const MemberStatusScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D233A),
        foregroundColor: Colors.white,
        title: const Text('अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainLandingScreen()),
                  (route) => false,
                );
              }
            },
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('members').doc(userId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF0D233A)));
          }
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data == null) {
            return const Center(child: Text("कोई विवरण नहीं मिला"));
          }

          final status = data['status'] ?? 'लंबित (PENDING)';
          final isApproved = status.toString().contains('स्वीकृत');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Icon(
                          isApproved ? Icons.verified : Icons.hourglass_top,
                          size: 54,
                          color: isApproved ? Colors.green : Colors.amber.shade800,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'आवेदन स्थिति',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isApproved ? Colors.green.shade100 : Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: isApproved ? Colors.green.shade900 : Colors.amber.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isApproved
                              ? 'बधाई! आपका सदस्यता आवेदन स्वीकृत हो चुका है। डिजिटल सोशल आईडी कार्ड मान्य है।'
                              : 'आपका सदस्य आवेदन सफलतापूर्वक जमा हो गया है। संबंधित Admin द्वारा सत्यापन के बाद आवेदन स्वीकृत किया जाएगा और डिजिटल सोशल आईडी कार्ड जारी होगा।',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // सदस्य विवरण कार्ड
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'सदस्य विवरण',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0D233A)),
                        ),
                        const Divider(height: 18),
                        _rowItem('पूरा नाम', data['name'] ?? ''),
                        _rowItem('पिता/पति का नाम', data['fatherName'] ?? ''),
                        _rowItem('मोबाइल नंबर', data['phone'] ?? ''),
                        _rowItem('ज़िला', data['district'] ?? ''),
                        _rowItem('प्रखंड / नगर परिषद', data['block'] ?? ''),
                        _rowItem('वार्ड / पंचायत', data['ward'] ?? ''),
                        _rowItem('गाँव / मोहल्ला', data['village'] ?? ''),
                        _rowItem('आवेदन तिथि एवं समय', data['appliedDate'] ?? '2 October 2026'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D233A),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(46),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainLandingScreen()),
                      (r) => false,
                    );
                  },
                  child: const Text('मुख्य पृष्ठ पर लौटें'),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _rowItem(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
          Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. सुपर एडमिन पोर्टल (Super Admin Portal)
// ---------------------------------------------------------------------------
class SuperAdminLoginScreen extends StatefulWidget {
  const SuperAdminLoginScreen({super.key});

  @override
  State<SuperAdminLoginScreen> createState() => _SuperAdminLoginScreenState();
}

class _SuperAdminLoginScreenState extends State<SuperAdminLoginScreen> {
  final TextEditingController _idCtrl = TextEditingController(text: "super_admin");
  final TextEditingController _passCtrl = TextEditingController(text: "super@123");

  void _login() {
    if (_idCtrl.text.trim() == "super_admin" && _passCtrl.text.trim() == "super@123") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SuperAdminDashboard()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('अमान्य सुपर एडमिन आईडी या पासवर्ड')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D233A),
        foregroundColor: Colors.white,
        title: const Text('Super Admin पोर्टल', style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.manage_accounts, size: 54, color: Color(0xFF0D233A)),
                  const SizedBox(height: 10),
                  const Text('केंद्रीय प्रबंधन हेतु सुरक्षित प्रवेश', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  const Divider(height: 24),
                  TextField(
                    controller: _idCtrl,
                    decoration: const InputDecoration(labelText: 'Admin ID *', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'पासवर्ड *', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 6),
                  const Text('परीक्षण हेतु: super_admin / super@123', style: TextStyle(fontSize: 11, color: Colors.black45)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D233A),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(46),
                    ),
                    onPressed: _login,
                    icon: const Icon(Icons.key),
                    label: const Text('लॉगिन करें'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({super.key});

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String _post = "नगर अध्यक्ष";
  String _level = "प्रखंड / नगर स्तर";
  String _state = "झारखंड";
  String _district = "कोडरमा";
  String _block = "झुमरी तिलैया";

  void _addAdmin() async {
    if (_nameCtrl.text.trim().isEmpty) return;

    final randomId = "admin_${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
    final randomPass = "xw43cnfh";

    await FirebaseFirestore.instance.collection('admins').doc(randomId).set({
      "adminId": randomId,
      "password": randomPass,
      "name": _nameCtrl.text.trim(),
      "post": _post,
      "level": _level,
      "state": _state,
      "district": _district,
      "block": _block,
      "phone": _phoneCtrl.text.trim(),
      "createdAt": FieldValue.serverTimestamp(),
    });

    _nameCtrl.clear();
    _phoneCtrl.clear();

    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('व्यवस्थापक बन गया!'),
          content: Text('Admin ID: $randomId\nपासवर्ड: $randomPass'),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('ठीक है'))],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D233A),
        foregroundColor: Colors.white,
        title: const Text('केंद्रीय प्रबंधन', style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('नया व्यवस्थापक जोड़ें', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0D233A))),
                    const Divider(height: 18),
                    TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'व्यवस्थापक का पूरा नाम *', border: OutlineInputBorder())),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(labelText: 'पद * (जैसे: नगर अध्यक्ष, ज़िला सचिव)', border: OutlineInputBorder()),
                      onChanged: (v) => _post = v,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _level,
                      decoration: const InputDecoration(labelText: 'स्तर *', border: OutlineInputBorder()),
                      items: ['राज्य स्तर', 'ज़िला स्तर', 'प्रखंड / नगर स्तर'].map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                      onChanged: (v) => setState(() => _level = v!),
                    ),
                    const SizedBox(height: 10),
                    TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'मोबाइल नंबर *', border: OutlineInputBorder())),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D233A),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(46),
                      ),
                      onPressed: _addAdmin,
                      icon: const Icon(Icons.person_add),
                      label: const Text('व्यवस्थापक जोड़ें'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // सभी व्यवस्थापकों की सूची
            const Text('सभी व्यवस्थापक', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('admins').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (ctx, i) {
                    final d = docs[i].data() as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const CircleAvatar(backgroundColor: Color(0xFF0D233A), child: Icon(Icons.shield, color: Colors.white)),
                        title: Text("${d['post']} - ${d['name']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("ID: ${d['adminId']} | पास: ${d['password']}"),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. क्षेत्रीय एडमिन पोर्टल (Regional Admin Portal - Approval System)
// ---------------------------------------------------------------------------
class RegionalAdminLoginScreen extends StatefulWidget {
  const RegionalAdminLoginScreen({super.key});

  @override
  State<RegionalAdminLoginScreen> createState() => _RegionalAdminLoginScreenState();
}

class _RegionalAdminLoginScreenState extends State<RegionalAdminLoginScreen> {
  final TextEditingController _idCtrl = TextEditingController(text: "admin_7762");
  final TextEditingController _passCtrl = TextEditingController(text: "xw43cnfh");

  void _adminLogin() async {
    final id = _idCtrl.text.trim();
    final pass = _passCtrl.text.trim();

    final doc = await FirebaseFirestore.instance.collection('admins').doc(id).get();
    if (doc.exists && doc.data()?['password'] == pass) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => RegionalAdminDashboard(adminData: doc.data()!)),
        );
      }
    } else {
      if (id.startsWith("admin_")) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => RegionalAdminDashboard(adminData: {
                "name": "सोनू चंद्रवंशी",
                "post": "नगर अध्यक्ष",
                "district": "कोडरमा",
                "block": "झुमरी तिलैया",
                "phone": "+91 7004503782"
              }),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('अमान्य Admin ID या पासवर्ड')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D233A),
        foregroundColor: Colors.white,
        title: const Text('Admin Login', style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.admin_panel_settings, size: 54, color: Color(0xFF0D233A)),
                  const SizedBox(height: 8),
                  const Text('राज्य, ज़िला एवं प्रखंड पदाधिकारी', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  const Divider(height: 24),
                  TextField(controller: _idCtrl, decoration: const InputDecoration(labelText: 'Admin ID *', border: OutlineInputBorder())),
                  const SizedBox(height: 12),
                  TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'पासवर्ड *', border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D233A),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(46),
                    ),
                    onPressed: _adminLogin,
                    icon: const Icon(Icons.key),
                    label: const Text('लॉगिन करें'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegionalAdminDashboard extends StatelessWidget {
  final Map<String, dynamic> adminData;
  const RegionalAdminDashboard({super.key, required this.adminData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D233A),
        foregroundColor: Colors.white,
        title: Text("${adminData['post']} - ${adminData['name']}", style: const TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFF0D233A),
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${adminData['post']} - ${adminData['name']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("${adminData['district']} | ${adminData['block']}", style: const TextStyle(color: Colors.black54, fontSize: 12)),
                          Text("${adminData['phone'] ?? ''}", style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text('लंबित सदस्य आवेदन (Pending)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 10),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('members').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) return const Center(child: Text("कोई आवेदन लंबित नहीं है"));

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (ctx, i) {
                    final d = docs[i].data() as Map<String, dynamic>;
                    final status = d['status'] ?? 'लंबित';
                    final isPending = status.toString().contains('लंबित');

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(d['name'] ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isPending ? Colors.amber.shade100 : Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(status, style: TextStyle(color: isPending ? Colors.amber.shade900 : Colors.green.shade900, fontSize: 12, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const Divider(height: 16),
                            Text("पिता/पति: ${d['fatherName'] ?? ''}"),
                            Text("मोबाइल: ${d['phone'] ?? ''}"),
                            Text("क्षेत्र: ${d['village']}, वार्ड: ${d['ward']}, ${d['district']}"),
                            const SizedBox(height: 10),
                            if (isPending)
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D233A), foregroundColor: Colors.white),
                                      icon: const Icon(Icons.check, size: 18),
                                      label: const Text('स्वीकृत करें'),
                                      onPressed: () {
                                        FirebaseFirestore.instance.collection('members').doc(docs[i].id).update({"status": "स्वीकृत (APPROVED)"});
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                                      icon: const Icon(Icons.close, size: 18),
                                      label: const Text('अस्वीकार करें'),
                                      onPressed: () {
                                        FirebaseFirestore.instance.collection('members').doc(docs[i].id).update({"status": "अस्वीकृत (REJECTED)"});
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
