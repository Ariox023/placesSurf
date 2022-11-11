// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:places/domain/category.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/presets/styles/text_styles.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final listCategories =
      Hive.box<Category>(AppStrings.boxFiltersListCategories);
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.scrAddSightScreenCategory,
          style: theme.textTheme.displaySmall,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(selectedCategory);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: theme.textTheme.labelMedium?.color,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: listCategories.values.length,
        separatorBuilder: (context, index) => Divider(
          height: 0.8,
          color: AppColors.inactiveBlack.withOpacity(0.56),
        ),
        itemBuilder: (context, index) {
          final element = listCategories.values.elementAt(index);

          return ListTile(
            title: Text(
              element.name,
              style: theme.textTheme.labelMedium,
            ),
            trailing: Icon(
              Icons.check_rounded,
              size: 24,
              color: element.name == selectedCategory
                  ? theme.buttonColor
                  : Colors.transparent,
            ),
            onTap: () {
              setState(() {
                selectedCategory = listCategories.values.elementAt(index).name;
              });
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            if (selectedCategory.isNotEmpty) {
              Navigator.of(context).pop(selectedCategory);
            }
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: selectedCategory.isNotEmpty
                  ? theme.buttonColor
                  : theme.cardColor,
            ),
            child: Center(
              child: Text(
                AppStrings.buttonSave.toUpperCase(),
                style: selectedCategory.isNotEmpty
                    ? AppTextStyles.button
                    : AppTextStyles.button.copyWith(
                        color: AppColors.inactiveBlack.withOpacity(0.56),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
