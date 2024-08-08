import 'package:flutter/material.dart';

class KeyValueCard extends StatelessWidget {
  final String keyText;
  final String valueText;
  final double elevation;
  final Color shadowColor;
  final VoidCallback? onDelete;

  const KeyValueCard({
    super.key,
    required this.keyText,
    required this.valueText,
    this.elevation = 0.0,
    this.shadowColor = Colors.transparent,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shadowColor: shadowColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    keyText,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    valueText,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}