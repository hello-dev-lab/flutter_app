import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Icon Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _TopIcon(icon: Icons.bar_chart, label: 'Analyties'),
                _TopIcon(icon: Icons.person, label: 'Customers'),
                _TopIcon(icon: Icons.receipt, label: 'Orders'),
                _TopIcon(icon: Icons.task, label: 'Tasks'),
              ],
            ),
            const SizedBox(height: 24),

            // Stats Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: const [
                _StatCard(
                  title: 'Total orders',
                  value: '20.000',
                  icon: Icons.shopping_cart,
                  color: Color(0xFF6C91D5),
                ),
                _StatCard(
                  title: 'Total Customers',
                  value: '2,000',
                  color: Color(0xFF8ECACA),
                ),
                _StatCard(
                  title: 'Total Products',
                  value: '400',
                  color: Color(0xFFA89D94),
                ),
                _StatCard(
                  title: 'Total Cate',
                  value: '-',
                  color: Color(0xFF8C7DBA),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Orders
            const Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const _OrderItem(initial: 'M', name: 'Name', date: '12/3/2025', total: '200,000 Kip'),
            const SizedBox(height: 10),
            const _OrderItem(initial: 'Y', name: 'Name', date: '12/3/2025', total: '200,000 Kip'),
          ],
        ),
      ),
    );
  }
}

class _TopIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TopIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white24,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

  const _OrderItem({required this.initial, required this.name, required this.date, required this.total});

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