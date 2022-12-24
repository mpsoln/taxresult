// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:collection/collection.dart';

class BaseModel {
  int baseid;
  int baseprice;

  BaseModel({
    required this.baseid,
    required this.baseprice,
  });

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseid': baseid,
      'baseprice': baseprice,
    };
  }

  factory BaseModel.fromMap(Map<String, dynamic> map) {
    return BaseModel(
      baseid: map['baseid'] as int,
      baseprice: map['baseprice'] as int,
    );
  }

 
}
//Dropdown- producttype
 class ProductModel {
  String producttype;
 // List<String> type=['Type1','Type2'];
  
  ProductModel({
    required this.producttype,
  });

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'producttype': producttype,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      producttype: map['producttype'] as String,
    );
  }

 }

 //dependent multidropdown

class CountryModel {
  int countryId;
  String countryName;
  CountryModel({
    required this.countryId,
    required this.countryName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countryId': countryId,
      'countryName': countryName,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      countryId: map['countryId'] as int,
      countryName: map['countryName'] as String,
    );
  }

 
}

class StateModel {
    int stateId;
    int? countryId;
    String stateName;
  StateModel({
    required this.stateId,
    this.countryId,
    required this.stateName,
  });
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stateId': stateId,
      'countryId': countryId,
      'stateName': stateName,
    };
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      stateId: map['stateId'] as int,
      countryId: map['countryId'] as int,
      stateName: map['stateName'] as String,
    );
  }

  
   } 

  

 

 
 
  /*class Todo {
  int id;
  String todo;
  String desc;
  bool isCompleted;

  Todo({
    required this.id,
    required this.todo,
    required this.desc,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'desc': desc,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      todo: map['todo'] as String,
      desc: map['desc'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}*/
