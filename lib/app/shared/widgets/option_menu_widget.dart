import 'package:flutter/material.dart';

class OptionMenuWidget extends StatelessWidget {
  final String iconName;
  final IconData iconSax;
  final VoidCallback onPressed;

  const OptionMenuWidget({
    super.key,
    required this.iconName,
    required this.iconSax,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Icon(
                iconSax,
                color: const Color(0xFF667EEA),
                size: 35,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(iconName,
                  style: const TextStyle(fontSize: 14).copyWith(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Loto',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
