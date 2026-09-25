import 'package:flutter/material.dart';

void main() {
  runApp(const ChandravanshiMahasabhaApp());
}

class ChandravanshiMahasabhaApp extends StatelessWidget {
  const ChandravanshiMahasabhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6B0000), // गहरा महरून रंग
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B0000),
          secondary: const Color(0xFFD4AF37), // सुनहरा रंग
        ),
        useMaterial3: true,
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const DirectoryTab(),
    const RulesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B0000),
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "चंद्रवंशी क्षत्रिय महासभा",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "स्थापना 1906 • निबंधन 2145/30/1912",
              style: TextStyle(fontSize: 11, color: Color(0xFFD4AF37)),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF6B0000),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "मुख्य पृष्ठ"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "परिवार सूची"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "नियमावली"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "आईडी कार्ड"),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(Icons.account_balance, size: 48, color: Color(0xFF6B0000)),
                const SizedBox(height: 10),
                const Text(
                  "अखिल भारतवर्षीय चंद्रवंशी क्षत्रिय महासभा",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "डिजिटल समाज पोर्टल • अखंड एकता, स्वाभिमान व विकास",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard("मासिक अंशदान", "₹50"),
                    _buildStatCard("इकाई स्थिति", "वार्ड 05 सक्रिय"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6B0000))),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class DirectoryTab extends StatelessWidget {
  const DirectoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          "पारिवारिक डायरेक्टरी (ड्रिल-डाउन)",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6B0000)),
        ),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: const Icon(Icons.flag, color: Color(0xFF6B0000)),
            title: const Text("🇮🇳 भारत > झारखंड > कोडरमा"),
            subtitle: const Text("झुमरी तिलैया • वार्ड 05 असना इंदरवा"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class RulesTab extends StatelessWidget {
  const RulesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        Text(
          "महासभा संविधान व नियमावली",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6B0000)),
        ),
        SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Icon(Icons.gavel, color: Color(0xFF6B0000)),
            title: Text("राष्ट्रीय महासभा निबंधन"),
            subtitle: Text("सं० 2145/30/1912 (कोलकाता उच्च न्यायालय अधिकार क्षेत्र)"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.rule, color: Color(0xFF6B0000)),
            title: Text("मासिक सदस्यता एवं अंशदान नियम"),
            subtitle: Text("प्रत्येक परिवार प्रमुख द्वारा ₹50 मासिक अंशदान अनिवार्य"),
          ),
        ),
      ],
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundColor: Color(0xFF6B0000),
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text("डिजिटल पहचान पत्र (ID Card)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text("वार्ड 05, इंदरवा बस्ती इकाई", style: TextStyle(color: Colors.grey)),
                const Divider(height: 24),
                const Text("सत्यापित सदस्य", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
