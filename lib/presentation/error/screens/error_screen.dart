// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import '../../widgets/body_text.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});

  final GoException error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BodyText(
                text: 'An error occurred:',
                fontSize: 18,
              ),
              SizedBox(height: 15.v),
              BodyText(
                text: error.toString(),
                fontSize: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle the error and navigate to a different screen or perform any other action
                },
                child: const BodyText(text: 'Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
