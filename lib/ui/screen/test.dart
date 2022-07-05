import 'package:flutter/material.dart';

void main() => runApp(const AutocompleteExampleApp());

class AutocompleteExampleApp extends StatelessWidget {
  const AutocompleteExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RawAutocomplete Form'),
        ),
        body: const Center(
          child: AutocompleteFormExample(),
        ),
      ),
    );
  }
}

class AutocompleteFormExample extends StatefulWidget {
  const AutocompleteFormExample({Key? key}) : super(key: key);

  @override
  AutocompleteFormExampleState createState() => AutocompleteFormExampleState();
}

class AutocompleteFormExampleState extends State<AutocompleteFormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  String? _dropdownValue;
  String? _autocompleteSelection;

  // ignore: member-ordering-extended
  static const List<String> _options = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: _dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            hint: const Text('This is a regular DropdownButtonFormField'),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (newValue) {
              setState(() {
                _dropdownValue = newValue;
              });
            },
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return 'Must make a selection.';
              }

              return null;
            },
          ),
          TextFormField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'This is a regular TextFormField',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Can't be empty.";
              }

              return null;
            },
          ),
          RawAutocomplete<String>(
            optionsBuilder: (textEditingValue) {
              return _options.where((option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (selection) {
              setState(() {
                _autocompleteSelection = selection;
              });
            },
            fieldViewBuilder: (
              context,
              textEditingController,
              focusNode,
              onFieldSubmitted,
            ) {
              return TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: 'This is a RawAutocomplete!',
                ),
                focusNode: focusNode,
                onFieldSubmitted: (value) {
                  onFieldSubmitted();
                },
                validator: (value) {
                  if (!_options.contains(value)) {
                    return 'Nothing selected.';
                  }

                  return null;
                },
              );
            },
            optionsViewBuilder: (
              context,
              onSelected,
              options,
            ) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);

                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: ListTile(
                            title: Text(option),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (!_formKey.currentState!.validate()) {
                return;
              }
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Successfully submitted'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('DropdownButtonFormField: "$_dropdownValue"'),
                          Text(
                            'TextFormField: "${_textEditingController.text}"',
                          ),
                          Text('RawAutocomplete: "$_autocompleteSelection"'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
