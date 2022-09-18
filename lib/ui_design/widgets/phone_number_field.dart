import 'package:authentication/ui_design/const/countries.dart';
import 'package:config/config.dart';
import 'package:flutter/material.dart';

class PhoneNumberField extends StatefulWidget {
  final Function(String text, bool isValid) onChange;

  final String hintText;
  final TextInputType? keyboardType;
  const PhoneNumberField(
      {Key? key,
      required this.onChange,
      this.keyboardType,
      this.hintText = 'Enter you phone number'})
      : super(key: key);

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late TextEditingController controller;
  late Country country;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    country = countries.singleWhere((e) => e.dialCode == '91');
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  GlobalKey<FormFieldState> _globalKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _globalKey,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      validator:
          Validation(RegExpType.mobilenoRegExp, min: country.minLength).set,
      onChanged: (_) => setState(() {
        widget.onChange(
            '+${country.dialCode}${controller.text}',
            controller.text.isNotEmpty
                ? (_globalKey.currentState?.validate() ?? false)
                : false);
      }),
      maxLines: 1,
      style: Theme.of(context).textTheme.subtitle2,
      textAlignVertical: TextAlignVertical.center,
      maxLength: country.maxLength,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          labelText: 'Phone number ${country.flag}',
          hintText: widget.hintText,
          border: const OutlineInputBorder(),
          prefixIcon: InkWell(
            onTap: () async {
              try {
                country = (await showDialog<Country>(
                        context: context,
                        builder: (context) =>
                            const Dialog(child: CountryDialog()))) ??
                    country;
                setState(() {});
              } catch (e) {}
            },
            child: Container(
              width: 56,
              padding: const EdgeInsets.only(right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text('+${country.dialCode}',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                  ),
                  const SizedBox(
                      height: 30,
                      child: VerticalDivider(
                        color: Colors.grey,
                        width: 1,
                      ))
                ],
              ),
            ),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? InkResponse(
                  child: const Icon(Icons.clear),
                  onTap: () => setState(() {
                        controller.clear();
                        widget.onChange('', false);
                      }))
              : null),
    );
  }
}

class CountryDialog extends StatefulWidget {
  const CountryDialog({super.key});

  @override
  State<CountryDialog> createState() => Country_DialogState();
}

class Country_DialogState extends State<CountryDialog> {
  late final TextEditingController searchController;
  late List<Country> displayList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
    displayList = countries;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  // focusNode: focusNode,
                  autofocus: true,
                  controller: searchController,
                  onChanged: (_) => setState(() {
                    displayList = countries
                        .where((e) => e.name
                            .toLowerCase()
                            .startsWith(searchController.text.toLowerCase()))
                        .toList();
                  }),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      // isCollapsed: true,
                      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchController.text.isNotEmpty
                          ? InkResponse(
                              onTap: () => setState(() {
                                displayList = countries;
                                setState(searchController.clear);
                              }),
                              child: const Icon(Icons.close),
                            )
                          : null,
                      hintText: 'Search you country',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(56))),
                ),
              ),
              if (FocusScope.of(context).hasPrimaryFocus) const CloseButton(),
            ],
          ),
          Expanded(
              child: ListView.separated(
            shrinkWrap: true,
            itemCount: displayList.length,
            itemBuilder: (context, i) => ListTile(
              onTap: () => Navigator.pop<Country>(context, displayList[i]),
              leading: Image.asset(
                'assets/flags/${displayList[i].code.toLowerCase()}.png',
                package: 'authentication',
                width: 32,
              ),
              title: Text(displayList[i].name),
              trailing: Text('+${displayList[i].dialCode}'),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ))
        ],
      ),
    );
  }
}
