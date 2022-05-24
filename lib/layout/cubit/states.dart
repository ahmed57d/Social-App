abstract class SocialStates {}

class SocialInitialState extends SocialStates {
}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}


class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates
{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}



class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;

  SocialGetPostsErrorState(this.error);
}



class SocialPostLikeSuccessState extends SocialStates {}

class SocialPostLikeErrorState extends SocialStates
{
  final String error;

  SocialPostLikeErrorState(this.error);
}


class SocialGetPostLikeSuccessState extends SocialStates {}

class SocialGetPostLikeErrorState extends SocialStates
{
  final String error;

  SocialGetPostLikeErrorState(this.error);
}


class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}


class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialProfileImagePickedLoadingState extends SocialStates {}



class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}



class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}



class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}


class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}


class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}



class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialGetMessagesLoadingState extends SocialStates {}


class SocialLikeButtonTapSuccessState extends SocialStates {}



class SocialPostCommentSuccessState extends SocialStates {}

class SocialPostCommentErrorState extends SocialStates {
  final String error;

  SocialPostCommentErrorState(this.error);
}

class SocialLogOutSuccessState extends SocialStates {}



class SocialGetCommentatorLoadingState extends SocialStates {}

class SocialGetCommentatorSuccessState extends SocialStates {}

class SocialGetCommentatorErrorState extends SocialStates
{
  final String error;

  SocialGetCommentatorErrorState(this.error);
}

