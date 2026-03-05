import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Column(
        children: [

          Container(
            height: 60,
            width: 60,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: const Color(0xFF0E8A7E),
              size: 28,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}