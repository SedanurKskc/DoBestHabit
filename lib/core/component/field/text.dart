import 'package:flutter/material.dart';
import '../../base/state/base_state.dart';

class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Color? textColor;
  final bool obscureText;
  const CustomField({
    Key? key,
    required this.controller,
    this.hintText,
    this.textInputType = TextInputType.text,
    this.textColor,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends BaseState<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), boxShadow: [BoxShadow(offset: const Offset(0, 4), blurRadius: 5, color: Colors.black.withOpacity(0.2))]),
      child: TextFormField(
        maxLines:1,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
          fillColor: colorScheme.surface,
          filled: true,
          border: InputBorder.none,
          hintText: widget.hintText,
        ),
        style: textTheme.labelSmall!.copyWith(color: widget.textColor ?? ColorUtility.onSurface),
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
