import 'package:flutter/material.dart';

class StoreHeader extends StatelessWidget {
  final VoidCallback onSeeAllTap;
  final String title;

  const StoreHeader({
    super.key,
    required this.onSeeAllTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        InkWell(
          onTap: onSeeAllTap,
          child: Row(
            children: const [
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFA12B3F),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFFA12B3F)),
            ],
          ),
        ),
      ],
    );
  }
}
