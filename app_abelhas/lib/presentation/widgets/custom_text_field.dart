import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

enum FieldType {
  normal,
  email,
  password,
  number,
  phone,
  date,
}

class CustomTextFormField extends StatefulWidget {
  final String label;
  final bool isRequired;
  final FieldType fieldType;
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String)? onChanged;
  final int minLines;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.fieldType = FieldType.normal,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  String? _validator(String? value) {
    if (widget.isRequired && (value == null || value.trim().isEmpty)) {
      return 'Campo obrigatório';
    }

    if (widget.fieldType == FieldType.email &&
        value != null &&
        value.isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'E-mail inválido';
      }
    }

    if (widget.fieldType == FieldType.date &&
        value != null &&
        value.isNotEmpty) {
      try {
        _parseDate(value); // tenta converter
      } catch (_) {
        return 'Data inválida';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: widget.controller,
      initialValue: widget.initialValue,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      obscureText:
          widget.fieldType == FieldType.password ? _obscureText : false,
      keyboardType: _getKeyboardType(),
      inputFormatters: _getInputFormatters(),
      validator: _validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        labelText: widget.label,
        suffixIcon: widget.fieldType == FieldType.password
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() {
                  _obscureText = !_obscureText;
                }),
              )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.none, width: 0, color: Colors.grey.shade100),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.number:
        return TextInputType.number;
      case FieldType.phone:
        return TextInputType.phone;
      case FieldType.date:
        return TextInputType.datetime;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.fieldType) {
      case FieldType.phone:
        return [PhoneInputFormatter(defaultCountryCode: 'BR')];
      case FieldType.date:
        return [MaskedInputFormatter('##/##/####')];
      default:
        return null;
    }
  }

  /// Converte uma string dd/MM/yyyy para DateTime
  DateTime? _parseDate(String input) {
    final parts = input.split('/');
    if (parts.length != 3) throw FormatException('Formato inválido');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}
