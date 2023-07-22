import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/API/API.dart';
import 'package:peprop_consumer_app/Models/BrokerPropertiesModel.dart';
import 'package:peprop_consumer_app/Utils/AppUtils.dart';
import 'package:peprop_consumer_app/Utils/ServiceConfig.dart';
import 'package:peprop_consumer_app/widgets/My_Enquiry_Projects.dart';
import 'package:peprop_consumer_app/widgets/No_Data_Placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Properties/Properties_Detail.dart';

class MyBrokerProperties extends StatefulWidget {
  const MyBrokerProperties({Key? key}) : super(key: key);

  @override
  _MyBrokerPropertiesState createState() => _MyBrokerPropertiesState();
}

class _MyBrokerPropertiesState extends State<MyBrokerProperties> {

  bool loading = true;
  List<BrokerPropertiesModel> propertyList = [];


  @override
  void initState() {
    _getSuggestedProperties();
    super.initState();
  }

  _getSuggestedProperties() async {
    SharedPreferences prefNew = await SharedPreferences.getInstance();
    String mobile = prefNew.getString('mobile')!;
    String userId = prefNew.getString('user_id')!;

    setState(() {
      loading = true;
    });
    var _map = new Map<String, String>();
    _map['mobile'] = mobile;
    _map['user_id'] = userId;
    FormData data = new FormData.fromMap(_map);
    ServiceConfig().postApiBodyAuthJson(API.getCustomerEnquiryCPbrokerProperty, data, context)
        .then((value) {
      Response response = value;
      print('response properties$response');
      if (response != null && response.statusCode == 200) {
        var status = response.data["status"] as bool;

        if (status) {
          var notify = response.data["data"] as List;
          propertyList = notify
              .map<BrokerPropertiesModel>(
                  (json) => BrokerPropertiesModel.fromJson(json))
              .toList();
          setState(() {
            loading = false;
          });
        } else {
          setState(() {
            loading = false;
          });
        }
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.appBar(context, 'title'),
      body: SafeArea(
        child: Stack(
          children: [
            Stack   (
              children: [
                loading == true
                    ? Center(
                  child: new CircularProgressIndicator(),
                )
                    : propertyList.length > 0
                    ?

                     ListView.builder(
                    shrinkWrap: false,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                     itemCount: propertyList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: My_Enquiry_Projects(propertyList[index],true,null),
                        onTap: () {
                          var response= Navigator.of(context).push(MaterialPageRoute(builder: (context) => Properties_Detail(propertyList[index].iD.toString(),"false")));

                        },
                      );

                    }):Center(
                    child: No_Data_Placeholder("Properties Not Found.")),
              ],
            ),
          ],
        ),
      ),
    );
  }


}