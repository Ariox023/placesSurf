// ignore_for_file: deprecated_member_use, cascade_invocations

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
import 'package:places/presets/styles/text_styles.dart';
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
  String? errorTextCategory;
  String? errorTextName;
  String? errorTextLatitude;
  String? errorTextLongitude;
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
    final canTap = _serchEditionControllerCategory.text.isNotEmpty &&
        _serchEditionControllerName.text.isNotEmpty &&
        _serchEditionControllerLatitude.text.isNotEmpty &&
        _serchEditionControllerLongitude.text.isNotEmpty &&
        _serchEditionControllerDescription.text.isNotEmpty &&
        errorTextCategory == null &&
        errorTextName == null &&
        errorTextLatitude == null &&
        errorTextLongitude == null &&
        errorTextDescription == null;

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
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          scrollDirection: Axis.horizontal,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        constraints:
                            const BoxConstraints(maxHeight: 72, minHeight: 72),
                        hintText: AppStrings.scrAddSightScreenEmptyCategory,
                        contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        hintStyle: theme.textTheme.labelMedium!
                            .copyWith(color: AppColors.inactiveBlack),
                        errorText: errorTextCategory,
                        errorStyle: theme.textTheme.labelMedium!
                            .copyWith(fontSize: 12, color: Colors.red),
                        suffixIcon: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
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
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      controller: _serchEditionControllerName,
                      focusNode: focusNodeName,
                      decoration: myTextDecoration(
                        theme,
                        errorTextName,
                        _serchEditionControllerName,
                        isActivated: focusNodeName.hasFocus,
                      ),
                      style: theme.textTheme.labelMedium,
                      onFieldSubmitted: (value) {
                        setState(() {
                          errorTextName = validatorName(value);
                          if (errorTextName == null) {
                            FocusScope.of(context).requestFocus(focusNodeLat);
                          }
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
                            focusNode: focusNodeLat,
                            decoration: myTextDecoration(
                              theme,
                              errorTextLatitude,
                              _serchEditionControllerLatitude,
                              isActivated: focusNodeLat.hasFocus,
                            ),
                            keyboardType: TextInputType.number,
                            style: theme.textTheme.labelMedium,
                            onFieldSubmitted: (value) {
                              setState(() {
                                errorTextLatitude = validatorLatitude(value);
                                if (errorTextLatitude == null) {
                                  FocusScope.of(context)
                                      .requestFocus(focusNodeLon);
                                }
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
                            focusNode: focusNodeLon,
                            decoration: myTextDecoration(
                              theme,
                              errorTextLongitude,
                              _serchEditionControllerLongitude,
                              isActivated: focusNodeLon.hasFocus,
                            ),
                            keyboardType: TextInputType.number,
                            style: theme.textTheme.labelMedium,
                            onFieldSubmitted: (value) {
                              setState(() {
                                errorTextLongitude = validatorLongitude(value);
                                if (errorTextLongitude == null) {
                                  FocusScope.of(context)
                                      .requestFocus(focusNodeDescription);
                                }
                              });
                            },
                            validator: validatorLongitude,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[\d\.\-]'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
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
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.sentences,
                      controller: _serchEditionControllerDescription,
                      focusNode: focusNodeDescription,
                      decoration: myTextDecoration(
                        theme,
                        errorTextDescription,
                        _serchEditionControllerDescription,
                        isActivated: focusNodeDescription.hasFocus,
                        hint: AppStrings.scrAddSightScreenDescriptionHint,
                      ),
                      style: theme.textTheme.labelMedium,
                      minLines: 4,
                      maxLines: 12,
                      onFieldSubmitted: (value) {
                        setState(() {
                          final state = _formKey.currentState;
                          if (state!.validate()) {
                            state.save();
                            focusNodeDescription.unfocus();
                          }
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
      bottomNavigationBar: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            final state = _formKey.currentState;
            if (state!.validate()) {
              state.save();
              listOfImages.removeAt(0);
              final newSight = Sight(
                name: _serchEditionControllerName.text,
                lat: double.parse(_serchEditionControllerLatitude.text),
                lon: double.parse(_serchEditionControllerLongitude.text),
                url: listOfImages,
                details: _serchEditionControllerDescription.text,
                type: _serchEditionControllerCategory.text,
              );
              final listSights = Hive.box<Sight>(AppStrings.boxSights);
              listSights.put(newSight.name, newSight);
              Navigator.of(context).pop();
            }
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: canTap ? theme.buttonColor : theme.cardColor,
            ),
            child: Center(
              child: Text(
                AppStrings.buttonSave.toUpperCase(),
                style: canTap
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

  // ignore: long-parameter-list
  InputDecoration myTextDecoration(
    ThemeData theme,
    String? errorText,
    TextEditingController controller, {
    String? hint = '',
    bool isActivated = false,
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
      suffixIcon: isActivated
          ? IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.clear_rounded,
                size: 24,
                color: theme.textTheme.labelMedium?.color,
              ),
              onPressed: () {
                setState(() {
                  controller.text = '';
                });
              },
            )
          : null,
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

    return adress.isNotEmpty
        ? Container(
            height: 72,
            width: 72,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.hardEdge,
            child: Stack(children: [
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
                  onTap: () =>
                      AdressNotification(removeAdress: adress, adress: '')
                        ..dispatch(context),
                  child: SvgPicture.asset(AppIcons.iconRemove),
                ),
              ),
            ]),
          )
        : InkWell(
            borderRadius: BorderRadius.circular(12),
            highlightColor: Colors.transparent,
            onTap: () async {
              await inputDialog(context).then((value) {
                if (value != null && value.isNotEmpty) {
                  AdressNotification(adress: value).dispatch(context);
                }
              });
            },
            child: Container(
              height: 72,
              width: 72,
              constraints: const BoxConstraints(maxHeight: 72, maxWidth: 72),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.buttonColor, width: 2),
              ),
              child: Icon(Icons.add, size: 40, color: theme.buttonColor),
            ),
          );
  }

  Future<String?> inputDialog(BuildContext context) async {
    var adress = '';

    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (context) {
        return AlertDialog(
          title: const Text(AppStrings.scrMapNewSightAddImageTitle),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: AppStrings.scrMapNewSightAddImageTitle,
                  ),
                  onChanged: (value) {
                    adress = value;
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(adress);
              },
            ),
          ],
        );
      },
    );
  }
}
