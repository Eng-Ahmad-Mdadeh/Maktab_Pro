enum ImageType { svg, png, network, file, unknown }

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://') || startsWith('/data')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}
