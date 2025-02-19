import 'package:flutter/material.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temp Page'),
      ),
      body: const Center(
        child: Text('This is a temporary page'),
      ),
    );
  }
}
