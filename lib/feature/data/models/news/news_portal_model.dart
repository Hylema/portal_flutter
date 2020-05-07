import 'package:meta/meta.dart';

class NewsModel {
  final odataType;
  final odataId;
  final odataEtag;
  final fileSystemObjectType;
  final id;
  final serverRedirectedEmbedUri;
  final serverRedirectedEmbedUrl;
  final contentTypeId;
  final title;
  final complianceAssetId;
  final slNewsAnnouncement;
  final slNewsCover;
  final slNewsBody;
  final slNewsPublicationDate;
  final slNewsRubricLookupId;
  final averageRating;
  final ratingCount;
  final ratedByStringId;
  final likedByStringId;
  final likesCount;
  final secondId;
  final modified;
  final created;
  final authorId;
  final editorId;
  final oDataUIVersionString;
  final attachments;
  final guid;

  NewsModel({
    @required this.odataType,
    @required this.odataId,
    @required this.odataEtag,
    @required this.fileSystemObjectType,
    @required this.id,
    @required this.serverRedirectedEmbedUri,
    @required this.serverRedirectedEmbedUrl,
    @required this.contentTypeId,
    @required this.title,
    @required this.complianceAssetId,
    @required this.slNewsAnnouncement,
    @required this.slNewsCover,
    @required this.slNewsBody,
    @required this.slNewsPublicationDate,
    @required this.slNewsRubricLookupId,
    @required this.averageRating,
    @required this.ratingCount,
    @required this.ratedByStringId,
    @required this.likedByStringId,
    @required this.likesCount,
    @required this.secondId,
    @required this.modified,
    @required this.created,
    @required this.authorId,
    @required this.editorId,
    @required this.oDataUIVersionString,
    @required this.attachments,
    @required this.guid,
  });

  static NewsModel fromJson(raw) {
    return NewsModel(
      odataType: raw['odata.type'],
      odataId: raw['odata.id'],
      odataEtag: raw['odata.etag'],
      fileSystemObjectType: raw['FileSystemObjectType'],
      id: raw['Id'],
      serverRedirectedEmbedUri: raw['ServerRedirectedEmbedUri'],
      serverRedirectedEmbedUrl: raw['ServerRedirectedEmbedUrl'],
      contentTypeId: raw['ContentTypeId'],
      title: raw['Title'],
      complianceAssetId: raw['ComplianceAssetId'],
      slNewsAnnouncement: raw['slNewsAnnouncement'],
      slNewsCover: raw['slNewsCover'],
      slNewsBody: raw['slNewsBody'],
      slNewsPublicationDate: raw['slNewsPublicationDate'],
      slNewsRubricLookupId: raw['slNewsRubricLookupId'],
      averageRating: raw['AverageRating'],
      ratingCount: raw['RatingCount'],
      ratedByStringId: raw['RatedByStringId'],
      likedByStringId: raw['LikedByStringId'],
      likesCount: raw['LikesCount'],
      secondId: raw['ID'],
      modified: raw['Modified'],
      created: raw['Created'],
      authorId: raw['AuthorId'],
      editorId: raw['EditorId'],
      oDataUIVersionString: raw['OData__UIVersionString'],
      attachments: raw['Attachments'],
      guid: raw['GUID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'odata.type': odataType,
      'odata.id': odataId,
      'odata.etag': odataEtag,
      'FileSystemObjectType': fileSystemObjectType,
      'Id': id,
      'ServerRedirectedEmbedUri': serverRedirectedEmbedUri,
      'ServerRedirectedEmbedUrl': serverRedirectedEmbedUrl,
      'ContentTypeId': contentTypeId,
      'Title': title,
      'ComplianceAssetId': complianceAssetId,
      'slNewsAnnouncement': slNewsAnnouncement,
      'slNewsCover': slNewsCover,
      'slNewsBody': slNewsBody,
      'slNewsPublicationDate': slNewsPublicationDate,
      'slNewsRubricLookupId': slNewsRubricLookupId,
      'AverageRating': averageRating,
      'RatingCount': ratingCount,
      'ratedByStringId': ratedByStringId,
      'LikedByStringId': likedByStringId,
      'LikesCount': likesCount,
      'ID': secondId,
      'Modified': modified,
      'Created': created,
      'AuthorId': authorId,
      'EditorId': editorId,
      'OData__UIVersionString': oDataUIVersionString,
      'Attachments': attachments,
      'GUID': guid,
    };
  }
}