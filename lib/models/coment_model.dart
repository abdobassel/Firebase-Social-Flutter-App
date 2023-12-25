class CommentModel {
  String? name;
  String? uId;
  String? commentDate;
  String? comment;
  String? postId;

  String? image;

  CommentModel(
      {this.comment,
      this.name,
      this.commentDate,
      this.image,
      this.uId,
      this.postId});
  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    comment = json['comment'];
    image = json['image'];
    commentDate = json['commentDate'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'uId': uId,
      'commentDate': commentDate,
      'name': name,
      'image': image,
      'postId': postId,
    };
  }
}
