import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/feed_repository.dart';
import 'my_post_state.dart';

class MyPostCubit extends Cubit<MyPostsState>{

  Repository _repository =Repository();

  MyPostCubit(): super(MyPostsInitialState()){
    _init();
  }

  _init()async{
    try{
      emit(MyPostsLoadingState());
      var data =await _repository.fetchMyPosts();
      emit(MyPostsLoadedState(data));
    }catch(e){
      emit(MyPostsErrorState(e.toString()));
    }

  }
}