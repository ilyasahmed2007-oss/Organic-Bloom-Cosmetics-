import 'package:flutter/material.dart';

void main() {
  runApp(const VyaparCloneApp());
}

class VyaparCloneApp extends StatelessWidget {
  const VyaparCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organic Bloom Billing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00C853),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00C853)),
        useMaterial3: true,
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
  int _selectedIndex = 0;
  List<Map<String, String>> parties = [
    {'name': 'Ali Traders', 'balance': 'Rs 0'},
    {'name': 'Ahmed Sons', 'balance': 'Rs 0'},
    {'name': 'Cash Customer', 'balance': 'Rs 0'},
  ];

  final List<String> _titles = [
    'All Parties',
    'Items',
    'Reports',
    'Sale',
    'Purchase',
    'Cash & Bank'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: const Color(0xFF00C853),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF00C853)),
              accountName: const Text('Organic Bloom'),
              accountEmail: const Text('owner@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.store, color: Color(0xFF00C853), size: 40),
              ),
            ),
            _drawerItem(Icons.people, 'Parties', 0),
            _drawerItem(Icons.inventory_2, 'Items', 1),
            _drawerItem(Icons.bar_chart, 'Reports', 2),
            _drawerItem(Icons.receipt, 'Sale', 3),
            _drawerItem(Icons.shopping_cart, 'Purchase', 4),
            _drawerItem(Icons.account_balance_wallet, 'Cash & Bank', 5),
          ],
        ),
      ),
      body: _selectedIndex == 0
         ? PartiesScreen(
              parties: parties,
              onAddParty: _addParty,
            )
          : Center(child: Text('${_titles[_selectedIndex]} Screen - جلد آ رہی ہے')),
    );
  }

  ListTile _drawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: _selectedIndex == index? Color(0xFF00C853) : Colors.grey),
      title: Text(title, style: TextStyle(
        color: _selectedIndex == index? Color(0xFF00C853) : Colors.black87,
        fontWeight: _selectedIndex == index? FontWeight.bold : FontWeight.normal,
      )),
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context);
      },
    );
  }

  void _addParty() {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Party'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Party Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00C853)),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    parties.add({'name': nameController.text, 'balance': 'Rs 0'});
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

class PartiesScreen extends StatelessWidget {
  final List<Map<String, String>> parties;
  final VoidCallback onAddParty;

  const PartiesScreen({super.key, required this.parties, required this.onAddParty});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search parties...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: parties.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text(parties[index]['name']![0])),
                title: Text(parties[index]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(parties[index]['balance']!, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('ADD NEW PARTY', style: TextStyle(color: Colors.white, fontSize: 16)),
            onPressed: onAddParty,
          ),
        ),
      ],
    );
  }
}
