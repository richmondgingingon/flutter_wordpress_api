import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/services/shared_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WordPress Dashboard"),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              SharedService.logout(context);
            },
          ),
          SizedBox(
            width: 10,
          )
        ]
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text("Welcome to Dashboard"),
      )
    );
  }
}