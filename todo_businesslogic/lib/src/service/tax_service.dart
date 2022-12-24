
/*import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_businesslogic/src/interface/ITax_service.dart';
import 'package:todo_model/todo_model.dart';

class TaxService extends ITaxService {
  Dio client;

  TaxService({
    required this.client,
  });

  //TextBox
   @override
  Future<void> createTax(BaseModel tax) async {
    await client.post('/tax', data: tax.toMap());
  }
  //Dropdown
   
 @override
  Future<List<ProductModel>> getProductList() async{
   Response response = await client.get('/tax');
   return (response.data as List)
   .map((e) => ProductModel.fromMap(e))
   .toList();
  }

   
 
}*/
