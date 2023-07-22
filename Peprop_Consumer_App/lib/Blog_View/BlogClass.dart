import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peprop_consumer_app/Color/ColorFile.dart';

import '../API/API.dart';
import '../Models/BlogModel/BlogModel.dart';
import '../Utils/AppUtils.dart';
import '../Utils/ServiceConfig.dart';
import 'package:collection/collection.dart';

import 'my_webview.dart';

class BlogClass extends StatefulWidget {
  const BlogClass({Key? key}) : super(key: key);

  @override
  _BlogClassState createState() => _BlogClassState();
}

class _BlogClassState extends State<BlogClass> {
  bool _blogLoading = false;
  List<BlogModel> _blogModel = [];
  List<AuthorModel> _getAuthor = [];
  List<BImageModel> _getBImage = [];

  _getBlogs() {
    setState(() {
      _blogLoading = true;
    });
    ServiceConfig().postApiBodyAuthJson(API.blogAPI,new Map(),context).then((value) {
      Response response = value;
      print('response message blog $response');
      if (response != null && response.statusCode == 200) {
        var data = response.data;
        _blogModel =
            data.map<BlogModel>((json) => BlogModel.fromJson(json)).toList();
        //print("This is the blog model $_blogModel");
        setState(() {
          _blogLoading = false;
        });
      } else {
        setState(() {
          _blogLoading = false;
        });
      }
    });
  }

  _getBlogAuthor() {
    setState(() {
      _blogLoading = true;
    });
    ServiceConfig().postApiBodyAuthJson(API.blogAuthor,new Map(),context).then((value) {
      Response response = value;
      print('response message blog $response');
      if (response != null && response.statusCode == 200) {
        var data = response.data;
        _getAuthor = data
            .map<AuthorModel>((json) => AuthorModel.fromJson(json))
            .toList();
        print("This is the blog model $_getAuthor");
        setState(() {
          _blogLoading = false;
        });
      } else {
        setState(() {
          _blogLoading = false;
        });
      }
    });
  }
  _getBlogImage() {
    setState(() {
      _blogLoading = true;
    });
    ServiceConfig().postApiBodyAuthJson(API.blogMedia,new Map(),context).then((value) {
      Response response = value;
      print('response message blog image $response');
      if (response != null && response.statusCode == 200) {
        var data = response.data;
        _getBImage = data
            .map<BImageModel>((json) => BImageModel.fromJson(json))
            .toList();
        //print("This is the blog model $_getBlogImage");
        setState(() {
          _blogLoading = false;
        });
      } else {
        setState(() {
          _blogLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getBlogs();
    _getBlogImage();
    _getBlogAuthor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.appBar(context, 'title'),
      body: Container(
        child: (_blogLoading)
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _blogModel.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final authorDet = _getAuthor.firstWhereOrNull((element) =>
                element.id == _blogModel[index].authorID);
                final bimageDet = _getBImage.firstWhereOrNull(
                        (element) => element.id == _blogModel[index].id);
                String dateTime = _blogModel[index].date.toString();
                String newDateTime = dateTime.split("T0").first;

                String dataNew = AppUtils().convert_date3(newDateTime);
                //print("data here $authorDet");
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                          selectedUrl:
                          _blogModel[index].link!.toString(),
                        )));

                    // launch(_blogModel[index].link!.toString());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              bimageDet == null
                                  ?Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn.britannica.com/37/189837-050-F0AF383E/New-Delhi-India-War-Memorial-arch-Sir.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4))),
                              ):
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${bimageDet.imageLink!}"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    _blogModel[index]
                                        .title!
                                        .rendered
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'semi',
                                      color: Colors.grey[850],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 12, left: 12, top: 8),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dataNew,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'regular',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                authorDet == null
                                    ? Text(
                                  'DASV Tech',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'regular',
                                    color: ColorFile.app_color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                    : Text(
                                  "${authorDet.name!}",
                                  //'by ABDC THNMKO',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'regular',
                                    color: ColorFile.app_color,
                                    fontWeight: FontWeight.bold,
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
            ),
          ),
        ),
      ),
    );
  }
}
