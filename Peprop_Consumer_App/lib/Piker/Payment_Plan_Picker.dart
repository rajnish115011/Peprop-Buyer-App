

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/wish_list/Styles.dart';

import '../Color/ColorFile.dart';
import '../Models/Tower_Model.dart';
import '../Terms_and_Conditions/Payment_Plan_Refund.dart';
import 'ListThemeData.dart';




void Payment_Plan_Picker(List<Payments_Plans> country_list,  {
  required BuildContext context,
  required ValueChanged<Payments_Plans> onSelect,
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
  required List<Payments_Plans> country_list,
  required BuildContext context,
  required ValueChanged<Payments_Plans> onSelect,
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
    List<Payments_Plans> country_list,
    BuildContext context,
    ValueChanged<Payments_Plans> onSelect,
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
  final ValueChanged<Payments_Plans> onSelect;
  final List<Payments_Plans> country_list;

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
  late List<Payments_Plans> _countryList=[];
  late List<Payments_Plans> _filteredList=[];
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _countryList.addAll(widget.country_list);

    //Remove duplicates country if not use phone code



    if (widget.countryFilter != null) {
      _countryList.removeWhere(
              (element) => !widget.countryFilter!.contains(element.plan_name));
    }

    _filteredList = <Payments_Plans>[];
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

  Widget _listRow(Payments_Plans country) {
    final TextStyle _textStyle =
        widget.countryListTheme?.textStyle ?? _defaultTextStyle;

    return Material(
      // Add Material Widget with transparent color
      // so the ripple effect of InkWell will show on tap
      color: Colors.transparent,
      child:


      new Column(
        children: [
          InkWell(

            onTap: () {
              widget.onSelect(country);
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: new Column(
                  children: [
                    new Container(child: Row(
                      children: <Widget>[
                        const SizedBox(width: 20),
                        if(country.scheme==null)Expanded(
                          child: Text(
                            country.plan_name+"\n",
                            style: Styles().styles_medium(17, Colors.black),
                          ),
                        )
                      ],
                    ),),
                    if(country.scheme!=null)new Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),border: new Border.all(width: 1,color: ColorFile.lightgray)),
                      child: new Column(
                        children: [
                          new Container(
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.bgs),

                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    country.plan_name.toString(),
                                    style: Styles().styles_bold(14, ColorFile.black),
                                  ),
                                )
                              ],
                            ),),
                          new Container(
                            color: ColorFile.light_bc,
                            height: 1,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                              ],
                            ),),
                          if(country.scheme!.scheme_notes.toString()!="null")new Column(
                            children: [
                              new Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(width: 20),
                                    Expanded(

                                      child: new Container(
                                        child: Text(
                                          country.scheme!.scheme_notes.toString(),
                                          style: Styles().styles_regular(14, ColorFile.black),
                                        ),),
                                    ),



                                  ],
                                ),),

                              new Container(
                                color: ColorFile.light_bc,
                                height: 1,

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

                                  ],
                                ),),




                            ],
                          ),


                          new Container(
                            height: 40,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 3,
                                  child: new Container(
                                    child: Text(
                                      "Peprop.Money Points",
                                      style: Styles().styles_regular(14, ColorFile.black),
                                    ),),
                                ),
                                new Container(height: 40,width: 1,color: Colors.black,),


                                Expanded(
                                  flex: 1,
                                  child: new Container(
                                    padding: EdgeInsets.only(right: 10),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      country.scheme!.scheme_loyalty_points.toString(),
                                      style: Styles().styles_medium(12, ColorFile.black),
                                    ),),
                                ),


                              ],
                            ),),

                          new Container(
                            color: ColorFile.light_bc,
                            height: 1,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                              ],
                            ),),



                          if(country.scheme!.scheme_is_cashback.toString()=="1")new Column(
                            children: [
                              new Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(width: 20),
                                    Expanded(
                                      flex: 3,
                                      child: new Container(
                                        child: Text(
                                          "Cashback",
                                          style: Styles().styles_regular(14, ColorFile.black),
                                        ),),
                                    ),
                                    new Container(height: 40,width: 1,color: Colors.black,),
                                    Expanded(
                                      flex: 1,
                                      child: new Container(
                                        padding: EdgeInsets.only(right: 10),
                                        alignment: Alignment.centerRight,
                                        child: Text(country.scheme!.scheme_cashback_type.toString()=="0"?country.scheme!.scheme_cashback_value.toString()+"%":("₹"+country.scheme!.scheme_cashback_value.toString()),
                                          style: Styles().styles_medium(12, ColorFile.black),
                                        ),),
                                    ),


                                  ],
                                ),),

                              new Container(
                                color: ColorFile.light_bc,
                                height: 1,

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

                                  ],
                                ),),




                            ],
                          ),

                          if(country.scheme!.scheme_rewards_categories.length>0) ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: country.scheme!.scheme_rewards_categories.length,
                            itemBuilder: (context, i){
                              return new Column(
                                children: [
                                  new Container(
                                    height: 40,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(width: 20),
                                        Expanded(
                                          flex: 3,
                                          child: new Container(
                                            child: Text(
                                              country.scheme!.scheme_rewards_categories[i].name.toString(),
                                              style: Styles().styles_regular(14, ColorFile.black),
                                            ),),
                                        ),
                                        new Container(height: 40,width: 1,color: Colors.black,),


                                        Expanded(
                                          flex: 1,
                                          child: new Container(
                                            padding: EdgeInsets.only(right: 10),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "₹"+country.scheme!.scheme_rewards_categories[i].amount.toString(),
                                              style: Styles().styles_medium(12, ColorFile.black),
                                            ),),
                                        ),


                                      ],
                                    ),),

                                  new Container(
                                    color: ColorFile.light_bc,
                                    height: 1,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[

                                      ],
                                    ),),
                                ],
                              );
                            },
                          ),

                          new Container(
                            decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(5),color: ColorFile.bgs),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Total Cashback",
                                    style: Styles().styles_bold(14, ColorFile.black),
                                  ),
                                ),
                                new Container(height: 40,width: 1,color: Colors.black,),


                                Expanded(
                                  flex: 1,
                                  child: new Container(
                                    padding: EdgeInsets.only(right: 10),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "₹"+country.scheme!.scheme_rewards_total_value.toString(),
                                      style: Styles().styles_medium(12, ColorFile.black),
                                    ),),
                                ),


                              ],
                            ),),

                        ],
                      ),),











                  ],
                )


            ),
          ),
         if(country.term_condition.length>0) InkWell(child: new Container(
            margin: EdgeInsets.only(top: 20,bottom: 20,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Text("Read More",style: Styles().styles_bold(15, ColorFile.app_color),),

              ],
            ),),onTap: () async {
            var nav=await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Payment_Plan_Refund(true,country.term_condition)));


          },)

        ],
      ),
    );
  }

  void _filterSearchResults(String query) {
    List<Payments_Plans> _searchResult = <Payments_Plans>[];
    final CountryLocalizations? localizations =
    CountryLocalizations.of(context);

    if (query.isEmpty) {
      _searchResult.addAll(_countryList);
    } else {
      _searchResult = _countryList
          .where((c) => c.plan_name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }

    setState(() => _filteredList = _searchResult);
  }

  get _defaultTextStyle => const TextStyle(fontSize: 16);
}
