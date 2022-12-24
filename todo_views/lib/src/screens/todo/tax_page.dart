/*import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todo/src/bloc/tax/tax_detail_bloc.dart';
import 'package:todo_model/todo_model.dart';

class Tax extends StatefulWidget {
  const Tax({Key? key}) : super(key: key);

  @override
  State<Tax> createState() => _TaxState();
}

class _TaxState extends State<Tax> {
 late TaxDetailBloc _bloc;

  @override
  void initState(){
  _bloc = TaxDetailBloc();
  super.initState();
    _bloc.intialize();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tax Calculation') ,
      ),
       body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildText(),
           //_buildProducttype() ,
          ],
        ),
      ),
    );
  }
    Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
       children: const [Text("Tax Calculation",
       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20))],
      ),
    );
  }
    Widget _buildText()
  {
    return Column(
       children: [
       Padding(
         padding: const  EdgeInsets.all(8),
         child:   TextInputField(
         label: "Base Price",
         fieldName: "Enter the Base price",
         bloc: _bloc.basePriceBloc,
        ), 
        )         
        ],
    );
  }
  // PlannedShipmentPage - shipment method
   Widget _buildProducttype() {
    return SizedBox(
      width: 300,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownSearchField<ProductModel>(
            label: "Product Type",
            isMandatory: true,
            bloc: _bloc.productTypeBloc,
            dropdownBuilder: (_, item) =>
            Text(item?.producttype ?? "- Select Product type -")
          ),
        
      ),
    );
  }

}
*/
  