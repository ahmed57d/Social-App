class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? cover;
  String? bio;

  SocialUserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
    required this.image,
    required this.cover,
    required this.bio,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'uId': uId,
      'name':name,
      'email':email,
      'phone':phone,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}