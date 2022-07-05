// ignore_for_file: deprecated_member_use, cascade_invocations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/colors/colors.dart';
import 'package:places/presets/colors/gradients.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';
import 'package:places/ui/wigets/containers/conainer_for_image_network.dart';
// import 'package:places/ui/wigets/text_fields/my_text_field.dart';

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
  final _serchEditionControllerLatitude = TextEditingController();
  final _serchEditionControllerLongitude = TextEditingController();
  final _serchEditionControllerDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String category = '';
  String? errorTextCategory;
  String name = '';
  String? errorTextName;
  String latitude = '';
  String? errorTextLatitude;
  String longitude = '';
  String? errorTextLongitude;
  String description = '';
  String? errorTextDescription;

  FocusNode focusNodeCategory = FocusNode();
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeLat = FocusNode();
  FocusNode focusNodeLon = FocusNode();
  FocusNode focusNodeDescription = FocusNode();

  @override
  void initState() {
    focusNodeCategory.addListener(() => setState(() {}));
    focusNodeName.addListener(() => setState(() {}));
    focusNodeLat.addListener(() => setState(() {}));
    focusNodeLon.addListener(() => setState(() {}));
    focusNodeDescription.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _serchEditionControllerCategory.dispose();
    _serchEditionControllerName.dispose();
    _serchEditionControllerLatitude.dispose();
    _serchEditionControllerLongitude.dispose();
    _serchEditionControllerDescription.dispose();
    focusNodeCategory.dispose();
    focusNodeName.dispose();
    focusNodeLat.dispose();
    focusNodeLon.dispose();
    focusNodeDescription.dispose();
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
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    NotificationListener<AdressNotification>(
                      child: SizedBox(
                        height: 72,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (context, count) => Dismissible(
                            direction: DismissDirection.up,
                            onDismissed: (dir) {
                              setState(() {
                                if (count != 0) {
                                  listOfImages.removeAt(count);
                                }
                              });
                            },
                            key: UniqueKey(),
                            child: AddImage(
                              adress: listOfImages[count],
                            ),
                          ),
                          itemCount: listOfImages.length,
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
                      textInputAction: TextInputAction.next,
                      controller: _serchEditionControllerCategory,
                      focusNode: focusNodeCategory,
                      decoration: InputDecoration(
                        constraints:
                            const BoxConstraints(maxHeight: 72, minHeight: 72),
                        hintText: AppStrings.scrAddSightScreenEmptyCategory,
                        contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                        .pushNamed(AppStrings.categoriesScreen)
                                    as String;
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
                          if (errorTextCategory == null) {
                            FocusScope.of(context).requestFocus(focusNodeName);
                          }
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
                      textInputAction: TextInputAction.next,
                      controller: _serchEditionControllerName,
                      decoration: myTextDecoration(
                        theme,
                        errorTextName,
                        _serchEditionControllerName,
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppStrings.scrAddSightScreenMapLat,
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Text(
                            AppStrings.scrAddSightScreenMapLong,
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _serchEditionControllerLatitude,
                            decoration: myTextDecoration(
                              theme,
                              errorTextLatitude,
                              _serchEditionControllerLatitude,
                            ),
                            keyboardType: TextInputType.number,
                            style: theme.textTheme.labelMedium,
                            onFieldSubmitted: (value) {
                              name = value;
                              setState(() {
                                errorTextLatitude = validatorLatitude(value);
                              });
                            },
                            maxLength: 10,
                            validator: validatorLatitude,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[\d\.\-]'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _serchEditionControllerLongitude,
                            decoration: myTextDecoration(
                              theme,
                              errorTextLongitude,
                              _serchEditionControllerLongitude,
                            ),
                            keyboardType: TextInputType.number,
                            style: theme.textTheme.labelMedium,
                            onFieldSubmitted: (value) {
                              name = value;
                              setState(() {
                                errorTextLongitude = validatorLongitude(value);
                              });
                            },
                            validator: validatorLongitude,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[\d\.\-]'),
                              ),
                            ],
                            onEditingComplete: () => log('onEditingComplete'),
                            onChanged: (_) => log('onChanged'),
                            onSaved: (_) => log('onSaved'),
                            onTap: () => log('onTap'),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      radius: 24,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        final pos = await Navigator.of(context)
                            .pushNamed(AppStrings.mapScreen);
                        if (pos != null) {
                          setState(() {
                            pos as LatLng;
                            _serchEditionControllerLatitude.text =
                                pos.latitude.toStringAsFixed(6);
                            _serchEditionControllerLongitude.text =
                                pos.longitude.toStringAsFixed(6);
                          });
                        }
                      },
                      child: Text(
                        AppStrings.scrAddSightScreenGoToMap,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.labelMedium
                            ?.copyWith(color: Colors.green),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 32,
                      child: Text(
                        AppStrings.scrAddSightScreenDescription,
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _serchEditionControllerDescription,
                      focusNode: focusNodeDescription,
                      decoration: myTextDecoration(
                        theme,
                        errorTextDescription,
                        _serchEditionControllerDescription,
                        hint: AppStrings.scrAddSightScreenDescriptionHint,
                      ),
                      style: theme.textTheme.labelMedium,
                      minLines: 4,
                      maxLines: 12,
                      onFieldSubmitted: (value) {
                        description = value;
                        setState(() {
                          errorTextDescription = validatorDescription(value);
                        });
                      },
                      validator: validatorDescription,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration myTextDecoration(
    ThemeData theme,
    String? errorText,
    TextEditingController controller, {
    String? hint = '',
  }) {
    return InputDecoration(
      isDense: true,
      constraints: const BoxConstraints(maxHeight: 84, minHeight: 84),
      errorText: errorText,
      hintText: hint,
      errorStyle: theme.textTheme.labelSmall?.copyWith(
        color: theme.errorColor,
        fontSize: 12,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(
          color: theme.buttonColor.withOpacity(0.4),
        ),
      ),
      errorMaxLines: 2,
      counterText: '',
      suffixIcon: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        constraints: const BoxConstraints(),
        icon: Icon(
          Icons.clear_rounded,
          size: 24,
          color: controller.text.isEmpty
              ? Colors.transparent
              : theme.textTheme.labelMedium?.color,
        ),
        onPressed: () {
          setState(() {
            controller.text = '';
          });
        },
      ),
      suffixIconConstraints: BoxConstraints.tight(
        const Size.square(40),
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

  String? validatorDescription(String? val) {
    if (val!.isEmpty) {
      return AppStrings.scrAddSightScreenDescriptionError;
    }

    return null;
  }

  String? validatorLatitude(String? val) {
    final latitudeNum = double.tryParse(val!);
    if (latitudeNum == null) {
      return AppStrings.scrAddSightScreenMapEmptyLat;
    }
    if (latitudeNum < -90 || latitudeNum > 90) {
      return AppStrings.scrAddSightScreenMapErrorLat;
    }

    return null;
  }

  String? validatorLongitude(String? val) {
    final longitudeNum = double.tryParse(val!);
    if (longitudeNum == null) {
      return AppStrings.scrAddSightScreenMapEmptyLong;
    }
    if (longitudeNum < -180 || longitudeNum > 180) {
      return AppStrings.scrAddSightScreenMapErrorLong;
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
