class PreViewModel {
  final String title;
  final String tag;
  final String uploader;
  final String uploadTime;
  final int pages;
  final int stars;
  final String language;

  final String targetUrl;
  final String previewImg;
  final List<String> keyTags;

  PreViewModel(
      {this.title,
      this.tag,
      this.uploader,
      this.uploadTime,
      this.pages,
      this.stars,
      this.targetUrl,
      this.previewImg,
      this.language,
      this.keyTags});
}
