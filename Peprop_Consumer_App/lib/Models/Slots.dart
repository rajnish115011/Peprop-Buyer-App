
class Slots {


   List<dynamic>list=[];
   String date="";
   Slots.fromJson(Map<String, dynamic> json) {
     Map mapValue =json;
     mapValue.forEach((key, value) {

       date=key;
       list=value;

     });

  }

}

