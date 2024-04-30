// ignore_for_file: unnecessary_null_comparison, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'table_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController2 = TextEditingController();
  late WebViewController webViewController;
  String defaultWebViewUrl = 'proxy65.rt3.io';
  String webViewUrl = 'http://proxy65.rt3.io';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            // WebView
            Container(
              height: 250, // Adjust the height as needed
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
              ),
            ),
            // Inputs
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  TextField(
                    controller: textController2,
                    decoration: InputDecoration(
                      labelText: 'Port',
                      hintText: 'Enter the port for the camera',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle the first button press
                          String input2 = textController2.text;
                          updateWebViewUrl(input2);
                        },
                        child: Text('Set Link'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the second button press
                          String input2 = textController2.text;
                          print('Button 2 Pressed: $input2');
      
                          // Navigate to TableScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TableScreen()),
                          );
                        },
                        child: Text('History'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateWebViewUrl(String port) async {
    setState(() {
      webViewUrl = '$defaultWebViewUrl:$port/camera';
    });

    if (webViewController != null) {
      await webViewController.runJavascript('window.location.href="http://$webViewUrl";');
    }
  }
}