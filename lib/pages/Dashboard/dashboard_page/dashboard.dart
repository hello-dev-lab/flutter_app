import 'package:flutter/material.dart';
import 'package:admin_front/pages/Dashboard/dashboard_page/product_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _HomeState();
}

class _HomeState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Container(),
                      ),
                    );
                  },
                  child: const _StatCard(
                    title: 'Total orders',
                    value: '20.000',
                    icon: Icons.shopping_cart,
                    color: Color(0xFF6C91D5),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Container(),
                      ),
                    );
                  },
                  child: const _StatCard(
                    title: 'Total Customers',
                    value: '2,000',
                    color: Color(0xFF8ECACA),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(),
                      ),
                    );
                  },
                  child: const _StatCard(
                    title: 'Total Products',
                    value: '400',
                    color: Color.fromARGB(255, 82, 74, 68),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Container(),
                      ),
                    );
                  },
                  child: const _StatCard(
                    title: 'Total Cate',
                    value: '-',
                    color: Color(0xFF8C7DBA),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final String initial;
  final String name;
  final String date;
  final String total;

  const _OrderItem({
    required this.initial,
    required this.name,
    required this.date,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF414A62),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(initial, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white)),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(
            'Total:\n$total',
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
