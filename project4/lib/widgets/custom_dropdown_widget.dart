import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:project4/extension/screen_size.dart';
import 'package:project4/log/log.dart';

class CustomhDropDownWidget<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final bool isSearch;
  final ValueChanged<T?>? onChanged;
  final String hint;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? selectedColor;
  final TextEditingController? searchController;
  final String? searchHintText;
  final String Function(T? item)? displayBuilder;

  const CustomhDropDownWidget({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.hint = "Ülke seç",
    this.borderColor = const Color(0xFFE4E4E7),
    this.searchController,
    this.searchHintText = "Ara",
    required this.isSearch,
    this.displayBuilder,
    this.backgroundColor,
    this.selectedColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomhDropDownWidgetState<T> createState() =>
      _CustomhDropDownWidgetState<T>();
}

class _CustomhDropDownWidgetState<T> extends State<CustomhDropDownWidget<T>> {
  late TextEditingController _textEditingController;
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.searchController ?? TextEditingController();
    _selectedValue = widget.selectedValue;
  }

  @override
  void dispose() {
    if (widget.searchController == null) {
      _textEditingController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        barrierColor: Colors.black38,
        customButton: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            border: Border.all(
              color: widget.borderColor ?? const Color(0xFFE4E4E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  (widget.displayBuilder != null && _selectedValue != null)
                      ? widget.displayBuilder!(_selectedValue as T)
                      : _selectedValue?.toString() ?? widget.hint,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_down_outlined),
              ],
            ),
          ),
        ),
        isExpanded: true,
        items:
            widget.items
                .where(
                  (item) => item != null,
                ) // nullable öğeleri filtrelemek için
                .map(
                  (item) => DropdownMenuItem<T>(
                    value: item, // burada non-nullable olduğundan emin olunuyor
                    child: SizedBox(
                      width: context.width,
                      // decoration: BoxDecoration(
                      //   color: widget.backgroundColor ?? Colors.white,
                      //   // border: Border.all(
                      //   //   color: widget.borderColor ?? const Color(0xFFE4E4E7),
                      //   //   width: 2,
                      //   // ),
                      //   // borderRadius: BorderRadius.circular(8),
                      // ),
                      child: Text(
                        widget.displayBuilder != null
                            ? widget.displayBuilder!(item)
                            : item.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                )
                .toList(),
        value: _selectedValue,
        onChanged: (T? value) {
          setState(() {
            _selectedValue = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
          Log.info("changed : $value");
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 200,
        ),
        dropdownStyleData: const DropdownStyleData(maxHeight: 200),
        menuItemStyleData: MenuItemStyleData(
          height: 40,
          selectedMenuItemBuilder: (context, child) {
            return Container(
              width: context.width,
              decoration: BoxDecoration(
                color: widget.selectedColor ?? Colors.purple,
                border: Border.all(
                  color: widget.borderColor ?? const Color(0xFFE4E4E7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            );
          },
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: _textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget:
              widget.isSearch
                  ? Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: widget.searchHintText ?? "Ara",
                        prefixIcon: const Icon(Icons.search),
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                  : const SizedBox(),
          searchMatchFn: (item, searchValue) {
            return widget.displayBuilder != null
                ? widget.displayBuilder!(item.value).contains(searchValue)
                : item.value.toString().contains(searchValue);
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            _textEditingController.clear();
          }
        },
      ),
    );
  }
}
