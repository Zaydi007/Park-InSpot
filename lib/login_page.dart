import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import './user.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        color: Color(0xFFA7AEDA),
        child: Center(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Log In',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: 'Jellyfish Lot',
                    onChanged: (String? newValue) {},
                    items: <String>[
                      'Jellyfish Lot',
                      'Turtle Cove Lot',
                      'Curlew Lot',
                      'Seahorse Lot',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Select Parking Lot',
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: 'Motorcycle',
                    onChanged: (String? newValue) {},
                    items: <String>['Motorcycle', 'Car', 'Disabled']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Select Vehicle Type',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement log in logic
                    },
                    child: Text('Log In'),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}