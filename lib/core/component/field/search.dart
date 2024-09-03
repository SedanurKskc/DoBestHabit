import 'package:flutter/material.dart';
import '../../base/state/base_state.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final bool enabled;
  final String? hint;
  const SearchField({Key? key, required this.controller, required this.onChanged, required this.enabled, this.hint}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends BaseState<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings.h(sizes.s20),
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enabled,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0), borderSide: BorderSide.none),
          fillColor: colorScheme.surface,
          filled: true,
          border: InputBorder.none,
          hintText: widget.hint ?? "Eczanelerde arayın...",
          contentPadding: paddings.l(sizes.s20),
        ),
        style: textTheme.titleMedium!.copyWith(color: ColorUtility.onSecondary),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (_) => widget.onChanged.call(),
      ),
    );
  }
}
