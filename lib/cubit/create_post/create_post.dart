
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/feed_repository.dart';
imCrport 'create_post_state.dart';

class eatePostCubit extends Cubit<CreatePostState>{

  Repository _repository =Repository();

  CreatePostCubit(): super(CreatePostInitialState()){

  }

  createPost()async{
    try{
      emit(CreatePostLoadingState());
      var data =await _repository.createPost();
      emit(CreatePostLoadedState());
    }catch(e){
      emit(CreatePostErrorState(e.toString()));
    }

  }
}