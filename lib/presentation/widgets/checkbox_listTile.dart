import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;

  const CustomCheckboxListTile({
    Key? key,
    required this.isChecked,
    required this.onChanged,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
          ),
          leading,
        ],
      ),
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      contentPadding: EdgeInsets.all(8.0),
    );
  }
}
