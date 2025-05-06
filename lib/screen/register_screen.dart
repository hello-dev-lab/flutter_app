import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admin_front/api_path.dart';
import 'package:admin_front/model/user_model.dart';
import 'package:admin_front/services/user_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  List<UserModel> users = [];
  List<UserModel> filteredUsers = [];
  bool showPassword = false;
  bool isLoading = false;
  bool isUpdateMode = false;
  int? updatingUserId;
  bool _showSearchBar = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUser();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _fetchUser() async {
    final String apiUrl = ApiPath.getAll;
    try {
      final response = await http
          .get(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> userList = data['users'];
        setState(() {
          users = userList.map((x) => UserModel.fromJson(x)).toList();
          filteredUsers = users;
        });
      } else {
        throw Exception("Failed to load users");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> _registerOrUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      if (isUpdateMode && updatingUserId != null) {
        final response = await UserServices.updateUser(
          id: updatingUserId!,
          userName: usernameController.text,
          email: emailController.text,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('User updated')));
          setState(() {
            isUpdateMode = false;
            updatingUserId = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Update failed: ${response.body}')),
          );
        }
      } else {
        final response = await UserServices.SignUp(
          email: emailController.text,
          password: passwordController.text,
          userName: usernameController.text,
        );

        if (response.statusCode == 201) {
          final responseBody = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                responseBody['message'] ?? 'Registration successful!',
              ),
            ),
          );
        } else {
          final responseBody = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseBody['error'] ?? 'Registration failed!'),
            ),
          );
        }
      }

      emailController.clear();
      passwordController.clear();
      usernameController.clear();
      _fetchUser();
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Network error.')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _editUser(UserModel user) {
    setState(() {
      usernameController.text = user.userName ?? '';
      emailController.text = user.email ?? '';
      passwordController.clear();
      isUpdateMode = true;
      updatingUserId = user.id;
    });
  }

  void _cancelUpdate() {
    setState(() {
      isUpdateMode = false;
      updatingUserId = null;
      emailController.clear();
      passwordController.clear();
      usernameController.clear();
    });
  }

  Future<void> _deleteUser(int id) async {
    // Show the confirmation dialog before deleting
    bool shouldDelete = await _showDeleteConfirmationDialog();

    if (!shouldDelete) return; // If user cancels, do not proceed with deletion

    try {
      final response = await UserServices.deleteUser(id);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User deleted')));
        _fetchUser();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Delete failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error deleting user')));
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible:
              false, // Prevent dismissing the dialog by tapping outside
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Deletion'),
              content: const Text('Are you sure you want to delete this user?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(false); // Return false when 'No' is pressed
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(true); // Return true when 'Yes' is pressed
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false; // If the user taps outside the dialog, return false
  }

  void _filterUsers() {
    final keyword = _searchController.text.toLowerCase();
    setState(() {
      filteredUsers =
          users.where((user) {
            final name = user.userName?.toLowerCase() ?? '';
            final email = user.email?.toLowerCase() ?? '';
            return name.contains(keyword) || email.contains(keyword);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(_showSearchBar ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
                if (!_showSearchBar) {
                  _searchController.clear();
                  filteredUsers = users;
                }
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _showSearchBar ? 60 : 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:
                        _showSearchBar
                            ? TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Search by username or email',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            )
                            : null,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    validator: (value) {
                      if (!isUpdateMode) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                      }
                      return null;
                    },
                    enabled: !isUpdateMode,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: IconButton(
                        onPressed:
                            () => setState(() => showPassword = !showPassword),
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: usernameController,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Username is required'
                                : null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _registerOrUpdate,
                          child:
                              isLoading
                                  ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                  : Text(isUpdateMode ? "Update" : "Register"),
                        ),
                      ),
                      if (isUpdateMode) const SizedBox(width: 10),
                      if (isUpdateMode)
                        ElevatedButton(
                          onPressed: _cancelUpdate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                          child: const Text("Cancel Update"),
                        ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: Row(
                      children: const [
                        Expanded(child: Text('ID')),
                        Expanded(child: Text('User')),
                        SizedBox(width: 60),
                        Expanded(child: Text('Action')),
                      ],
                    ),
                  ),
                  if (filteredUsers.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "Don't have this user",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    )
                  else
                    ...filteredUsers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final user = entry.value;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text((index + 1).toString()),
                            ), // Show index instead of user.id
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.userName ?? ''),
                                  Text(user.email ?? ''),
                                  Text(user.createdAt ?? ''),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                    onPressed: () => _editUser(user),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _deleteUser(user.id!),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
