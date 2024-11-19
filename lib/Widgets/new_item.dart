import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/model/category.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var _imageURL = "";
  var _isSending = false;

  void _saveItem() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSending = true;
      });

      final url = Uri.https(
          "shopping-list-3875c-default-rtdb.firebaseio.com",
          "shopping-list.json");
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "name": _enteredName,
            "quantity": _enteredQuantity,
            "category": _selectedCategory.title,
            "imageURL": _imageURL
          }));

      print(response);
      print(response.body);

      if(!mounted){
        return;
      }
      Navigator.of(context).pop();
      // Navigator.of(context).pop(GlossaryItem(
      //     id: DateTime.now.toString(),
      //     name: _enteredName,
      //     quantity: _enteredQuantity,
      //     category: _selectedCategory,
      //     imageURL: _imageURL));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Add New Items",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: InputDecoration(
                    label: Text(
                      "Name",
                      style: GoogleFonts.notoSerif(
                        color: Colors.black,
                      ),
                    ),
                    counterStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryFixedVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    errorStyle: TextStyle(
                      color: Colors.red, // Change to your desired color
                      fontSize: 14, // Optional: Change the font size
                    ),
                  ),
                  style: TextStyle(
                    color: Colors
                        .black, // Ensures the text entered is shown in black
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return "Must be between 1 to 50 characters";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredName = newValue!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text(
                            "Quantity",
                            style: GoogleFonts.notoSerif(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixedVariant),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: TextStyle(
                            color: Colors.red, // Change to your desired color
                            fontSize: 10, // Optional: Change the font size
                          ),
                        ),
                        initialValue: _enteredQuantity.toString(),
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return "Must be enter positive values only";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredQuantity = int.parse(newValue!);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                        elevation: 4,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixedVariant),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          // icon: Icon(Icons.arrow_drop_down_circle_outlined)
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: Colors.black,
                        ),
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(category.value.title),
                                  ],
                                ))
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                        dropdownColor: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      "Image URL",
                      style: GoogleFonts.notoSerif(
                        color: Colors.black,
                      ),
                    ),
                    counterStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryFixedVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    errorStyle: TextStyle(
                      color: Colors.red, // Change to your desired color
                      fontSize: 14, // Optional: Change the font size
                    ),
                  ),
                  style: TextStyle(
                    color: Colors
                        .black, // Ensures the text entered is shown in black
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1) {
                      return "Invalid URL";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _imageURL = newValue!;
                  },
                ),
                TextButton(
                  onPressed: _isSending?null:(){
                    _formKey.currentState!.reset();
                  },
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _saveItem();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Example background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      border:
                          Border.all(color: Colors.black, width: 1), // Border
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ], // Box shadow for elevation effect
                    ),
                    padding: const EdgeInsets.all(16), // Padding inside the box
                    child: _isSending? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ): Text(
                      "Add item",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )

                // GestureDetector(
                //   onTap: () {
                //     _saveItem();
                //   },
                //   child: Container(
                //     child: Text("Add item", style: TextStyle(color: Colors.black),),
                //   ),
                // )
              ],
            )),
      ),
    );
  }
}

// https://img.freepik.com/free-vector/milk-bottle-glass-nature_1284-32751.jpg Milk
// https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=800 Apple
// https://plus.unsplash.com/premium_photo-1675279010969-e85bfbd402dc?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8aWNlY3JlYW18ZW58MHx8MHx8fDA%3D Ice cream
// https://housing.com/news/wp-content/uploads/2022/11/image2-102.jpg Green veg
// https://media.istockphoto.com/id/172876004/photo/banana-wallpaper.jpg?s=612x612&w=0&k=20&c=DjUIq77Fh3ljde_WJNwYl17e86VxMUpOwYiVL2XJo9U= Banana
// https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFhWHAXhihxVOYM4ssMV7PIiViTJ7fixkP6Q&s Dairy milk
// https://seed2plant.in/cdn/shop/files/Thailand_mango.jpg?v=1720165484&width=1500 Mango
