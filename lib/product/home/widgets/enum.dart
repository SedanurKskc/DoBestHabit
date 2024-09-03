enum ContainerSize {
  small(0.2, 10, 0.9),
  medium(1.2, 20, 2);

  final double ratio;
  final double fontSize;
  final double widthFlex;

  const ContainerSize(this.ratio, this.fontSize, this.widthFlex);
}
