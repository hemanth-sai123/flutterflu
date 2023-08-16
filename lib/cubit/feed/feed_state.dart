import 'package:flut_task/modal/post_modal.dart' as post_modal;
abstract class FeedState{

}
//
class FeedInitialState extends FeedState{}


class FeedLoadingState extends FeedState {
  FeedLoadingState();
}
class FeedLoadedState extends FeedState{
  List<post_modal.Post> posts;
  FeedLoadedState(this.posts);
}


class FeedErrorState extends FeedState{
  final String error;
  FeedErrorState(this.error);
}