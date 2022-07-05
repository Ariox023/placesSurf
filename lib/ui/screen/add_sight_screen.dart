// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/ui/wigets/containers/conainer_for_image_network.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final listOfImages = [''];
  final listCategories =
      Hive.box<Category>(AppStrings.boxFiltersListCategories);
  final listSights = Hive.box<Sight>(AppStrings.boxSights);
  final _serchEditionControllerCategory = TextEditingController();
  final _serchEditionControllerName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String category = '';
  String? errorTextCategory;
  String name = '';
  String? errorTextName;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _serchEditionControllerCategory.dispose();
    _serchEditionControllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        title: Text(
          AppStrings.scrAddSightScreen,
          style: theme.textTheme.displaySmall,
        ),
        leading: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
              (states) => Colors.transparent,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppStrings.buttonCancellation,
            style: theme.textTheme.headlineSmall!
                .copyWith(color: AppColors.secondary2),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              NotificationListener<AdressNotification>(
                child: SizedBox(
                  height: 72,
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, count) => AddImage(
                        adress: listOfImages[count],
                      ),
                      itemCount: listOfImages.length,
                    ),
                  ),
                ),
                onNotification: (notification) {
                  if (notification.removeAdress.isNotEmpty) {
                    listOfImages.removeWhere(
                      (element) => element == notification.removeAdress,
                    );
                  } else {
                    listOfImages.add(notification.adress);
                  }
                  setState(() {});

                  return true;
                },
              ),
              const LineSize24(),
              Text(
                AppStrings.scrAddSightScreenCategory.toUpperCase(),
                style: theme.textTheme.labelSmall,
              ),
              TextFormField(
                controller: _serchEditionControllerCategory,
                decoration: InputDecoration(
                  constraints:
                      const BoxConstraints(maxHeight: 72, minHeight: 72),
                  hintText: AppStrings.scrAddSightScreenEmptyCategory,
                  hintStyle: theme.textTheme.labelMedium!
                      .copyWith(color: AppColors.inactiveBlack),
                  errorText: errorTextCategory,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24,
                      color: theme.textTheme.labelMedium?.color,
                    ),
                    onPressed: () async {
                      _serchEditionControllerCategory.text =
                          await Navigator.of(context)
                              .pushNamed(AppStrings.categoriesScreen) as String;
                      setState(() {
                        errorTextCategory = validatorCategory(
                          _serchEditionControllerCategory.text,
                        );
                      });
                    },
                  ),
                ),
                style: theme.textTheme.labelMedium,
                onFieldSubmitted: (value) {
                  category = value;
                  setState(() {
                    errorTextCategory = validatorCategory(value);
                  });
                },
                validator: validatorCategory,
              ),
              Text(
                AppStrings.scrAddSightScreenName,
                style: theme.textTheme.labelSmall,
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                controller: _serchEditionControllerName,
                decoration: InputDecoration(
                  constraints:
                      const BoxConstraints(maxHeight: 64, minHeight: 64),
                  errorText: errorTextName,
                  errorMaxLines: 2,
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: theme.buttonColor.withOpacity(0.4)),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                ),
                style: theme.textTheme.labelMedium,
                onFieldSubmitted: (value) {
                  name = value;
                  setState(() {
                    errorTextName = validatorName(value);
                  });
                },
                validator: validatorName,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validatorCategory(String? val) {
    if (val!.isEmpty) {
      return AppStrings.scrAddSightScreenCategoryError2;
    }
    for (final element in listCategories.values) {
      final cat = element.name;
      if (cat == val) {
        return null;
      }
    }

    return '${AppStrings.scrAddSightScreenCategoryError}: $val';
  }

  String? validatorName(String? val) {
    if (val!.isEmpty) {
      return AppStrings.scrAddSightScreenNameError2;
    }

    for (final element in listSights.values) {
      final sightName = element.name;
      if (sightName == val) {
        return '${AppStrings.scrAddSightScreenNameError}: $val';
      }
    }

    return null;
  }
  //   final state = _formKey.currentState;
  // if (state!.validate()) {
  //   state.save();
  // }
}

class LineSize24 extends StatelessWidget {
  const LineSize24({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 24,
    );
  }
}

class AdressNotification extends Notification {
  final String adress;
  final String removeAdress;
  const AdressNotification({required this.adress, this.removeAdress = ''});
}

class AddImage extends StatelessWidget {
  final String adress;
  const AddImage({Key? key, this.adress = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ignore: prefer-conditional-expressions
    if (adress.isNotEmpty) {
      return Container(
        height: 72,
        width: 72,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            ImageNetworkWiget(
              url: adress,
              height: 72,
              width: 72,
              gradient: AppGradients.whiteImageGradient,
            ),
            Positioned(
              top: 4,
              right: 4,
              child: InkWell(
                onTap: () => AdressNotification(
                  removeAdress: adress,
                  adress: '',
                )..dispatch(context),
                child: SvgPicture.asset(AppIcons.iconRemove),
              ),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        borderRadius: BorderRadius.circular(12),
        highlightColor: Colors.transparent,
        onTap: () => const AdressNotification(
          adress:
              'https://st.depositphotos.com/1000122/2033/i/600/depositphotos_20337813-stock-photo-portrait-of-young-cats-group.jpg',
        )..dispatch(context),
        child: Container(
          height: 72,
          width: 72,
          constraints: const BoxConstraints(maxHeight: 72, maxWidth: 72),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.buttonColor,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.add,
            size: 40,
            color: theme.buttonColor,
          ),
        ),
      );
    }
  }
}
