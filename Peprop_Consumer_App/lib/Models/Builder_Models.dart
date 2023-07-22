class Builder_Models {
  String builder_id="";
  String build_reg_no="";
  String gst_number="";
  String BuilderDescription="";
  String user_id="";
  String fullname="";
  String helpline_number="";
  String comp_name="";
  String dob="";
  String rera_approved="";
  String rera_nums="";
  String comp_address="";
  String builder_address="";
  String comp_contact_num="";
  String comp_contact_person="";
  String comp_contact_person_mobile="";
  String comp_contact_person_email="";
  String reg_company="";
  String logo_name="";
  String builder_banner_name="";
  String mobile="";
  String email="";
  String state_name="";
  String city_name="";
  String loc_name="";



      Builder_Models.fromJson(Map<String, dynamic> json) {
      builder_id= json["builder_id"].toString();
      build_reg_no= json["build_reg_no"].toString();
      BuilderDescription= json["BuilderDescription"].toString().replaceAll("null", "N/A");
      user_id= json["user_id"].toString().replaceAll("null", "N/A");
      fullname= json["fullname"].toString().replaceAll("null", "N/A");
      helpline_number= json["helpline_number"].toString().replaceAll("null", "N/A");
      comp_name= json["comp_name"].toString().replaceAll("null", "N/A");
      dob= json["dob"].toString().replaceAll("null", "N/A");
      rera_approved= json["rera_approved"].toString().replaceAll("null", "N/A");
      rera_nums= json["rera_nums"].toString().replaceAll("null", "N/A");
      comp_address= json["comp_address"].toString().replaceAll("null", "N/A");
      builder_address= json["builder_address"].toString().replaceAll("null", "N/A");
      comp_contact_num= json["comp_contact_num"].toString().replaceAll("null", "N/A");
      comp_contact_person= json["comp_contact_person"].toString().replaceAll("null", "N/A");
      comp_contact_person_mobile= json["comp_contact_person_mobile"].toString().replaceAll("null", "N/A");
      comp_contact_person_email= json["comp_contact_person_email"].toString().replaceAll("null", "N/A");
      reg_company= json["reg_company"].toString().replaceAll("null", "N/A");
      logo_name= json["logo_name"].toString().replaceAll("null", "N/A");
      builder_banner_name= json["builder_banner_name"].toString().replaceAll("null", "N/A");
      mobile= json["mobile"].toString().replaceAll("null", "N/A");
      email= json["email"].toString().replaceAll("null", "N/A");
      state_name= json["state_name"].toString().replaceAll("null", "N/A");
      city_name= json["city_name"].toString().replaceAll("null", "N/A");
      loc_name= json["loc_name"].toString().replaceAll("null", "N/A");


      }

}