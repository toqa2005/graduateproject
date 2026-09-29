class MovieModel {
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MovieModel({this.status, this.statusMessage, this.data, this.meta});

  MovieModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['status'] = status;
    data['status_message'] = statusMessage;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    if (meta != null) {
      data['@meta'] = meta!.toJson();
    }

    return data;
  }
}

class Data {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<Movies>? movies;

  Data({this.movieCount, this.limit, this.pageNumber, this.movies});

  Data.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];

    if (json['movies'] != null) {
      movies = <Movies>[];

      for (final movie in json['movies']) {
        movies!.add(Movies.fromJson(Map<String, dynamic>.from(movie)));
      }
    } else {
      movies = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['movie_count'] = movieCount;
    data['limit'] = limit;
    data['page_number'] = pageNumber;

    if (movies != null) {
      data['movies'] = movies!.map((movie) => movie.toJson()).toList();
    }

    return data;
  }
}

class Movies {
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  int? likeCount;
  List<Cast>? cast;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Movies({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.likeCount,
    this.cast,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];

    rating = (json['rating'] as num?)?.toDouble();

    runtime = json['runtime'];

    if (json['genres'] != null) {
      genres = List<String>.from(json['genres']);
    } else {
      genres = [];
    }

    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    state = json['state'];
    likeCount = json['like_count'];

    if (json['cast'] != null) {
      cast = <Cast>[];
      for (final person in json['cast']) {
        if (person is Map) {
          cast!.add(Cast.fromJson(Map<String, dynamic>.from(person)));
        }
      }
    } else {
      cast = [];
    }

    if (json['torrents'] != null) {
      torrents = <Torrents>[];

      for (final torrent in json['torrents']) {
        torrents!.add(Torrents.fromJson(Map<String, dynamic>.from(torrent)));
      }
    } else {
      torrents = [];
    }

    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['url'] = url;
    data['imdb_code'] = imdbCode;
    data['title'] = title;
    data['title_english'] = titleEnglish;
    data['title_long'] = titleLong;
    data['slug'] = slug;
    data['year'] = year;
    data['rating'] = rating;
    data['runtime'] = runtime;
    data['genres'] = genres;
    data['summary'] = summary;
    data['description_full'] = descriptionFull;
    data['synopsis'] = synopsis;
    data['yt_trailer_code'] = ytTrailerCode;
    data['language'] = language;
    data['mpa_rating'] = mpaRating;
    data['background_image'] = backgroundImage;
    data['background_image_original'] = backgroundImageOriginal;
    data['small_cover_image'] = smallCoverImage;
    data['medium_cover_image'] = mediumCoverImage;
    data['large_cover_image'] = largeCoverImage;
    data['state'] = state;
    data['like_count'] = likeCount;

    if (cast != null) {
      data['cast'] = cast!.map((person) => person.toJson()).toList();
    }

    if (torrents != null) {
      data['torrents'] = torrents!.map((torrent) => torrent.toJson()).toList();
    }

    data['date_uploaded'] = dateUploaded;
    data['date_uploaded_unix'] = dateUploadedUnix;

    return data;
  }
}

class Cast {
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Cast({this.name, this.characterName, this.urlSmallImage, this.imdbCode});

  Cast.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'character_name': characterName,
    'url_small_image': urlSmallImage,
    'imdb_code': imdbCode,
  };
}

class Torrents {
  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Torrents({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Torrents.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    type = json['type'];
    isRepack = json['is_repack'];
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth'];
    audioChannels = json['audio_channels'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['url'] = url;
    data['hash'] = hash;
    data['quality'] = quality;
    data['type'] = type;
    data['is_repack'] = isRepack;
    data['video_codec'] = videoCodec;
    data['bit_depth'] = bitDepth;
    data['audio_channels'] = audioChannels;
    data['seeds'] = seeds;
    data['peers'] = peers;
    data['size'] = size;
    data['size_bytes'] = sizeBytes;
    data['date_uploaded'] = dateUploaded;
    data['date_uploaded_unix'] = dateUploadedUnix;

    return data;
  }
}

class Meta {
  Migration? migration;
  int? apiVersion;
  String? executionTime;

  Meta({this.migration, this.apiVersion, this.executionTime});

  Meta.fromJson(Map<String, dynamic> json) {
    migration = json['migration'] != null
        ? Migration.fromJson(json['migration'])
        : null;

    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (migration != null) {
      data['migration'] = migration!.toJson();
    }

    data['api_version'] = apiVersion;
    data['execution_time'] = executionTime;

    return data;
  }
}

class Migration {
  String? message;
  String? oldBase;
  String? newBase;
  String? sunset;

  Migration({this.message, this.oldBase, this.newBase, this.sunset});

  Migration.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    oldBase = json['old_base'];
    newBase = json['new_base'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['message'] = message;
    data['old_base'] = oldBase;
    data['new_base'] = newBase;
    data['sunset'] = sunset;

    return data;
  }
}
