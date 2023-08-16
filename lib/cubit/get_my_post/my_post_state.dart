import 'package:flut_task/modal/my_post_modal.dart' as my_post_modal;
abstract class MyPostsState{

}
//
class MyPostsInitialState extends MyPostsState{}


class MyPostsLoadingState extends MyPostsState {
  MyPostsLoadingState();
}
class MyPostsLoadedState extends MyPostsState{
  List<my_post_modal.Post> posts;
  MyPostsLoadedState(this.posts);
}


class MyPostsErrorState extends MyPostsState{
  final String error;
  MyPostsErrorState(this.error);
}