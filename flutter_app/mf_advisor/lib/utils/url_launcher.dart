import 'package:flutter/material.dart';

class UrlLauncher {
  static void openUrl(BuildContext context, String url, String fundName) {
    // For now, show snackbar with URL
    // To actually open browser, add url_launcher package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening: $url'),
        action: SnackBarAction(
          label: 'Copy',
          onPressed: () {
            // Copy to clipboard functionality
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
