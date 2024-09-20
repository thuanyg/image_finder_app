class Image {
  Image({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.totalResults,
    required this.nextPage,
  });

  final int? page;
  final int? perPage;
  final List<Photo> photos;
  final int? totalResults;
  final String? nextPage;

  factory Image.fromJson(Map<String, dynamic> json){
    return Image(
      page: json["page"],
      perPage: json["per_page"],
      photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
      totalResults: json["total_results"],
      nextPage: json["next_page"],
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "photos": photos.map((x) => x?.toJson()).toList(),
    "total_results": totalResults,
    "next_page": nextPage,
  };

}

class Photo {
  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
    required this.alt,
  });

  final int? id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final Src? src;
  final bool? liked;
  final String? alt;

  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(
      id: json["id"],
      width: json["width"],
      height: json["height"],
      url: json["url"],
      photographer: json["photographer"],
      photographerUrl: json["photographer_url"],
      photographerId: json["photographer_id"],
      avgColor: json["avg_color"],
      src: json["src"] == null ? null : Src.fromJson(json["src"]),
      liked: json["liked"],
      alt: json["alt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "url": url,
    "photographer": photographer,
    "photographer_url": photographerUrl,
    "photographer_id": photographerId,
    "avg_color": avgColor,
    "src": src?.toJson(),
    "liked": liked,
    "alt": alt,
  };

}

class Src {
  Src({
    required this.original,
    required this.large2X,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  final String? original;
  final String? large2X;
  final String? large;
  final String? medium;
  final String? small;
  final String? portrait;
  final String? landscape;
  final String? tiny;

  factory Src.fromJson(Map<String, dynamic> json){
    return Src(
      original: json["original"],
      large2X: json["large2x"],
      large: json["large"],
      medium: json["medium"],
      small: json["small"],
      portrait: json["portrait"],
      landscape: json["landscape"],
      tiny: json["tiny"],
    );
  }

  Map<String, dynamic> toJson() => {
    "original": original,
    "large2x": large2X,
    "large": large,
    "medium": medium,
    "small": small,
    "portrait": portrait,
    "landscape": landscape,
    "tiny": tiny,
  };

}
