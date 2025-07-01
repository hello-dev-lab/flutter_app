import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String dropdownValue = 'Apple';
  List<String> items = ['Apple', 'Banana', 'Orange', 'Grapes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo, color: Colors.black),
                      iconSize: 60,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Product Price',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Original Price',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      value: dropdownValue,
                      isExpanded: true,
                      underline: Container(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      
                      items:
                          items.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add Product'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
