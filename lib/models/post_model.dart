class PostModel {
  String? name;

  String? uId;
  String? txt;

  String? image;
  String? datePost;
  String? postImage;

  PostModel(
      {this.name,
      this.uId,
      this.image,
      this.datePost,
      this.postImage,
      this.txt});
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    uId = json['uId'];
    datePost = json['datePost'];
    postImage = json['postImage'];
    txt = json['txt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'postImage': postImage,
      'datePost': datePost,
      'txt': txt,
    };
  }
}
