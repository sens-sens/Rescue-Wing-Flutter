import 'package:flutter/material.dart';
import 'package:rescue_wing/core/constants.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onSearchChanged;

  const CustomSearchBar({
    required this.onSearchChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Constants.containerColor,
        borderRadius: Constants.containerBorderRadius,
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onSearchChanged,
        decoration: const InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
