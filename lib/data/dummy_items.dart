import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/model/category.dart';

import '../model/glossary_item.dart';

final glossaryItems = [
  GlossaryItem(
     id: "a",
    name: "Milk",
    quantity: 1,
    category: categories[Categories.dairy]!,
    imageURL: ""
  ),
  GlossaryItem(
    id: "b",
    name: "Bananas",
    quantity: 12,
    category: categories[Categories.fruits]!,
    imageURL: ""
  ),
  GlossaryItem(
    id: "c",
    name: "Ice cream",
    quantity: 1,
    category: categories[Categories.frozenFoods]!,
    imageURL: ""
  ),
];