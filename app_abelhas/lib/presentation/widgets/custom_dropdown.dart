import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? label;
  final String? errorText;
  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChanged;
  final T? initialValue;
  final Widget? icon;

  const CustomDropdown({
    this.label = "Selecione",
    required this.items,
    required this.onChanged,
    this.errorText,
    this.initialValue,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: initialValue,
      menuMaxHeight: 240,
      icon: icon,
      isExpanded: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        label: Text(
          label!,
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: MediaQuery.of(context).size.height * 0.019,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              fontFamily: 'Lato'),
        ),
        errorText: errorText,
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}
