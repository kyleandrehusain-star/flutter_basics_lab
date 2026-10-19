// Activity 4: Advanced layouts with Stack, ListView and GridView
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const CafeApp());
}

// 1. The data: a simple Dart class and two lists
class CafeItem {
  const CafeItem(this.name, this.price, this.icon, {this.bestSeller = false});

  final String name;
  final double price;
  final IconData icon;
  final bool bestSeller;
}

const List<CafeItem> menu = [
  CafeItem('Iced Coffee', 85, Icons.local_cafe, bestSeller: true),
  CafeItem('Hot Chocolate', 75, Icons.coffee),
  CafeItem('Fruit Shake', 90, Icons.local_drink, bestSeller: true),
  CafeItem('Cheeseburger', 120, Icons.lunch_dining),
  CafeItem('Fries', 60, Icons.fastfood),
  CafeItem('Ensaymada', 45, Icons.bakery_dining),
  // <-- my two extra menu items; the second one is a best seller
  CafeItem('Ice Cream', 55, Icons.icecream),
  CafeItem('Cake Slice', 65, Icons.cake, bestSeller: true),
];

const List<String> categories = ['All', 'Drinks', 'Snacks', 'Meals', 'Desserts'];

class CafeApp extends StatelessWidget {
  const CafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: studentColor),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Activity 4 - $studentName')),
      body: Column(
        children: [
          // 2. Banner: a Stack puts widgets on top of each other
          Stack(
            children: [
              Container(height: 140, width: double.infinity, color: colors.primaryContainer),
              Positioned(
                right: -10,
                bottom: -20,
                child: Icon(Icons.local_cafe, size: 160, color: colors.primary.withAlpha(60)),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Text(
                  'Campus Café',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'OPEN',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

          // 3. Categories: a horizontal ListView that scrolls sideways
          SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Chip(label: Text(categories[index])),
            ),
          ),

          // 4. Menu: a GridView with 2 columns that fills the remaining space
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: menu.length,
              itemBuilder: (context, index) => MenuCard(item: menu[index]),
            ),
          ),
        ],
      ),
    );
  }
}

// 5. One menu card; a Stack adds the "Best seller" badge on top
class MenuCard extends StatelessWidget {
  const MenuCard({super.key, required this.item});

  final CafeItem item;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Card(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, size: 56, color: colors.primary),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('₱${item.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
          if (item.bestSeller)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Best seller',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
