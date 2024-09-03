import 'package:flutter/material.dart';
import '../../constant/image.dart';
export '../../constant/image.dart';

class CustomAssetImage extends StatelessWidget {
  final String imageName;
  final ImagePaths imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const CustomAssetImage({super.key, required this.imageName, required this.imagePath, this.width, this.height, this.fit});
  const CustomAssetImage.expand({super.key, required this.imageName, required this.imagePath, this.width = double.infinity, this.height = double.infinity, this.fit});

  String get name => "${imagePath.path}/$imageName.${imagePath.endpoint}";

  @override
  Widget build(BuildContext context) {
    return Image.asset(name, width: width, height: height, fit: fit);
  }
}
