class Game {
  int id;
  String name;
  String slug;
  String? backgroundImageUrl;
  String? description;
  String? released;
  double rating;
  int ratingsCount;
  int? playtime;
  final List<Genre> genres;
  // final List<Platforms> platforms;
  // final List<Publishers> publishers;
  // final List<Developers> developers;
  String? websiteUrl;
  String? redditUrl;
  String? twitchUrl;
  String? youtubeUrl;
  String? storeUrl;
  String? updatedAt;

  Game({
    required this.id,
    required this.name,
    required this.slug,
    this.backgroundImageUrl,
    this.description,
    this.released,
    required this.rating,
    required this.ratingsCount,
    this.playtime,
    required this.genres,
    // required this.platforms,
    // required this.publishers,
    // required this.developers,
    this.websiteUrl,
    this.redditUrl,
    this.twitchUrl,
    this.youtubeUrl,
    this.storeUrl,
    this.updatedAt,

  });

  factory Game.fromJson(Map<String, dynamic> json) {
    final List<dynamic> genreData = json['genres'];
    final List<Genre> genres = genreData.map((genre) => Genre.fromJson(genre)).toList();

    // final List<dynamic> platformData = json['platforms'];
    // final List<Platforms> platforms = platformData.map((platforms) => Platforms.fromJson(platforms)).toList();
    //
    // final List<dynamic> publisherData = json['publishers'];
    // final List<Publishers> publishers = publisherData.map((publishers) => Publishers.fromJson(publishers)).toList();
    //
    // final List<dynamic> developerData = json['developers'];
    // final List<Developers> developers = developerData.map((developers) => Developers.fromJson(developers)).toList();

    return Game(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      backgroundImageUrl: json['background_image'],
      description: json['description_raw'],
      released: json['released'],
      rating: json['rating'].toDouble(),
      ratingsCount: json['ratings_count'],
      playtime: json['playtime'] != null ? json['playtime'] : null,
      genres: genres,
      // developers: developers,
      // platforms: platforms,
      // publishers: publishers,
      websiteUrl: json['website'],
      redditUrl: json['reddit_url'],
      twitchUrl: json['twitch_url'],
      youtubeUrl: json['youtube_url'],
      storeUrl: json['store_url'],
      updatedAt: json['updated'],

    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

