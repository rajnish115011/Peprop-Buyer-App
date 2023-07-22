

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../Color/ColorFile.dart';
import '../Models/Tower_Model.dart';
import 'ListThemeData.dart';




void Tower_Piker(List<Tower_Model> country_list,  {
  required BuildContext context,
  required ValueChanged<Tower_Model> onSelect,
  VoidCallback? onClosed,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode = false,
  ListThemeData? countryListTheme,
  // InputDecoration? inputDecoration
}) {
  assert(exclude == null || countryFilter == null,
  'Cannot provide both exclude and countryFilter');
  showListBottomSheet(
    country_list:country_list,
    context: context,
    onSelect: onSelect,
    onClosed: onClosed,
    exclude: exclude,
    countryFilter: countryFilter,
    showPhoneCode: showPhoneCode,
    countryListTheme: countryListTheme,
  );
}

void showListBottomSheet({
  required List<Tower_Model> country_list,
  required BuildContext context,
  required ValueChanged<Tower_Model> onSelect,
  VoidCallback? onClosed,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode = false,
  ListThemeData? countryListTheme,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _builder(
      country_list,
      context,
      onSelect,
      exclude,
      countryFilter,
      showPhoneCode,
      countryListTheme,
    ),
  ).whenComplete(() {
    if (onClosed != null) onClosed();
  });
}

Widget _builder(
    List<Tower_Model> country_list,
    BuildContext context,
    ValueChanged<Tower_Model> onSelect,
    List<String>? exclude,
    List<String>? countryFilter,
    bool showPhoneCode,
    ListThemeData? countryListTheme,
    ) {
  final device = MediaQuery.of(context).size.height;
  final statusBarHeight = MediaQuery.of(context).padding.top;
  final height = device - (statusBarHeight + (kToolbarHeight / 1.5));

  Color? _backgroundColor = countryListTheme?.backgroundColor ??
      Theme.of(context).bottomSheetTheme.backgroundColor;
  if (_backgroundColor == null) {
    if (Theme.of(context).brightness == Brightness.light) {
      _backgroundColor = Colors.white;
    } else {
      _backgroundColor = Colors.black;
    }
  }

  final BorderRadius _borderRadius = countryListTheme?.borderRadius ??
      const BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      );

  return Container(
    height: height,
    decoration: BoxDecoration(
      color: _backgroundColor,
      borderRadius: _borderRadius,
    ),
    child: ListViews(
      country_list:country_list,
      onSelect: onSelect,
      exclude: exclude,
      countryFilter: countryFilter,
      showPhoneCode: showPhoneCode,
      countryListTheme: countryListTheme,
    ),
  );
}
class ListViews extends StatefulWidget {
  /// Called when a country is select.
  ///
  /// The country picker passes the new value to the callback.
  final ValueChanged<Tower_Model> onSelect;
  final List<Tower_Model> country_list;

  /// An optional [showPhoneCode] argument can be used to show phone code.
  final bool showPhoneCode;

  /// An optional [exclude] argument can be used to exclude(remove) one ore more
  /// country from the countries list. It takes a list of country code(iso2).
  /// Note: Can't provide both [exclude] and [countryFilter]
  final List<String>? exclude;

  /// An optional [countryFilter] argument can be used to filter the
  /// list of countries. It takes a list of country code(iso2).
  /// Note: Can't provide both [countryFilter] and [exclude]
  final List<String>? countryFilter;

  /// An optional argument for customizing the
  /// country list bottom sheet.
  final ListThemeData? countryListTheme;

  const ListViews({
    Key? key,
    required this.country_list,

    required this.onSelect,
    this.exclude,
    this.countryFilter,
    this.showPhoneCode = false,
    this.countryListTheme,
  })  : assert(exclude == null || countryFilter == null,
  'Cannot provide both exclude and countryFilter'),
        super(key: key);

  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<ListViews> {
  late List<Tower_Model> _countryList=[];
  late List<Tower_Model> _filteredList=[];
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _countryList.addAll(widget.country_list);

    //Remove duplicates country if not use phone code



    if (widget.countryFilter != null) {
      _countryList.removeWhere(
              (element) => !widget.countryFilter!.contains(element.tower_name));
    }

    _filteredList = <Tower_Model>[];
    _filteredList.addAll(_countryList);
  }

  @override
  Widget build(BuildContext context) {
    final String searchLabel =
        CountryLocalizations.of(context)?.countryName(countryCode: 'search') ??
            'Search';

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:  Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child:  Container(
              width: 40,
              height: 40,
              decoration:  BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(100)),
                color: ColorFile.red_700,

              ),
              child:  Icon(Icons.close,color: ColorFile.white,) ,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: TextField(
            controller: _searchController,
            decoration: widget.countryListTheme?.inputDecoration ??
                InputDecoration(
                  labelText: searchLabel,
                  hintText: searchLabel,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
            onChanged: _filterSearchResults,
          ),
        ),
        _filteredList.length>0? Expanded(
          child: ListView(

            children: _filteredList
                .map<Widget>((country) => _listRow(country))
                .toList(),
          ),
        ):Container(height:MediaQuery.of(context).size.height-200,child: Center(child: new Text("No Data Found"),),),
      ],
    );
  }

  Widget _listRow(Tower_Model country) {
    final TextStyle _textStyle =
        widget.countryListTheme?.textStyle ?? _defaultTextStyle;

    return Material(
      // Add Material Widget with transparent color
      // so the ripple effect of InkWell will show on tap
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onSelect(country);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  country.tower_name+"\n",
                  style: _textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _filterSearchResults(String query) {
    List<Tower_Model> _searchResult = <Tower_Model>[];
    final CountryLocalizations? localizations =
    CountryLocalizations.of(context);

    if (query.isEmpty) {
      _searchResult.addAll(_countryList);
    } else {
      _searchResult = _countryList
          .where((c) => c.tower_name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }

    setState(() => _filteredList = _searchResult);
  }

  get _defaultTextStyle => const TextStyle(fontSize: 16);
}
