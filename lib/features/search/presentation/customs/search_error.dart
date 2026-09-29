import 'package:flutter/material.dart';
import 'package:graduateproject/core/colors/Appcolors.dart';

class SearchError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const SearchError({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              color: Appcolor.yellow,
              size: 50,
            ),

            const SizedBox(height: 14),

            const Text(
              'Unable to search movies',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Appcolor.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white54, fontSize: 11),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.yellow,
                foregroundColor: Appcolor.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
