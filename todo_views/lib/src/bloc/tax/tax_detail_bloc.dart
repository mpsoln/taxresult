/*import 'package:base/base.dart';
import 'package:dio/dio.dart';
import 'package:todo/src/app_context.dart';
import 'package:todo_businesslogic/todo_businesslogic.dart';
import 'package:todo_model/todo_model.dart';



class TaxDetailState{

  TaxDetailState();
}
class TaxDetailBloc extends CubitBase<TaxDetailState>{
  TaxDetailBloc():super(CubitState( TaxDetailState()));

 // BaseModel baseModel;
  
  late TextFieldBloc basePriceBloc;
  late SearchSelectFieldBloc<ProductModel> productTypeBloc;

 
  intialize() async{
    
    basePriceBloc = TextFieldBloc(
      TextFieldState(fieldName: "BasePrice")
    );

  

   productTypeBloc = SearchSelectFieldBloc(
      SearchSelectFieldState(
        fieldName: "ProductType",
        asyncItems: (_) => getProductList(),
        itemAsString: (item) => item.producttype,
      ),
      onValueChanged: (_) => emitStateChanged(),
     
    );

 }
 getProductList() async{
  await AppContext.locator
   .get<ITaxService>().getProductList();
      
 }


 blocToModel(){
  return BaseModel(baseprice: basePriceBloc.state.current.value!.parseInt(), 
                   baseid: basePriceBloc.state.current.value!.parseInt()); 
}

 result() async {
    try {
      emitLoadingState();
      await AppContext.locator
      
          .get<ITaxService>()
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
*/
