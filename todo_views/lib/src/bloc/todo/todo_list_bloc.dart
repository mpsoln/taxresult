import 'package:base/base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/src/app_context.dart';
import 'package:todo_businesslogic/todo_businesslogic.dart';
import 'package:todo_model/todo_model.dart';

class TodoListState {
  //List<Todo> todoList;
//List<ProductModel> item = const[];
//List<String> pdt = ['Type1,Type2'];
//List<CountryModel> countries = const[];

var itemAsString =[
  ProductModel(producttype: 'Type1'),
   ProductModel(producttype: 'Type2'),
];

  //TodoListState({
    //required this.todoList,
 // });
  TodoListState();
}

class TodoListBloc extends CubitBase<TodoListState> {
 // TodoListBloc() : super(CubitState(TodoListState(todoList: [])));
TodoListBloc() : super(CubitState(TodoListState()));

 late TextFieldBloc basePriceBloc;
 late TextFieldBloc lastResultBloc;
 late SearchSelectFieldBloc<ProductModel> productTypeBloc;
 late SearchSelectFieldBloc<CountryModel> countryBloc;
 late SingleSelectFormFieldBloc<StateModel,String> stateBloc;
  var calc;
  var add;
 var itemAsString =[
   ProductModel(producttype: 'Type1'),
   ProductModel(producttype: 'Type2'),
];
 

  initialize() async{
    
    basePriceBloc = TextFieldBloc(
      TextFieldState(fieldName: "BasePrice"),
      //value:
    );

  

   productTypeBloc = SearchSelectFieldBloc(
      SearchSelectFieldState(
        fieldName: "ProductType",
        asyncItems: (_) async => itemAsString,
        itemAsString: (item) => item.producttype,
       
      ),
      onValueChanged: (_) => calculationpart(),
     
    );

    lastResultBloc =TextFieldBloc(
      
      TextFieldState(fieldName: "Result"),
      onValueChanged: (_) => tresult(),
      

    );
 
    countryBloc = SearchSelectFieldBloc(
      SearchSelectFieldState(
        fieldName:"Country Name",
       //function that return item from API
        asyncItems:(_)  => getCountryList(),
        //customize the field to be shown
        itemAsString: (item) =>item.countryName,
      ),
      //value changed handler
      onValueChanged: (_) => emitStateChanged(),
    );

     /* stateBloc = SingleSelectFormFieldBloc(
      SingleSelectFormFieldState(fieldName: 'Country Name'),
      onValueChanged: ((value) {
        if(value!= null){
          items:count.map((String value) {
            
            }).toList();
        }
      })
      );*/
 }

 calculationpart(){
  if (productTypeBloc.state.current.value?.producttype.toLowerCase() == 'Type1'){
              calc = basePriceBloc.state.current.value!.parseInt() * 0.05;
            }
            else if(productTypeBloc.state.current.value?.producttype.toLowerCase() == 'Type2'){
               calc = basePriceBloc.state.current.value!.parseInt() * 0.15;
            }
            
            emitStateChanged();
            print("$calc");
 }
 tresult(){
  add = basePriceBloc.state.current.value!.parseInt() + calc;
  emitStateChanged();
  print("$add");
 }

 getCountryList() async{
  await AppContext.locator
  .get<ITodoService>().getCountryList();
 }

 /*getProductList() async{
  await AppContext.locator
   .get<ITodoService>().getProductList();
      
 }*/
 
 /* getStateList() async{
  await AppContext.locator
  .get<ITodoService>().getStateModel();
 }*/



 blocToModel(){
  return BaseModel(baseprice: basePriceBloc.state.current.value!.parseInt(), 
                   baseid: basePriceBloc.state.current.value!.parseInt()); 
}

 result() async {
    try {
      emitLoadingState();
      await AppContext.locator
      
          .get<ITodoService>()
          .createTax(blocToModel());
         
      emitSuccessState();
    } on DioError catch (e) {
      emitFailureState(e.response?.data['message']);
    } catch (error, stackTrace) {
      emitLoadedState();
      //Catcher.reportCheckedError(error, stackTrace);
    }
  }
  
   
  
}













 /* initialize() async {
    emitLoadingState();
    await getTodoList();
    emitLoadedState();
  }

  getTodoList() async {
    state.current.todoList =
        await AppContext.locator.get<ITodoService>().getTodoList();
  }

  markComplete(int id) async {
    emitLoadingState();
    await AppContext.locator.get<ITodoService>().markComplete(id);
    await getTodoList();
    emitLoadedState();
  }

  deleteTodo(int id) async {
    emitLoadingState();
    await AppContext.locator.get<ITodoService>().delete(id);
    await getTodoList();
    emitLoadedState();
  }
}*/
