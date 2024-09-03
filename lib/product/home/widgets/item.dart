import 'package:dobesthabit/product/home/widgets/enum.dart';
import 'package:flutter/material.dart';
import '../../../core/base/state/base_state.dart';



class TypeItem extends BaseStateless {
  TypeItem({
    Key? key,
    required this.onTap,
    required this.type,
    this.imagePath,
    required this.title,
  }) : super(key: key);
  final ContainerSize type;
  final VoidCallback onTap;
  final String title;
  String? imagePath;
  double itemWidth(BuildContext context) => (deviceWidth(context) - (sizes.s20 * (type.widthFlex + 2))) / type.widthFlex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: paddings.h(sizes.s20) + paddings.t(sizes.s20),
        height: itemWidth(context) * type.ratio,
        width: itemWidth(context),
        decoration: BoxDecoration(
            color: colorScheme(context).background,
            boxShadow: [BoxShadow(offset: const Offset(0, 4), blurRadius: 5, color: Colors.black.withOpacity(0.3))],
            borderRadius: BorderRadius.circular(sizes.s20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (imagePath != null)
              SizedBox(
                height: deviceWidth(context) / 5,
                child: Image.asset(
                  imagePath!,
                  fit: BoxFit.contain,
                ),
              ),
            Text(
              title,
              style: textTheme(context).headlineSmall!.copyWith(color: colorScheme(context).onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
