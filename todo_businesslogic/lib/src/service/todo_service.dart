// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:todo_businesslogic/src/interface/ITodo_Service.dart';
import 'package:todo_model/todo_model.dart';

class TodoService extends ITodoService {
  Dio client;

  TodoService({
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

 @override
   Future<List<CountryModel>> getCountryList() async{
    Response response = await client.get('/tax');
    return (response.data as List)
    .map((e) => CountryModel.fromMap(e))
    .toList();
   }

   Future<List<StateModel>> getStateModel() async{
    Response response = await client.get('/tax');
    return (response.data as List)
    .map((e) => StateModel.fromMap(e))
    .toList();
   }

}
/* @override
  Future<List<Todo>> getTodoList() async {
    Response response = await client.get('/todos');
    return (response.data as List).map((e) => Todo.fromMap(e)).toList();
  }

  @override
  Future<void> createTodo(Todo todo) async {
    await client.post('/todos', data: todo.toMap());
  }

  @override
  Future<void> markComplete(int id) async {
    await client.patch('/todos/$id', data: {"isCompleted": true});
  }

  @override
  Future<void> delete(int id) async {
    await client.delete('/todos/$id');
  }*/