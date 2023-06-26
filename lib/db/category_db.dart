import 'package:flutter/material.dart';
import 'package:moneymanagement_app/model/category.dart';
import 'package:hive_flutter/adapters.dart';

const CATEGORY_DB_NAME = "category_database";

abstract class ModalFunctions {
  Future<void> insertList(CategoryModal value);
  Future<List<CategoryModal>> getlist();
  Future<void> deletelist(String CategoryID);
}

class CategoryDb implements ModalFunctions {
  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }
  ValueNotifier<List<CategoryModal>> expenseListListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModal>> incomeListListener = ValueNotifier([]);
  @override
  Future<void> insertList(CategoryModal value) async {
    final _categoryDB = await Hive.openBox<CategoryModal>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModal>> getlist() async {
    final _categoryDB = await Hive.openBox<CategoryModal>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allcategories = await getlist();
    expenseListListener.value.clear();
    incomeListListener.value.clear();
    await Future.forEach(
      _allcategories,
      (CategoryModal categories) {
        if (categories.type == CategoryType.income) {
          incomeListListener.value.add(categories);
        } else {
          expenseListListener.value.add(categories);
        }
      },
    );
    expenseListListener.notifyListeners();
    incomeListListener.notifyListeners();
  }

  @override
  Future<void> deletelist(String CategoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModal>(CATEGORY_DB_NAME);
    await _categoryDB.delete(CategoryID);
    refreshUI();
  }
}
