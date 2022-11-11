import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  const SearchField({Key? key, required this.controller}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextField(
        showCursor: false,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).cardColor,
          constraints: const BoxConstraints(
            maxHeight: 40,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SvgPicture.asset(
              AppIcons.searchMin,
            ),
          ),
          alignLabelWithHint: true,
          hintText: AppStrings.searchField,
          hintStyle: Theme.of(context).textTheme.labelSmall,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              child: SvgPicture.asset(
                AppIcons.filter,
                // ignore: deprecated_member_use
                color: Theme.of(context).buttonColor,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppStrings.filtersScreen);
              },
            ),
          ),
        ),
      ),
    );
  }
}
