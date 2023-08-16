
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flut_task/modal/post_modal.dart' as post_modal;
import 'package:flut_task/modal/my_post_modal.dart' as my_post_modal;

class Repository{
  Future<List<post_modal.Post>> fetchPosts() async{
    try{
      var response =await http.get(Uri.parse("https://dummyjson.com/posts"));
      return post_modal.postModelFromJson(response.body).posts;
    }catch(e){
      throw e;
    }

  }

  Future<void> createPost() async{
    var data ={
      "title": 'I love my india',
      "userId": 5,
      /* other post data */
    };
    try{
      var response =await http.post(Uri.parse("https://dummyjson.com/posts/add"),body: json.encode(data));
      print(response.body.toString());
    }catch(e){
      throw e;
    }
  }

  Future<List<my_post_modal.Post>> fetchMyPosts() async{
    try{
      var response =await http.get(Uri.parse("https://dummyjson.com/posts/user/5"));
      return my_post_modal.myPostModalFromJson(response.body).posts;
    }catch(e){
      throw e;
    }

  }
}