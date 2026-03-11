class MediaContainer {
  final List<String> ParagrHist;
  final List<MediaContent> images;
  final List<MediaContent> videos;
  final List<MediaContent> sons;

  MediaContainer({
    required this.ParagrHist,
    required this.images,
    required this.sons,
    required this.videos,
  });
}

class MediaContent {
  final String Path;
  final String description;
  final String credits;

  MediaContent({
    required this.Path,
    required this.credits,
    required this.description,
  });
}
