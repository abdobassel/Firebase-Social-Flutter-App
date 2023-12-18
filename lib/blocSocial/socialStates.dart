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

class SociaProfilePickedSuccessState extends SocialStates {}

class SociaProfilePickedErrorState extends SocialStates {}

class SocialCoverPickedSuccsessState extends SocialStates {}

class SocialCoverPickedErrorState extends SocialStates {}
