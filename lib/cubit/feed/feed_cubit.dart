
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/feed_repository.dart';
import 'feed_state.dart';

class FeedCubit extends Cubit<FeedState>{

  Repository _repository =Repository();

  FeedCubit(): super(FeedInitialState()){
    _init();
  }

  _init()async{
    try{
      emit(FeedLoadingState());
      var data =await _repository.fetchPosts();
      emit(FeedLoadedState(data));
    }catch(e){
      emit(FeedErrorState(e.toString()));
    }

  }
}