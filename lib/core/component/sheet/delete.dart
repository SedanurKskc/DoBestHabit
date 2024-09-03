import 'package:flutter/material.dart';
import '../../base/state/base_state.dart';
import '../../modules/navigate/manager.dart';

class DeleteSheet extends BaseStateless {
  DeleteSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colorScheme(context).background,
      contentPadding: paddings.t(sizes.s10),
      actionsPadding: paddings.v(sizes.s10),
      insetPadding: paddings.h(sizes.s10),
      titlePadding: paddings.v(sizes.s10),
      buttonPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Padding(
        padding: paddings.h(sizes.s10) + paddings.v(sizes.s10),
        child: Text("Silmek istediğinize emin misiniz?", style: textTheme(context).labelLarge!.copyWith(color: colorScheme(context).onBackground)),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text("Vazgeç", style: textTheme(context).labelLarge!.copyWith(color: colorScheme(context).primary)),
              onPressed: () => NavigationManager.instance.pop(res: false),
            ),
            SizedBox(width: sizes.s10),
            TextButton(
              child: Text("Onayla", style: textTheme(context).labelLarge!.copyWith(color: colorScheme(context).primary)),
              onPressed: () => NavigationManager.instance.pop(res: true),
            ),
            SizedBox(width: sizes.s10),
          ],
        ),
      ],
    );
  }
}
