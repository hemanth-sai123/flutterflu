abstract class CreatePostState{

}
//
class CreatePostInitialState extends CreatePostState{}


class CreatePostLoadingState extends CreatePostState {
  CreatePostLoadingState();
}
class CreatePostLoadedState extends CreatePostState{
  //List<post_modal.Post> posts;
  CreatePostLoadedState();
}


class CreatePostErrorState extends CreatePostState{
  final String error;
  CreatePostErrorState(this.error);
}