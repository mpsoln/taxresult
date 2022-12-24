import 'package:todo_model/todo_model.dart';

abstract class ITodoService {
  
 /* Future<List<Todo>> getTodoList();

  Future<void> createTodo(Todo todo);

  Future<void> markComplete(int id);

  Future<void> delete(int id);*/

   Future<void> createTax(BaseModel tax);

   Future<List<ProductModel>>  getProductList();

   Future<List<CountryModel>> getCountryList();
   
   Future<List<StateModel>> getStateModel();

}
