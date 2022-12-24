import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/bloc/todo/todo_list_bloc.dart';
import 'package:todo_model/todo_model.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late TodoListBloc _bloc;

  @override
  void initState() {
    _bloc = TodoListBloc();
    super.initState();
    _bloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildText(),
            _builddd(),
            _buildresult() ,
            _buildcountryList(),
          
           //_buildTodoList(),
          // _buildDateTime()
          ],
        ),
      ),
    );
  }

  Widget _builddd(){
    return Column(
     children:  _buildProducttype(),   
    );
  }
   Widget _buildcountryList(){
    return Column(
     children: _buidCountryDd() ,   
    );
  }
  

  Widget _buildHeader() {
    return const Text("Tax Calculation",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold));
  }
  //Textfield
  Widget _buildText(){
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
  //Dropdown
 List<Widget> _buildProducttype() {
   var fields = <Widget>[ 
  
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearchField<ProductModel>(
              label: "Product Type",
              
              bloc: _bloc.productTypeBloc,
              dropdownBuilder: (_, item) =>
              Text(item?.producttype ?? "- Select Product type -")
            ),
      ),];
         
        
      return fields;
    
  
  }

    Widget _buildresult(){
    return Column(
      
       children: [
       Padding(
         padding: const  EdgeInsets.all(8),
         child:   TextInputField(
         label: "Result",
         fieldName: "Calculated Result",
         bloc: _bloc.lastResultBloc,
        ), 
        )         
        ],
    );
  }
  

 /* Widget _buildresult(){
    return Column(
      children: [
        ElevatedButton.icon(
          //onPressed: _bloc.result(), 
          onPressed:(){
           // var res = _bloc.basePriceBloc.state.current.value!.parseInt() + calc.parseInt();
          },
          icon: const Icon(Icons.receipt), 
          label:const Text("Result")),
         Row(
          children:const  [
            Text("hhi"),
          ],
         )
      ],
    );
  }*/


  List<Widget> _buidCountryDd() {
   var fields = <Widget>[ 
  
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearchField<CountryModel>(
              label: "Country List",
              
              bloc: _bloc.countryBloc,
              //to customize the UI list
              dropdownBuilder: (_, item) =>
              Text(item?.countryName ?? "- Select country List -")
          
            ),
      ),];
         
        
      return fields;
    
  
  }

  /*List<Widget> _buidCountryDd(){
    var country = <Widget>[
      DropdownInputField(
       label: "Country Name",
       fieldName: 'Select Country Name', 
       bloc:_bloc.countryBloc,
       itemBuilder: (item)=> DropdownMenuItem(
        child:Text(),
        value:
        ),
       )

       /*DropdownInputField(
       label: "Country Name",
       fieldName: 'Select State Name', 
       bloc:_bloc.stateBloc,
       itemBuilder: (item)=> DropdownMenuItem(
        child:Text(),
        value:
        ),
       )*/

    ];
    return country;
  }*/
 
}

  /*Widget _buildProductList() {
    return BlocBuilder<TodoListBloc, CubitState<TodoListState>>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CupertinoActivityIndicator(radius: 17));
        }
        if (state.current.todoList.isEmpty) {
          return const Center(child: Text("Empty Todo List"));
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children:
                state.current.todoList.map((e) => _buildProductTile(e)).toList(),
          ),
        );
      },
    );
  }*/

 /* Widget _buildProductTile(Todo todo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 10,
            color: todo.isCompleted ? Colors.green : Colors.red,
          ),
          ListTile(
            title: Text(
              todo.todo,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(todo.desc),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check_circle_rounded,
                      color: Colors.green),
                  onPressed: () => _bloc.markComplete(todo.id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever_rounded,
                      color: Colors.red),
                  onPressed: () => _bloc.deleteTodo(todo.id),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
