import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/model/glossary_item.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

import 'new_item.dart';

class GlossaryList extends StatefulWidget {
  const GlossaryList({super.key});

  @override
  State<GlossaryList> createState() => _GlossaryListState();
}

class _GlossaryListState extends State<GlossaryList> {
  List<GlossaryItem> _glossaryItems = [];
  var _isLoading = true;

  final Set<int> _longPressedItems = {};

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https("shopping-list-3875c-default-rtdb.firebaseio.com",
        "shopping-list.json");
    final response = await http.get(url);

    final Map<String, dynamic> listData = json.decode(response.body);
    print(listData);

    final List<GlossaryItem> _loadedItem = [];

    for (final glossaryItem in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (catItem) => catItem.value.title == glossaryItem.value["category"],
          )
          .value;
      _loadedItem.add(GlossaryItem(
          id: glossaryItem.key,
          name: glossaryItem.value["name"],
          quantity: glossaryItem.value["quantity"],
          category: category,
          imageURL: glossaryItem.value["imageURL"]));
    }

    setState(() {
      _glossaryItems = _loadedItem;
      _isLoading = false;
    });
  }

  void _addItem() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    // if (newItem == null) {
    //   return;
    // }
    //
    // setState(() {
    //   _glossaryItems.add(newItem);
    // });
    _loadItem();
  }
  
  void _removeItem(GlossaryItem glossaryItem){
    final glossaryIndex = _glossaryItems.indexOf(glossaryItem);
    setState(() {
      _glossaryItems.remove(glossaryItem);
    });
    final url = Uri.https("shopping-list-3875c-default-rtdb.firebaseio.com","shopping-list/${glossaryItem.id}.json");
    var response = http.delete(url);
    print(response);
  }

  void _toggleLongPress(int index) {
    setState(() {
      if (_longPressedItems.contains(index)) {
        _longPressedItems.remove(index);
      } else {
        _longPressedItems.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("The [item] is currently unavilable in our inventory...",
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
    );

    if (_isLoading) {
      mainContent = Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_glossaryItems.isNotEmpty) {
      mainContent = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of columns
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio:
              2 / 3, // Adjust this to change the item aspect ratio
        ),
        padding: const EdgeInsets.all(10.0),
        itemCount: _glossaryItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () => _toggleLongPress(index),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        // color: glossaryItems[index].category.color,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0)),
                      ),
                      child: _glossaryItems[index].imageURL.isNotEmpty
                          ? Stack(fit: StackFit.expand, children: [
                              FadeInImage(
                                placeholder: MemoryImage(kTransparentImage),
                                image: NetworkImage(
                                    _glossaryItems[index].imageURL),
                                fit: BoxFit.cover,
                              ),
                              if (_longPressedItems.contains(index))
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _removeItem(_glossaryItems[index]);
                                      });
                                    },
                                    icon: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.55),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: const Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  height: 40,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _glossaryItems[index].name,
                                      style: GoogleFonts.notoSerif(
                                          color: Colors.purpleAccent,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            ])
                          : const Icon(Icons.image_not_supported,
                              color: Colors.grey, size: 40),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: Icon(Icons.add, color: Colors.yellow, size: 30),
            ),
          ],
          title: const Text(
            "Glossary List",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: mainContent
        // GridView.builder(
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2, // Set the number of columns
        //     crossAxisSpacing: 10.0,
        //     mainAxisSpacing: 10.0,
        //     childAspectRatio: 2 / 3, // Adjust this to change the item aspect ratio
        //   ),
        //   padding: const EdgeInsets.all(10.0),
        //   itemCount: glossaryItems.length,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       elevation: 4,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //       ),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         children: [
        //           Expanded(
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 color: glossaryItems[index].category.color,
        //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
        //               ),
        //               child: glossaryItems[index].category.imageCategory != null
        //                   ? FadeInImage(
        //                 placeholder: MemoryImage(kTransparentImage),
        //                 image: NetworkImage(
        //                     glossaryItems[index].category.imageCategory!),
        //                 fit: BoxFit.cover,
        //               )
        //                   : const Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text(
        //               glossaryItems[index].name,
        //               style: GoogleFonts.notoSerif(
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.w900,
        //                   fontSize: 16),
        //               textAlign: TextAlign.center,
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
