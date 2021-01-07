class GalleryModel {
  final String parent;
  final String visible;
  final String fileSize;
  final String favorited;
  final Map<String, List<String>> tags;

  GalleryModel(
      {this.parent, this.visible, this.fileSize, this.favorited, this.tags});

}
