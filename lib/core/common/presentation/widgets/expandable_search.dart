import 'package:flutter/material.dart';

class ExpandableSearch extends StatefulWidget {
  final Function(String?) onChange;
  final String? hint;
  final double? width;
  const ExpandableSearch(
      {super.key, required this.onChange, this.hint, this.width});

  @override
  State<ExpandableSearch> createState() => _ExpandableSearchState();
}

class _ExpandableSearchState extends State<ExpandableSearch> {
  bool showEditText = false;
  @override
  Widget build(BuildContext context) {
    if (showEditText) {
      return SizedBox(
        width: widget.width ?? MediaQuery.of(context).size.width / 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: widget.hint ?? 'Search',
              hintStyle: const TextStyle(fontSize: 13),
              focusColor: const Color(0xFFF0F0F0),
              isDense: true,
              contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 5),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear_outlined,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    showEditText = false;
                    widget.onChange(null);
                  });
                },
              ),
            ),
            onChanged: (value) => widget.onChange(value),
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
          onTap: () {
            setState(() {
              showEditText = true;
            });
          },
          child: const Icon(
            Icons.search,
            size: 24,
          )),
    );
  }
}
