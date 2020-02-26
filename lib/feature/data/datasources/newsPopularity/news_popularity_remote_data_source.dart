import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';

import 'package:flutter_architecture_project/feature/data/models/newsPopularity/news_popularity_model.dart';
import 'package:http/http.dart' as http;

const COLLECTION_NEWS = 'news';
const COLLECTION_KEY = 'popularity';
const JSON_FILE_NAME = 'news_remote_popularity.json';

abstract class INewsPopularityRemoteDataSource {

  /// Throws a [ServerException] for all error codes.
  Future<NewsPopularityModel> getNewsPopularity(int id);
  Future<List<DocumentSnapshot>> loadingPopularity();
  userSeePage(int id, int userId);
}

class NewsPopularityRemoteDataSource implements INewsPopularityRemoteDataSource {

  final http.Client client;
  final Storage storage;

  NewsPopularityRemoteDataSource({
    @required this.client,
    @required this.storage,
  });

  List<DocumentSnapshot> documentSnapshot;
  List<DocumentSnapshot> likes;
  List<DocumentSnapshot> seen;

  @override
  Future<List<DocumentSnapshot>> loadingPopularity() async {
    try{
      documentSnapshot = await Firestore.instance.collection(COLLECTION_NEWS)
          .getDocuments().then((QuerySnapshot querySnapshot)
      => querySnapshot.documents);
      return documentSnapshot;
    } catch(e){
      throw ServerException();
    }
  }

  @override
  Future<NewsPopularityModel> getNewsPopularity(int id) async{
    try {
      NewsPopularityModel _result;

      documentSnapshot.forEach((document){
        if(document.documentID == '$id') _result = NewsPopularityModel(popularity: document.data);
      });

      await Firestore.instance.collection('news').document('$id').get().then((DocumentSnapshot ds) {
        print('FIREBASE ====================================== ${ds.data}');
      });

      if(_result != null) return _result;
      else {
        Firestore.instance.collection('news').document('$id');

//        likes = await Firestore.instance.collection('news').document('$id').collection('likes')
//            .getDocuments().then((QuerySnapshot querySnapshot) => querySnapshot.documents);
//
//        seen = await Firestore.instance.collection('news').document('$id').collection('seen')
//            .getDocuments().then((QuerySnapshot querySnapshot) => querySnapshot.documents);

        return NewsPopularityModel(popularity: {
          'likes': [],
          'seen': []
        });
      }


    } catch(e){
      throw ServerException();
    }
//    Firestore.instance.collection('books').snapshots();

  }

  @override
  userSeePage(int newsId, int userId){

  }

//  Future<NewsPopularityModel> _getPopularityFromUrl(String url) async {
//    final response = await client.get(
//      url,
//      headers: {
//        'Accept': 'application/json',
//        'Authorization': 'Bearer ${authToken.token}'
//      },
//    );
//
//    if (response.statusCode == 200) {
//      return NewsPopularityModel.fromJson(json.decode(response.body));
//    } else if(response.statusCode == 401){
//      throw AuthFailure();
//    } else {
//      Status.code = response.statusCode;
//      throw ServerException();
//    }
//  }
}