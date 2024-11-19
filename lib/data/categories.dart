import 'package:flutter/material.dart';

import '../model/category.dart';

const categories = {
  Categories.vegetables: Category(
    title: "Vegetables",
    color: Colors.blue,
    // imageCategory: "https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-2foodgroups_vegetables_detailfeature.jpg?sfvrsn=226f1bc7_6"
  ),
  Categories.carbs: Category(
    title: "Carbs",
    color: Colors.green,
    // imageCategory: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw6XYoqXBnpPNcuGtTzV6-iWRdPT9AQUNtVg&s"
  ),Categories.convenience: Category(

    title: "Convenience",
    color: Colors.yellow,
  ),Categories.dairy: Category(

    title: "Dairy",
    color: Colors.red,
    // imageCategory: "https://milkandhoneyranch.com/wp-content/uploads/2023/06/jiggi21_a_beautiful_cow_close_up_with_a_glass_of_milk_on_a_tabl_38f92050-d3d4-488d-a9d0-ed861899b379-e1687377584795.png",
  ),Categories.fruits: Category(

    title: "Fruits",
    color: Colors.blueGrey,
    // imageCategory: "https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-3foodgroups_fruits_detailfeature.jpg?sfvrsn=64942d53_4"
  ),Categories.frozenFoods: Category(

    title: "Frozen Foods",
    color: Colors.lightGreen,
    // imageCategory: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMkDn6MJvmv_6ddT8V7wZTrsjwziYLXzs6Bw&s"
  ),Categories.hygiene: Category(

    title: "Hygiene",
    color: Colors.tealAccent,
  ),Categories.spices: Category(

    title: "Spices",
    color: Colors.pink,
  ),Categories.sweets: Category(

    title: "Sweets",
    color: Colors.cyan,
  ),Categories.other: Category(

    title: "Others",
    color: Colors.blueAccent,
  ),
};