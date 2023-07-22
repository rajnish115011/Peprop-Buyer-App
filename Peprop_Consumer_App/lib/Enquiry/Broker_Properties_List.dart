import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';
import 'package:peprop_consumer_app/Models/BrokerModelEn.dart';
import 'package:peprop_consumer_app/Requirements/Requirements_Descriptions.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';

import '../Utils/FireBase_Logs.dart';
import '../widgets/Broker_My_Projects.dart';


class Broker_Properties_List extends StatefulWidget {
  late BrokerModelEn brokerModelList;

  Broker_Properties_List(this.brokerModelList, {Key? key}) : super(key: key);

  @override
  _BrokerPropertiesListState createState() => _BrokerPropertiesListState();
}

class _BrokerPropertiesListState extends State<Broker_Properties_List> {
  List<PropertyDetail> propertyDetail = [];
  int index = 0;

  @override
  void initState() {
    propertyDetail = widget.brokerModelList.propertyDetail!;
    create_log();
    super.initState();
  }
  Future<void> create_log() async {
    await FireBase_Logs().log_screen_view("View Developer/Broker Project List", "View Developer/Broker Project List");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.appBar(context, 'Property list'),
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  child: Broker_My_Projects(propertyDetail[index]),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Requirements_Descriptions(propertyDetail[index].iD.toString(),propertyDetail[index].lead_id.toString())));

                  },
                );
              },
              childCount: propertyDetail.length,
            ),
          ),
        ),
      ]),
    );
  }

}