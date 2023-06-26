import 'package:flutter/material.dart';
import 'package:moneymanagement_app/db/category_db.dart';
import 'package:moneymanagement_app/model/category.dart';


ValueNotifier<CategoryType> selectedRadioNotifier =
    ValueNotifier(CategoryType.income);
Future<void> CategoryAddPopUp(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(title: Text("Category"), children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                  hintText: 'Category Name', border: OutlineInputBorder()),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: [
              RadioButton(title: "Income", type: CategoryType.income),
              RadioButton(title: "Expenses", type: CategoryType.expenses),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty) {
                    return;
                  }

                  final _categoryModal = CategoryModal(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      type: selectedRadioNotifier.value,
                      name: _name);
                  CategoryDb().insertList(_categoryModal);
                   Navigator.of(ctx).pop();
                },
                child:const Text("Add"),
                ),
               
          )
        ]);
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ValueListenableBuilder(
          valueListenable: selectedRadioNotifier,
          builder: (BuildContext context, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedRadioNotifier.value = value;
                  selectedRadioNotifier.notifyListeners();
                });
          }),
      Text(title)
    ]);
  }
}
