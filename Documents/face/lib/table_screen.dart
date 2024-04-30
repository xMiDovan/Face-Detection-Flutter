// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'display_images.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://mthesis.com/face/view_face.php'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = json.decode(response.body);
        print('Response Body: ${response.body}');

        // Update the tableData list with the parsed data
        setState(() {
          tableData = List<Map<String, dynamic>>.from(jsonData);
        });
      } else {
        // Handle non-200 status code
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Handle the first button press
              // String input2 = textController2.text;
              // updateWebViewUrl(input2);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImageListPage()),
              );

            },
            child: Text('Images'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.blue,
          ),
          dataTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          columns: [
            DataColumn(
              label: Text('Name'),
              tooltip: 'Name of the person',
            ),
            DataColumn(
              label: Text('Date'),
              tooltip: 'Date of the record',
            ),
            DataColumn(
              label: Text('Time'),
              tooltip: 'Time of the record',
            ),
            // Add more columns as needed
          ],
          rows: tableData.map((data) {
            return DataRow(
              cells: [
                DataCell(
                  Text('${data['name'] ?? 'N/A'}'),
                  onTap: () {
                    // Handle cell tap for 'Name'
                  },
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text('${data['dates'] ?? 'N/A'}'),
                  // Customize individual cell styles here if needed
                ),
                DataCell(
                  Text('${data['times'] ?? 'N/A'}'),
                  // Customize individual cell styles here if needed
                ),
                // Add more cells as needed based on your data structure
              ],
              
            );
          }).toList(),
        ),
      ),
    );
  }
}
