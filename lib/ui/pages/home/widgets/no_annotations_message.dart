import 'package:flutter/material.dart';

class NoAnnotationsMessage extends StatelessWidget {
  const NoAnnotationsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_rounded, size: 60),
          SizedBox(height: 12),
          Text('Nenhuma anotação ainda'),
        ],
      ),
    );
  }
}
