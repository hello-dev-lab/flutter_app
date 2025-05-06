import 'package:flutter/material.dart';
import 'package:admin_front/screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void showDailog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "ແຈ້ງສະຖານະການເຂົ້າ internet",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("connect internet"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'First Input'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Second Input'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Third Input'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Cancel action (close dialog)
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // OK action
                          print("OK pressed");
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget popuMentBTN() {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'wifi') {
          showDailog(); // Show dialog when wifi is selected
        } else if (value == 'logout') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
        // Add more conditions if needed
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'wifi', // Add a value to identify this item
              child: ListTile(
                leading: Icon(Icons.wifi, color: Colors.green),
                title: Text('Wifi'),
              ),
            ),
            PopupMenuItem(
              value: 'profile',
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text('Profile'),
              ),
            ),
            PopupMenuItem(
              value: 'label',
              child: ListTile(
                leading: Icon(Icons.new_label, color: Colors.green),
                title: Text('Label'),
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.next_week, color: Colors.green),
                title: Text('Logout'),
              ),
            ),
          ],
      icon: Icon(Icons.more_vert),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລະບົບຂາຍສິນຄ້າ'),
        backgroundColor: Colors.blue,
        actions: [popuMentBTN()],
      ),
    );
  }
}
