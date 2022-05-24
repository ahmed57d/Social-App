class SocialPostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postId;


  SocialPostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
    required this.postId,
  });

  SocialPostModel.fromJson(Map<String, dynamic> json,)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'uId': uId,
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
      'postId':postId,

    };
  }
}

class GetPostModel extends SocialPostModel {
  final String postId;

  /// contains uIds of users who liked the post
  List<String> likes = [];

  List<CommentModel>? comments;


  GetPostModel({
    required String name,
    required String uId,
    required String image,
    required String text,
    required String postImage,
    required String dateTime,
    required int milSecEpoch,
    required this.postId,
    required this.likes,
    this.comments,
  }): super(
    uId: uId,
    name:name,
    image:image,
    dateTime:dateTime,
    text:text,
    postImage:postImage,
    postId:postId,

  );

  GetPostModel.fromJson({
    required Map<String, dynamic> json,
    required this.postId,
    required this.likes,
    this.comments,
  }) : super.fromJson(json);

}

class CommentModel {

  late String comment;
  late String uId;
  late int milSecEpoch;

  CommentModel({
    required this.comment,
    required this.uId,
    required this.milSecEpoch,
  });

  CommentModel.fromJson(Map<String, dynamic> json){
    comment = json['comment'];
    uId = json['uId'];
    milSecEpoch = json['milSecEpoch'];
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'uId': uId,
      'milSecEpoch': milSecEpoch,
    };
  }
}