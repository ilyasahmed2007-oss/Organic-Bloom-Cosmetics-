import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organic Bloom Billing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const BillingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Product {
  final String name;
  final double price;
  Product({required this.name, required this.price});
}

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final TextEditingController customerNameController = TextEditingController();

  // 👇 یہاں اپنے products کے نام اور ریٹ ڈال دیں
  final List<Product> products = [
    Product(name: 'Herbal Hair Oil 100ml', price: 850),
    Product(name: 'Aloe Vera Gel 200g', price: 650),
    Product(name: 'Neem Face Wash', price: 550),
    Product(name: 'Henna Powder 100g', price: 450),
    Product(name: 'Organic Soap', price: 350),
  ];

  List<int> quantities = [];
  double discount = 0;

  @override
  void initState() {
    super.initState();
    quantities = List.generate(products.length, (index) => 0);
  }

  double get total {
    double sum = 0;
    for (int i = 0; i < products.length; i++) {
      sum += products[i].price * quantities[i];
    }
    return sum - discount;
  }

  void sendWhatsApp() async {
    if (customerNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('پہلے کسٹمر کا نام لکھیں')),
      );
      return;
    }

    String bill = 'Organic Bloom Bill\n';
    bill += 'Customer: ${customerNameController.text}\n\n';
    bill += 'Items:\n';

    for (int i = 0; i < products.length; i++) {
      if (quantities[i] > 0) {
        bill += '${products[i].name} x ${quantities[i]} = Rs.${products[i].price * quantities[i]}\n';
      }
    }

    bill += '\nDiscount: Rs.$discount';
    bill += '\nTotal: Rs.${total.toStringAsFixed(0)}';

    final Uri url = Uri.parse('https://wa.me/?text=${Uri.encodeComponent(bill)}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organic Bloom Billing'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: customerNameController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    title: Text(products[index].name),
                    subtitle: Text('Rs.${products[index].price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () {
                            setState(() {
                              if (quantities[index] > 0) quantities[index]--;
                            });
                          },
                        ),
                        Text('${quantities[index]}', style: const TextStyle(fontSize: 18)),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: Colors.green),
                          onPressed: () {
                            setState(() => quantities[index]++);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Discount: Rs.', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) => setState(() => discount = double.tryParse(val)?? 0),
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('Rs.${total.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: sendWhatsApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Send Bill on WhatsApp', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
