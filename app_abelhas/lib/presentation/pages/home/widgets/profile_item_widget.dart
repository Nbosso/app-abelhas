import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color? iconColor;
  final Function() onTap;
  final bool isVisible;
  const ProfileItemWidget(
      {super.key,
      required this.name,
      required this.icon,
      this.iconColor = Colors.black,
      required this.onTap,
      this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.black,
                size: 28,
              )
            ],
          ),
        ),
      ),
    );
  }
}
