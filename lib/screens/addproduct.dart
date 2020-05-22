import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../db/category.dart';
import '../db/brand.dart';
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService =BrandService();
  GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController(); 
  List <DocumentSnapshot> brands =<DocumentSnapshot>[];
  List <DocumentSnapshot> categories =<DocumentSnapshot>[];
  List <DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  List <DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory = "sagar";
  String _currentBrand;
  Color white =Colors.white;
  Color black =Colors.black;
  Color grey =Colors.grey;
  Color red =Colors.red;
  @override
  void initState() {
    super.initState();
    _getCategories();
    // _getBrands();
        categoriesDropDown =getCategoriesDropdown();
        print(categoriesDropDown.length);
        // _currentCategory= categoriesDropDown[0].value;
       }
        getCategoriesDropdown(){
         List<DropdownMenuItem<String>> items =new List();
         for(int i=0; i< categories.length; i++){
  
           setState(() {
             categoriesDropDown.insert(0, DropdownMenuItem(child: Text(categories[i]['category']),
          value: categories[i]['category'],
           )); 
           });  
          
           
         }
         print(items.length);
        return items;
       }
     
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: white,
            leading:  Icon(Icons.close, color: black),
            title: Text('Add Product',
            style: TextStyle(color: Colors.black),),
          ),
          body: Form(
            key: _formKey,
                  child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlineButton(
                        borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14.0 , 40.0, 14.0 ,40.0),
                          child: Icon(Icons.add, color: grey),
                        ),
                        ),
                                    ),
                    ),
                     Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlineButton(
                        borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14.0 , 40.0, 14.0 ,40.0),
                          child: Icon(Icons.add, color: grey),
                        ),
                        ),
                                    ),
                    ),
                     Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlineButton(
                        borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14.0 , 40.0, 14.0 ,40.0),
                          child: Icon(Icons.add, color: grey),
                        ),
                        ),
                                    ),
                    ),
                  ],
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Enter the Product Name With 10 Character Maximum', textAlign: TextAlign.center ,style: TextStyle(color: red, fontSize: 17.0, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller:  productNameController,
                      decoration: InputDecoration(
                        hintText: 'Product Name'              
                           ),
                           validator: (value){
                             if(value.isEmpty){
                               return 'You must enter the product name';
                               }
                               else if(value.length> 10){
                                 return 'Product name cannot have more than 10 letter';
                               }
                               return 'Enter the Product Name';
                           },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(categories[index]['category']),
                        );
                      },
                    ),)
                  // Center(
                  // child: DropdownButton(
                  // value: _currentCategory,
                  // items: categoriesDropDown,
                  // onChanged:changeSelectedCategory,
                  // ),
                  // ),
              ],
            ),
          ),
        );
      }
    
       _getCategories()  async{
         List<DocumentSnapshot> data = await _categoryService.getCategories();
         print(data.length);
         setState(() {
        categories =data;
        print(categories.length);
        
          
      
         });
       }

  changeSelectedCategory(String selectedCategory) {
  setState(() =>
    _currentCategory =selectedCategory
  );
  }
}