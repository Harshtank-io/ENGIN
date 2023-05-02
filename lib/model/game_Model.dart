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
    final List<Genre>? genres;
    final List<Platform>? platforms;
    String? websiteUrl;
    String? redditUrl;
    String? twitchUrl;
    String? youtubeUrl;
    String? storeUrl;
    String? updatedAt;
    final List<Tag>? tags;
    String? minimumRequirements;
    String? recommendedRequirements;
    final List<Store> stores;

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
      this.genres,
      this.platforms,
      this.websiteUrl,
      this.redditUrl,
      this.twitchUrl,
      this.youtubeUrl,
      this.storeUrl,
      this.updatedAt,
      this.tags,
      this.minimumRequirements,
      this.recommendedRequirements,
      required this.stores,
    });

    factory Game.fromJson(Map<String, dynamic> json) {
      final List<dynamic>? genreData = json['genres'];
      final List<Genre>? genres = genreData?.map((genre) => Genre.fromJson(genre)).toList();

      final List<dynamic>? platformData = json['platforms'];
      final List<Platform>? platforms = platformData?.map((platform) => Platform.fromJson(platform)).toList();

      final List<dynamic>? tagData = json['tags'];
      final List<Tag>? tags = tagData?.map((tag) => Tag.fromJson(tag)).toList();

      final Map<String, dynamic>? requirementsData = json['requirements_en'];
      final String? minimumRequirements = requirementsData?['minimum'];
      final String? recommendedRequirements = requirementsData?['recommended'];

      final List<dynamic> storeData = json['stores'];
      final List<Store> stores = storeData.map((store) => Store.fromJson(store)).toList();


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
        platforms: platforms,
        websiteUrl: json['website'],
        redditUrl: json['reddit_url'],
        twitchUrl: json['twitch_url'],
        youtubeUrl: json['youtube_url'],
        storeUrl: json['store_url'],
        updatedAt: json['updated'],
        tags: tags,
        minimumRequirements: minimumRequirements,
        recommendedRequirements: recommendedRequirements,
        stores: stores,
      );
    }
  }

  class Store {
    final int id;
    final String name;

    Store({
      required this.id,
      required this.name,
    });

    factory Store.fromJson(Map<String, dynamic> json) {
      return Store(
        id: json['id'],
        name: json['store']['name']
      );
    }
  }

  class Tag {
    final int id;
    final String name;
    final String slug;

    Tag({
      required this.id,
      required this.name,
      required this.slug,
    });

    factory Tag.fromJson(Map<String, dynamic> json) {
      return Tag(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
      );
    }
  }

  class Platform {
    final int id;
    final String name;

    Platform({
      required this.id,
      required this.name,
    });

    factory Platform.fromJson(Map<String, dynamic> json) {
      return Platform(
        id: json['platform']['id'],
        name: json['platform']['name'],
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

