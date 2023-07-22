import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Kyc/Aadhar_Verification.dart';
import 'package:peprop_consumer_app/Kyc/Pan_Verification.dart';
import 'package:shimmer/shimmer.dart';

import '../Color/ColorFile.dart';
import '../Utils/AppUtils.dart';

class Banking_Steps extends StatefulWidget {
  const Banking_Steps({Key? key}) : super(key: key);

  @override
  _BankingDashboardNewState createState() => _BankingDashboardNewState();
}

class _BankingDashboardNewState extends State<Banking_Steps> {

  bool isLogin =false;
  String client_id="";
  String a_no="";


  String adhar_no="";



  @override
  void initState() {
    super.initState();

  }


  bool get_prop=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _widgetBottomBar(),
      appBar: AppUtils.appBar(context, 'title'),
      body: new Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Open Your Account',
                        style: TextStyle(
                            color:ColorFile.app_color,
                            fontSize: 16,
                            fontFamily: 'semi'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'For Free',
                        style: TextStyle(
                            color:ColorFile.app_color,
                            fontSize: 16,
                            fontFamily: 'semi'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        width: 100,
                        child: Divider(
                          thickness: 2,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        '100% Free and Secure',
                        style: TextStyle(fontSize: 14, fontFamily: 'bold'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          height: 250, child: Image.asset('assets/banking_icons/bframe.png')),
                    ],
                  ),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/banking_icons/bectangle.png'),
                        fit: BoxFit.cover,
                      )),
                ),

                new Container(
                  height: 90,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Text("Powered by ",style: new TextStyle(fontFamily: "medium",fontSize: 13),),
                      Image.asset("assets/dashboard/powerdbyicici.png",height: 90,width: 90,)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ///==============DIGITAL BANKING EASY============================================>
                const Text(
                  'Digital Banking Is',
                  style: TextStyle(
                      color:ColorFile.app_color, fontSize: 16, fontFamily: 'semi'),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'So Easy!',
                  style: TextStyle(
                      color:ColorFile.app_color, fontSize: 16, fontFamily: 'semi'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: 100,
                  child: Divider(
                    thickness: 2,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'CREATE ACCOUNT',
                  style: TextStyle(fontSize: 14, fontFamily: 'bold'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'IN 3 SIMPLE STEPS!',
                  style: TextStyle(fontSize: 14, fontFamily: 'bold'),
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/banking_icons/bs1.png',
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          "Step - 1",
                          style: TextStyle(
                            color: Colors.orange,
                            fontFamily: 'semi',
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Aadhaar',
                          style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Verification',
                          style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Enter your Aadhaar No.',
                          style: TextStyle(fontSize: 12, fontFamily: 'regular'),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'And Verify',
                          style: TextStyle(fontSize: 12, fontFamily: 'regular'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Step - 2",
                          style: TextStyle(
                            color: Colors.orange,
                            fontFamily: 'semi',
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'PAN',
                          style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Verification',
                          style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Enter your PAN',
                          style: TextStyle(fontSize: 12, fontFamily: 'regular'),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'And Verify',
                          style: TextStyle(fontSize: 12, fontFamily: 'regular'),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/banking_icons/bs2.png',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/banking_icons/bs3.png',
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          "Step - 3",
                          style: TextStyle(
                            color: Colors.orange,
                            fontFamily: 'semi',
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Review &',
                          style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Validation',
                          style: TextStyle(fontSize: 16, fontFamily: 'bold'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'After Successful',
                          style: TextStyle(fontSize: 12, fontFamily: 'regular'),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Review, Account No.',
                          style: TextStyle(fontSize: 12, fontFamily: 'regular'),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Will Be Generated',
                          style: TextStyle(fontSize: 12, fontFamily: 'regular'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),

                ///=======================BENEFITS============================================>
                const Text(
                  'Benefits',
                  style: TextStyle(
                      color:ColorFile.app_color, fontSize: 15, fontFamily: 'semi'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: 100,
                  child: Divider(
                    thickness: 2,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'EASY, SAFE & SECURE',
                  style: TextStyle(fontSize: 14, fontFamily: 'bold'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset("assets/banking_icons/ess.png"),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset("assets/banking_icons/finger.png"),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      '0 Balance Account Forever',
                      style: TextStyle(fontSize: 14, fontFamily: 'regular'),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset("assets/banking_icons/finger.png"),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Easy Personal Loan',
                      style: TextStyle(fontSize: 14, fontFamily: 'regular'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset("assets/banking_icons/finger.png"),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Unlimited Cashbacks',
                      style: TextStyle(fontSize: 14, fontFamily: 'regular'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
          if(get_prop==true)Center(child: new CircularProgressIndicator(),)
        ],
      ),
    );
  }

  Widget _widgetBottomBar() {
    return
      Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      height: 80,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                var res=await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pan_Verification()));
                Navigator.pop(context);

              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.orangeAccent),
                child: Shimmer.fromColors(
                  period: const Duration(milliseconds: 1500),
                  baseColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  child: const Text(
                    "OPEN ACCOUNT NOW",style: TextStyle(fontFamily: "bold", fontSize: 14, color: ColorFile.white,),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
