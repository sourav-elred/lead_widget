import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lead_widget/viewModel/location_view_model.dart';
import 'package:lead_widget/widgets/elred_button.dart';
import 'package:provider/provider.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  late final LocationViewModel _locationViewModel;

  @override
  void initState() {
    super.initState();
    _locationViewModel = context.read<LocationViewModel>();
    _locationViewModel.initialize(TextEditingController());
  }

  @override
  void dispose() {
    _locationViewModel.editingController.dispose();
    _locationViewModel.placesList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            if ((_locationViewModel.currentGoogleLocation == null &&
                    _locationViewModel.editingController.text.isNotEmpty) &&
                _locationViewModel.suggestionSelected) {
              _buildConfirmationPopup(context);
              return;
            }
            if (_locationViewModel.initialGoogleLocation.isNotEmpty &&
                _locationViewModel.editingController.text.isEmpty) {
              _buildConfirmationPopup(context);
              return;
            } else {
              Navigator.of(context).pop();
            }
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.grey, height: .2),
        ),
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: const Text(
          'Add Location',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Consumer<LocationViewModel>(builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: _locationViewModel.editingController,
                onChanged: (value) {
                  _locationViewModel.getPlacesSuggestions();
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      color: const Color(0XFF898A8D),
                    ),
                  ),
                  suffixIcon: value.editingController.value.text.isNotEmpty
                      ? InkWell(
                          onTap: value.onClearIconTapInAddLocation,
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
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
                    borderSide:
                        const BorderSide(color: Color(0XFFEAECF2), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide:
                        const BorderSide(color: Color(0XFFEAECF2), width: 1),
                  ),
                  hintText: 'Add Location',
                ),
              ),
            );
          }),
          Consumer<LocationViewModel>(
            builder: (context, value, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: value.placesList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      value.onLocationSuggestionTap(
                          value.placesList[index]["description"]);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: ListTile(
                      title: Text(
                        value.placesList[index]["description"],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // const Spacer(),
          Consumer<LocationViewModel>(builder: (context, value, child) {
            return ElRedButton(
              text: 'Done',
              onTap: value.isButtonDisabled
                  ? null
                  : () {
                      if (value.initialGoogleLocation.isEmpty &&
                          value.editingController.text.isEmpty) {
                        Navigator.of(context).pop();
                        return;
                      } else {
                        value.changeCurrentGoogleLocation();
                        Navigator.of(context).pop();
                      }
                    },
            );
          }),
        ],
      ),
    );
  }

  Future<dynamic> _buildConfirmationPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  // SizedBox(height: 12),
                  Container(
                    width: 115,
                    height: 6,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFCFCFCF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Changes Not Saved. Are you sure you want to go back?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF101010),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElRedButton(
                            text: 'Cancel',
                            invert: true,
                            onTap: Navigator.of(context).pop,
                          ),
                        ),
                        Expanded(
                          child: ElRedButton(
                            text: 'Ok',
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
