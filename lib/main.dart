import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organic Bloom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
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

  final List<Widget> _screens = [
    const HomeTab(),
    const ProductsTab(),
    const TipsTab(),
    const ContactTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organic Bloom Cosmetics'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Tips'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Contact'),
        ],
      ),
    );
  }
}

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _productCard('Herbal Hair Oil', 'بالم کے لیے خالص تیل', 'Rs. 850'),
        _productCard('Aloe Vera Gel', 'جلد کے لیے قدرتی جیل', 'Rs. 650'),
        _productCard('Neem Face Wash', 'دانوں کے لیے صابن', 'Rs. 550'),
        _productCard('Henna Powder', 'بالوں کے لیے مہندی', 'Rs. 450'),
      ],
    );
  }

  Widget _productCard(String name, String desc, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(Icons.spa, size: 40, color: Colors.green.shade700),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
        trailing: Text(price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
      ),
    );
  }
}

class TipsTab extends StatelessWidget {
  const TipsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text('ہفتے میں 2 بار تیل لگائیں'),
          subtitle: Text('گرم تیل سے مساج کریں، 2 گھنٹے بعد دھو لیں'),
        ),
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text('زیادہ پانی پئیں'),
          subtitle: Text('دن میں 8-10 گلاس پانی جلد کے لیے بہترین'),
        ),
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text('کیمیکل شیمپو سے بچیں'),
          subtitle: Text('قدرتی شیمپو یا بیسن استعمال کریں'),
        ),
        ListTile(
          leading: Icon(Icons.check_circle, color: Icon(Icons.check_circle, color: Colors.green),
          title: Text('رات کو نیند پوری کریں'),
          subtitle: Text('7-8 گھنٹے کی نیند بالوں کے لیے ضروری'),
        ),
      ],
    );
  }
}

class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Contact Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.green.shade700),
                    title: const Text('Phone/WhatsApp'),
                    subtitle: const Text('+92 300 1234567'),
                  ),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.green.shade700),
                    title: const Text('Email'),
                    subtitle: const Text('organicbloom@email.com'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.green.shade700),
                    title: const Text('Address'),
                    subtitle: const Text('Karachi, Pakistan'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Order on WhatsApp'),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.spa, size: 80, color: Colors.green.shade700),
          const SizedBox(height: 20),
          const Text(
            'Welcome to Organic Bloom',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'قدرتی خوبصورتی، قدرتی طریقے',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
