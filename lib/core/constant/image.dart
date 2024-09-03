enum ImagePaths {
  assets('assets', 'png'),
  images('assets/images', 'png');

  final String path;
  final String endpoint;
  const ImagePaths(this.path, this.endpoint);
}
