import 'package:shopping_list_app/model/category.dart';

class GlossaryItem {
  final String id;
  final String name;
  final int quantity;
  final Category category;
  final String imageURL;

  const GlossaryItem({required this.id, required this.name, required this.quantity, required this.category, required this.imageURL});
}