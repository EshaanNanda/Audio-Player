import 'package:flutter/material.dart';
 class FavProvider extends ChangeNotifier{
   List<String> _favs=[];
   List<String> get favs=>_favs;

   void toggleFavourite(String name){
     final isExists=_favs.contains(name);
     if(isExists){
       _favs.remove(name);
     }else{
       _favs.add(name);
     }
     notifyListeners();
   }

   bool isExist(String name){
     final isExist=_favs.contains(name);
     return isExist;
   }
   void clearFavourite(){
     _favs.clear();
     favs.clear();
     notifyListeners();
   }
 }

