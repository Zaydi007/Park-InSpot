import 'package:flutter/material.dart';
import './login_page.dart';
import './signin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park-inspot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ParkInspotHomePage(),
    );
  }
}

class ParkInspotHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Park-inspot'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Add functionality for settings button
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Add functionality for info button
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/Untitled design.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Welcome to Park Inspot!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 255, 255, 255), // Set the button color to white
                ),
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 255, 255), // Set the button color to white
                ),
                child: Text('Sign Up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}