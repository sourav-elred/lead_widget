import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/assets_constants.dart';
import '../../viewModel/location_view_model.dart';
import 'package:provider/provider.dart';

class AddLocationTextField extends StatelessWidget {
  const AddLocationTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationViewModel>(builder: (context, value, child) {
      return Container(
        margin: const EdgeInsets.all(20),
        height: 45,
        child: TextField(
          controller: value.editingController,
          onChanged: (val) {
            value.getPlacesSuggestions();
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
          ], //
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                AssetsConstants.searchIcon,
                color: const Color(0XFF898A8D),
              ),
            ),
            suffixIcon: value.editingController.value.text.isNotEmpty
                ? InkWell(
                    onTap: value.onClearIconTapInAddLocation,
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: const BorderSide(
                color: Color(0XFFEAECF2),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: const BorderSide(color: Color(0XFFEAECF2), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: const BorderSide(color: Color(0XFFEAECF2), width: 1),
            ),
            hintText: 'Add Location',
          ),
        ),
      );
    });
  }
}
