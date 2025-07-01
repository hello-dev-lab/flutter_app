import 'package:flutter/material.dart';
import 'package:admin_front/pages/Dashboard/dashboard_page/add_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Example products
  final List<Map<String, String>> products = [
    {
      'name': 'Mechanical Keyboard',
      'price': '\$200',
      'description': 'asdfghjklertyuicghsdfgh',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvWqCcNOumTuqAHEiWYkdwM6OUyvKEwdP9dA&s',
    },
    {
      'name': 'Gaming Mouse',
      'price': '\$100',
      'description': 'asdfghjklertyuicghsdfgh',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvWqCcNOumTuqAHEiWYkdwM6OUyvKEwdP9dA&s',
    },
    {
      'name': 'Headphones',
      'price': '\$150',
      'description': 'asdfghjklertyuicghsdfgh',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvWqCcNOumTuqAHEiWYkdwM6OUyvKEwdP9dA&s',
    },
    {
      'name': 'Monitor',
      'price': '\$300',
      'description': 'asdfghjklertyuicghsdfgh',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvWqCcNOumTuqAHEiWYkdwM6OUyvKEwdP9dA&s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.add, size: 40),
              onPressed: () {
                Navigator.pushNamed(context, '/addproduct');
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return InkWell(
              onTap: () {
              },
              borderRadius: BorderRadius.circular(15),
              child: Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.network(
                            product['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product['price']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product['description']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
