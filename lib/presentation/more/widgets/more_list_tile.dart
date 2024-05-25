import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class MoreListTile extends StatelessWidget {
  const MoreListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: AppColors.softAsh,
        size: 25,
      ),
      title: Text(
        title,
        softWrap: true,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.softAsh,
        size: 20,
      ),
    );
  }
}
