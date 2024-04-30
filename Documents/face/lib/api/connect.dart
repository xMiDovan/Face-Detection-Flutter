// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> registerUser(String username, String email, String password) async {
  // Prepare the request JSON
  final requestData = <String, String>{
    'email': email,
    'username': username,
    'password': password,
  };

  // Print the request JSON
  print('Request JSON: ${jsonEncode(requestData)}');

  // Make the HTTP request
  final response = await http.post(
    Uri.parse('https://mthesis.com/face/signup.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
  // Parse and print the JSON response
  final jsonResponse = jsonDecode(response.body);
  final message = jsonResponse['message']; // Access the 'message' field
  print('$message');
  return '$message';
} else {
  print('Failed to register user. ${response.body}');
  return 'Failed to register user. ${response.body}';
}
}

Future<String> loginUser(String email, String password) async {
  // Prepare the request JSON
  final requestData = <String, String>{
    'email': email,
    'password': password,
  };

  // Print the request JSON
  print('Login Request JSON: ${jsonEncode(requestData)}');

  // Make the HTTP request
  final response = await http.post(
    Uri.parse('https://mthesis.com/face/login.php'), // Change to your API endpoint
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    // Parse and print the JSON response
    final jsonResponse = jsonDecode(response.body);
    final message = jsonResponse['message']; // Access the 'message' field
    print('Login successful. Token:');
    print('$message');
    return '$message';
  } else {
    print('Login failed. ${response.body}');
    return '';
  }
}