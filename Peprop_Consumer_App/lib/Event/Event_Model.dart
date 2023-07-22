





class Event_Model {


  String id="";
  String event_for="";
  String event_title="";
  String event_type="";
  String event_banner="";
  String event_inside_banner="";
  String event_purpose="";
  String event_auditorium="";
  String event_hall_no="";
  String event_map="";

  String event_tnc="";
  String start_date="";
  String end_date="";
  String created_on="";
  List<Builder_Model>builder_details=[];

  List<Prop_Model>prop_list=[];
  List<Bank_Model>bank_detail=[];

  List<Speakers>event_speaker=[];
  List<Event_Date_Detail>event_date_detail=[];






  Event_Model.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    event_for= json["event_for"].toString();
    event_title= json["event_title"].toString();
    event_type= json["event_type"].toString();
    event_banner= json["event_banner"].toString();
    event_inside_banner= json["event_inside_banner"].toString();
    event_purpose= json["event_purpose"].toString();
    event_auditorium= json["event_auditorium"].toString();
    event_hall_no= json["event_hall_no"].toString();
    event_map= json["event_map"].toString();

    event_tnc= json["event_tnc"].toString();
    start_date= json["start_date"].toString();
    end_date= json["end_date"].toString();
    created_on= json["created_on"].toString();
    if (json['builder_detail'] != null) {json['builder_detail'].forEach((v) {builder_details.add(new Builder_Model.fromJson(v));});}
    if (json['property_detail'] != null) {json['property_detail'].forEach((v) {prop_list.add(new Prop_Model.fromJson(v));});}

    if (json['bank_detail'] != null) {json['bank_detail'].forEach((v) {bank_detail.add(new Bank_Model.fromJson(v));});}
    if (json['event_speaker'] != null) {json['event_speaker'].forEach((v) {event_speaker.add(new Speakers.fromJson(v));});}


    if (json['event_date_detail'] != null) {

      json['event_date_detail'].forEach((v) {event_date_detail.add(new Event_Date_Detail.fromJson(v));});

    }



  }
}




class Speakers {

  String id="";
  String event_id="";
  String first_name="";
  String last_name="";
  String profile_picture="";
  String experience="";
  String current_position="";
  String linkdin="";
  String facebook="";
  String instagram="";
  String twitter="";
  String speaker_description="";


  Speakers.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    event_id= json["event_id"].toString();
    first_name= json["first_name"].toString();
    last_name= json["last_name"].toString();
    profile_picture= json["profile_picture"].toString();
    experience= json["experience"].toString();
    current_position= json["current_position"].toString();
    linkdin= json["linkdin"].toString();
    facebook= json["facebook"].toString();
    instagram= json["instagram"].toString();
    twitter= json["twitter"].toString();
    speaker_description= json["speaker_description"].toString();


  }
}

class Builder_Model {

  String builder_name="";
  String builder_logo="";






  Builder_Model.fromJson(Map<String, dynamic> json) {
    builder_name= json["builder_name"].toString();
    builder_logo= json["builder_logo"].toString();



  }
}
class Prop_Model {

  String property_name="";
  String property_logo="";






  Prop_Model.fromJson(Map<String, dynamic> json) {
    property_name= json["property_name"].toString();
    property_logo= json["property_logo"].toString();



  }
}
class Bank_Model {

  String bank_name="";
  String bank_image="";






  Bank_Model.fromJson(Map<String, dynamic> json) {
    bank_name= json["bank_name"].toString();
    bank_image= json["bank_image"].toString();



  }
}

class Event_Date_Detail {


  String id="";
  String event_id="";
  String event_titles="";
  String event_date="";
  String sessions="";
  String start_time="";
  String end_time="";
  String speaker="";
  String events_type="";


  List<Builder_Model>builder_details=[];

  List<Prop_Model>prop_list=[];
  Event_Date_Detail.fromJson(Map<String, dynamic> json) {
    id= json["id"].toString();
    event_id= json["event_id"].toString();
    event_titles= json["event_titles"].toString();
    event_date= json["event_date"].toString();
    sessions= json["sessions"].toString();
    start_time= json["start_time"].toString();
    end_time= json["end_time"].toString();
    speaker= json["speaker"].toString();
    events_type= json["events_type"].toString();


    if (json['builder_detail'] != null) {json['builder_detail'].forEach((v) {builder_details.add(new Builder_Model.fromJson(v));});}
    if (json['property_detail'] != null) {json['property_detail'].forEach((v) {prop_list.add(new Prop_Model.fromJson(v));});}



  }
}






