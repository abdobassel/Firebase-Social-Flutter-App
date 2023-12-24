abstract class SocialStates {}

class SocialinitState extends SocialStates {}

class SocialGetUserSuccesState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

// cover and profile imgs => update  user data
class SociaProfilePickedSuccessState extends SocialStates {}

class SociaProfilePickedErrorState extends SocialStates {}

class SocialCoverPickedSuccsessState extends SocialStates {}

class SocialCoverPickedErrorState extends SocialStates {}

class SocialUploadCoverSuccessState extends SocialStates {}

class SocialUploadCoverErrorState extends SocialStates {}

class SocialUploadProfileImgErorrState extends SocialStates {}

class SocialUploadProfileImgSuccessState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialUpdateUserLoadingState extends SocialStates {}

class SocialUpdatesuccessState extends SocialStates {}

// Post
class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialPostPickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

// close img post => null
class SocialPostImageCloseState extends SocialStates {}

//likes
class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {}

//get posts
class SocialGetPostsSuccesState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}

// comments
class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {}
// get comments

class SocialGetCommentsSuccesState extends SocialStates {}

class SocialGetCommentsLoadingState extends SocialStates {}

class SocialGetCommentsErrorState extends SocialStates {
  final String error;
  SocialGetCommentsErrorState(this.error);
}

//Get Users
class SocialGetAllUserSuccesState extends SocialStates {}

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  final String error;
  SocialGetAllUserErrorState(this.error);
}
