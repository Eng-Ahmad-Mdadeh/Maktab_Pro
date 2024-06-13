enum ImageType { svg, png, networkSvg,networkPng, networkMp4,file, unknown, empty }

extension ImageTypeExtension on String {
  ImageType get imageType {
    if(isEmpty) return ImageType.empty;
    if(startsWith('http') || startsWith('https')){
      if(endsWith('.svg')){
        return ImageType.networkSvg;
      }
      else if(startsWith('file://') || startsWith('/data')){
        return ImageType.file;
      }else if(endsWith('.mp4')){
        return ImageType.networkMp4;
      }else{
        return ImageType.networkPng;
      }
    }else{
      if(endsWith('.svg')){
        return ImageType.svg;
      } else if(startsWith('/data')){
        return ImageType.file;
      }
      else{
        return ImageType.png;
      }
    }
  }
}
