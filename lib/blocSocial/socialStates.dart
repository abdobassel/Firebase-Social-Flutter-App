abstract class SocialStates {}

class SocialinitState extends SocialStates {}

class SocialGetUserSuccesState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}
