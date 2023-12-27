//旅拍页的模型
class TravelItemModel {
  int? totalCount;
  List<TravelItem>? resultList;

  TravelItemModel({
    this.totalCount,
    this.resultList,
  });

  TravelItemModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList = <TravelItem>[];
      json['resultList'].forEach((v) {
        resultList!.add(new TravelItem.fromJson(v));
       });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['totalCount'] = this.totalCount;
    if (this.resultList != null) {
      data['resultList'] = this.resultList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelItem {
  int? type;
  Article? article;

  TravelItem({this.type, this.article});

  TravelItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article =
        json['article'] != null ? new Article.fromJson(json['article']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.article != null) {
      data['article'] = this.article!.toJson();
    }
    return data;
  }
}

class Article {
  int? articleId;
  int? productType;
  String? articleTitle;
  String? content;
  Author? author;
  List<Images>? images;
  bool? hasVideo;
  int? likeCount;
  int? commentCount;
  List<Urls>? urls;
  List<Pois>? pois;
  String? publishTime;
  String? publishTimeDisplay;
  String? shootTime;
  String? shootTimeDisplay;
  String? distanceText;
  bool? isLike;
  int? imageCounts;
  bool? isCollected;
  int? collectCount;
  int? articleStatus;
  String? poiName;
  ShareInfo? shareInfo;
  String? videoAutoplayNet;
  String? combinateContent;
  String? combinedTitle;
  Video? video;

  Article(
      {this.articleId,
      this.productType,
      this.articleTitle,
      this.content,
      this.author,
      this.images,
      this.hasVideo,
      this.likeCount,
      this.commentCount,
      this.urls,
      this.pois,
      this.publishTime,
      this.publishTimeDisplay,
      this.shootTime,
      this.shootTimeDisplay,
      this.distanceText,
      this.isLike,
      this.imageCounts,
      this.isCollected,
      this.collectCount,
      this.articleStatus,
      this.poiName,
      this.shareInfo,
      this.videoAutoplayNet,
      this.combinateContent,
      this.combinedTitle,
      this.video});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    productType = json['productType'];
    articleTitle = json['articleTitle'];
    content = json['content'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((v) {
        urls!.add(new Urls.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois = <Pois>[];
      json['pois'].forEach((v) {
        pois!.add(new Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    distanceText = json['distanceText'];
    isLike = json['isLike'];
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount'];
    articleStatus = json['articleStatus'];
    poiName = json['poiName'];
    shareInfo = json['shareInfo'] != null
        ? new ShareInfo.fromJson(json['shareInfo'])
        : null;
    videoAutoplayNet = json['videoAutoplayNet'];
    combinateContent = json['combinateContent'];
    combinedTitle = json['combinedTitle'];
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articleId'] = this.articleId;
    data['productType'] = this.productType;
    data['articleTitle'] = this.articleTitle;
    data['content'] = this.content;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['hasVideo'] = this.hasVideo;
    data['likeCount'] = this.likeCount;
    data['commentCount'] = this.commentCount;
    if (this.urls != null) {
      data['urls'] = this.urls!.map((v) => v.toJson()).toList();
    }
    if (this.pois != null) {
      data['pois'] = this.pois!.map((v) => v.toJson()).toList();
    }
    data['publishTime'] = this.publishTime;
    data['publishTimeDisplay'] = this.publishTimeDisplay;
    data['shootTime'] = this.shootTime;
    data['shootTimeDisplay'] = this.shootTimeDisplay;
    data['distanceText'] = this.distanceText;
    data['isLike'] = this.isLike;
    data['imageCounts'] = this.imageCounts;
    data['isCollected'] = this.isCollected;
    data['collectCount'] = this.collectCount;
    data['articleStatus'] = this.articleStatus;
    data['poiName'] = this.poiName;
    if (this.shareInfo != null) {
      data['shareInfo'] = this.shareInfo!.toJson();
    }
    data['videoAutoplayNet'] = this.videoAutoplayNet;
    data['combinateContent'] = this.combinateContent;
    data['combinedTitle'] = this.combinedTitle;
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    return data;
  }
}

class Author {
  String? nickName;
  String? clientAuth;
  String? userUrl;
  String? jumpUrl;
  String? uid;
  CoverImage? coverImage;
  int? identityType;
  String? identityTypeName;
  bool? isFollow;
  String? vIcon;
  String? identityDesc;
  bool? isStarAccount;
  List<ShowTagList>? showTagList;
  Urls? urls;
  AvatarDecoration? avatarDecoration;

  Author(
      {this.nickName,
      this.clientAuth,
      this.userUrl,
      this.jumpUrl,
      this.uid,
      this.coverImage,
      this.identityType,
      this.identityTypeName,
      this.isFollow,
      this.vIcon,
      this.identityDesc,
      this.isStarAccount,
      this.showTagList,
      this.urls,
      this.avatarDecoration});

  Author.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    clientAuth = json['clientAuth'];
    userUrl = json['userUrl'];
    jumpUrl = json['jumpUrl'];
    uid = json['uid'];
    coverImage = json['coverImage'] != null
        ? new CoverImage.fromJson(json['coverImage'])
        : null;
    identityType = json['identityType'];
    identityTypeName = json['identityTypeName'];
    isFollow = json['isFollow'];
    vIcon = json['vIcon'];
    identityDesc = json['identityDesc'];
    isStarAccount = json['isStarAccount'];
    if (json['showTagList'] != null) {
      showTagList = <ShowTagList>[];
      json['showTagList'].forEach((v) {
        showTagList!.add(new ShowTagList.fromJson(v));
      });
    }
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    avatarDecoration = json['avatarDecoration'] != null
        ? new AvatarDecoration.fromJson(json['avatarDecoration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickName'] = this.nickName;
    data['clientAuth'] = this.clientAuth;
    data['userUrl'] = this.userUrl;
    data['jumpUrl'] = this.jumpUrl;
    data['uid'] = this.uid;
    if (this.coverImage != null) {
      data['coverImage'] = this.coverImage!.toJson();
    }
    data['identityType'] = this.identityType;
    data['identityTypeName'] = this.identityTypeName;
    data['isFollow'] = this.isFollow;
    data['vIcon'] = this.vIcon;
    data['identityDesc'] = this.identityDesc;
    data['isStarAccount'] = this.isStarAccount;
    if (this.showTagList != null) {
      data['showTagList'] = this.showTagList!.map((v) => v.toJson()).toList();
    }
    if (this.urls != null) {
      data['urls'] = this.urls!.toJson();
    }
    if (this.avatarDecoration != null) {
      data['avatarDecoration'] = this.avatarDecoration!.toJson();
    }
    return data;
  }
}

class CoverImage {
  int? imageId;
  String? dynamicUrl;
  double? width;
  double? height;

  CoverImage({this.imageId, this.dynamicUrl, this.width, this.height});

  CoverImage.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['dynamicUrl'] = this.dynamicUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class ShowTagList {
  int? tagStyle;
  String? tagName;
  TagStyleMap? tagStyleMap;

  ShowTagList({this.tagStyle, this.tagName, this.tagStyleMap});

  ShowTagList.fromJson(Map<String, dynamic> json) {
    tagStyle = json['tagStyle'];
    tagName = json['tagName'];
    tagStyleMap = json['tagStyleMap'] != null
        ? new TagStyleMap.fromJson(json['tagStyleMap'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagStyle'] = this.tagStyle;
    data['tagName'] = this.tagName;
    if (this.tagStyleMap != null) {
      data['tagStyleMap'] = this.tagStyleMap!.toJson();
    }
    return data;
  }
}

class TagStyleMap {
  White? white;
  White? black;

  TagStyleMap({this.white, this.black});

  TagStyleMap.fromJson(Map<String, dynamic> json) {
    white = json['white'] != null ? new White.fromJson(json['white']) : null;
    black = json['black'] != null ? new White.fromJson(json['black']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.white != null) {
      data['white'] = this.white!.toJson();
    }
    if (this.black != null) {
      data['black'] = this.black!.toJson();
    }
    return data;
  }
}

class White {
  String? tagStyleFont;
  String? tagStyleBack;
  String? tagStyleBackARGB;

  White({this.tagStyleFont, this.tagStyleBack, this.tagStyleBackARGB});

  White.fromJson(Map<String, dynamic> json) {
    tagStyleFont = json['tagStyleFont'];
    tagStyleBack = json['tagStyleBack'];
    tagStyleBackARGB = json['tagStyleBackARGB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagStyleFont'] = this.tagStyleFont;
    data['tagStyleBack'] = this.tagStyleBack;
    data['tagStyleBackARGB'] = this.tagStyleBackARGB;
    return data;
  }
}

class AvatarDecoration {
  String? svga;
  String? webp;
  String? png;

  AvatarDecoration({this.svga, this.webp, this.png});

  AvatarDecoration.fromJson(Map<String, dynamic> json) {
    svga = json['svga'];
    webp = json['webp'];
    png = json['png'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['svga'] = this.svga;
    data['webp'] = this.webp;
    data['png'] = this.png;
    return data;
  }
}

class Images {
  int? imageId;
  String? dynamicUrl;
  String? originalUrl;
  double? width;
  double? height;

  Images(
      {this.imageId,
      this.dynamicUrl,
      this.originalUrl,
      this.width,
      this.height});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['dynamicUrl'] = this.dynamicUrl;
    data['originalUrl'] = this.originalUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Urls {
  String? version;
  String? appUrl;
  String? h5Url;
  String? wxUrl;

  Urls({this.version, this.appUrl, this.h5Url, this.wxUrl});

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['appUrl'] = this.appUrl;
    data['h5Url'] = this.h5Url;
    data['wxUrl'] = this.wxUrl;
    return data;
  }
}

class Pois {
  int? poiType;
  int? poiId;
  String? poiName;
  int? businessId;
  int? districtId;
  String? districtName;
  PoiExt? poiExt;
  String? countryName;

  Pois(
      {this.poiType,
      this.poiId,
      this.poiName,
      this.businessId,
      this.districtId,
      this.districtName,
      this.poiExt,
      this.countryName});

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    businessId = json['businessId'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    poiExt =
        json['poiExt'] != null ? new PoiExt.fromJson(json['poiExt']) : null;
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poiType'] = this.poiType;
    data['poiId'] = this.poiId;
    data['poiName'] = this.poiName;
    data['businessId'] = this.businessId;
    data['districtId'] = this.districtId;
    data['districtName'] = this.districtName;
    if (this.poiExt != null) {
      data['poiExt'] = this.poiExt!.toJson();
    }
    data['countryName'] = this.countryName;
    return data;
  }
}

class PoiExt {
  String? h5Url;
  String? appUrl;

  PoiExt({this.h5Url, this.appUrl});

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h5Url'] = this.h5Url;
    data['appUrl'] = this.appUrl;
    return data;
  }
}

class ShareInfo {
  String? imageUrl;
  String? shareTitle;
  String? token;

  ShareInfo({this.imageUrl, this.shareTitle, this.token});

  ShareInfo.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    shareTitle = json['shareTitle'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['shareTitle'] = this.shareTitle;
    data['token'] = this.token;
    return data;
  }
}

class Video {
  int? videoId;
  String? coverImageUrl;
  String? videoUrl;
  double? width;
  double? height;
  int? durationSeconds;

  Video(
      {this.videoId,
      this.coverImageUrl,
      this.videoUrl,
      this.width,
      this.height,
      this.durationSeconds});

  Video.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    coverImageUrl = json['coverImageUrl'];
    videoUrl = json['videoUrl'];
    width = json['width'];
    height = json['height'];
    durationSeconds = json['durationSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoId'] = this.videoId;
    data['coverImageUrl'] = this.coverImageUrl;
    data['videoUrl'] = this.videoUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['durationSeconds'] = this.durationSeconds;
    return data;
  }
}
