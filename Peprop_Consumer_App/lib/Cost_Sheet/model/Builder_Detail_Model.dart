

class Builder_Detail_Model{
  String? user_pan;
  String? fullname;
  String? proj_name;
  String? Rera;
  String? comp_address;
  String? builder_address;
  String? Address;
  String? email;
  String? builder_id;


  Builder_Detail_Model({this.user_pan,this.fullname,this.proj_name,this.Rera,this.comp_address,this.builder_address, this.Address, this.email,this.builder_id});
  Builder_Detail_Model.fromJson(Map<String, dynamic> json) {
    user_pan = json['user_pan'].toString().replaceAll("null", "");
    fullname = json['fullname'].toString().replaceAll("null", "");
    proj_name = json['proj_name'].toString().replaceAll("null", "");
    Rera = json['Rera'].toString().replaceAll("null", "");
    comp_address = json['comp_address'].toString().replaceAll("null", "");
    builder_address = json['builder_address'].toString().replaceAll("null", "");
    Address = json['Address'].toString().replaceAll("null", "");
    email = json['email'].toString().replaceAll("null", "");
    builder_id = json['builder_id'].toString().replaceAll("null", "");



  }}


class Customer_details{
  String? first_name;
  String? last_name;
  String? email;
  String? mobile;
  String? SourceName;
  String? address_1;

  Customer_details({this.first_name,this.last_name,this.email});
  Customer_details.fromJson(Map<String, dynamic> json) {
    first_name = json['first_name'].toString().replaceAll("null", "");
    last_name = json['last_name'].toString().replaceAll("null", "");
    email = json['email'].toString().replaceAll("null", "");
    mobile = json['mobile'].toString().replaceAll("null", "");
    SourceName = json['SourceName'].toString().replaceAll("null", "");
    address_1 = json['address_1'].toString().replaceAll("null", "");




  }}


class SectionBanner{
  String? my_coupons_section;
  String? my_giftcards_section;

  SectionBanner({this.my_coupons_section,this.my_giftcards_section});
  SectionBanner.fromJson(Map<String, dynamic> json) {
    my_coupons_section = json['my_coupons_section'].toString().replaceAll("null", "");
    my_giftcards_section = json['my_giftcards_section'].toString().replaceAll("null", "");




  }}

class Contact_details{
  String? cc;
  String? mobile;
  String? addresss;
  String? email;
  String? day;
  String? time;
  String? banner;
  String? company_address;



    Contact_details.fromJson(Map<String, dynamic> json) {
    cc = json['cc'].toString().replaceAll("null", "");
    mobile = json['mobile'].toString().replaceAll("null", "");
    addresss = json['addresss'].toString().replaceAll("null", "");
    email = json['email'].toString().replaceAll("null", "");
    day = json['day'].toString().replaceAll("null", "");
    time = json['time'].toString().replaceAll("null", "");
    banner = json['banner'].toString().replaceAll("null", "");
    company_address = json['company_address'].toString().replaceAll("null", "");




  }}

class Inventory_details_With_Price{
  String? property_name;
  String? tower_id;
  String? floor_id;
  String? unit_no;
  String? super_area;
  String? carpet_area;

  String? common_area;
  String? build_up_area;

  String? UnitName;

  String? furnishing_amount;
  String? price;
  String? net_amount;
  String? discount_amount;
  String? electric_charge;
  String? power_backup_charge;
  String? costsheet_status;
  String? lead_inventory_id;
  String? lead_id;
  String? payment_plan_id;


  Inventory_details_With_Price({this.property_name,this.tower_id,this.floor_id,this.unit_no,this.super_area,this.carpet_area,this.UnitName,this.common_area,this.build_up_area,this.furnishing_amount,
  this.price,this.net_amount,this.discount_amount,this.electric_charge,this.power_backup_charge,this.costsheet_status,this.lead_inventory_id,this.lead_id,this.payment_plan_id});

  Inventory_details_With_Price.fromJson(Map<String, dynamic> json) {
    property_name = json['property_name'].toString().replaceAll("null", "");
    tower_id = json['tower_id'].toString().replaceAll("null", "");
    floor_id = json['floor_id'].toString().replaceAll("null", "");
    unit_no = json['unit_no'].toString().replaceAll("null", "");
    super_area = json["unit_id"]!=null?json["unit_id"]['super_area'].toString().replaceAll("null", ""):"";
    carpet_area = json["unit_id"]!=null?json["unit_id"]['carpet_area'].toString().replaceAll("null", ""):"";
    UnitName = json["unit_id"]!=null?json["unit_id"]['UnitName'].toString().replaceAll("null", ""):"";
    common_area = json["unit_id"]!=null?json["unit_id"]['common_area'].toString().replaceAll("null", ""):"";
    build_up_area = json["unit_id"]!=null?json["unit_id"]['build_up_area'].toString().replaceAll("null", ""):"";
    furnishing_amount = json['furnishing_amount'].toString().replaceAll("null", "");
    price = json['price'].toString().replaceAll("null", "");
    net_amount = json['net_amount'].toString().replaceAll("null", "");
    discount_amount = json['discount_amount'].toString().replaceAll("null", "");
    electric_charge = json['electric_charge'].toString().replaceAll("null", "");
    power_backup_charge = json['power_backup_charge'].toString().replaceAll("null", "");
    costsheet_status = json['costsheet_status'].toString().replaceAll("null", "");
    lead_inventory_id = json['lead_inventory_id'].toString().replaceAll("null", "");
    lead_id = json['lead_id'].toString().replaceAll("null", "");
    payment_plan_id = json['payment_plan_id'].toString().replaceAll("null", "");


  }}



class ChannelPartnerDetail{
  String? CompanyName;
  String? FullName;
  String? rera_number;
  String? email;
  String? mobile_cc;
  String? mobile;



  ChannelPartnerDetail({this.CompanyName,this.FullName,this.rera_number,this.email,this.mobile_cc,this.mobile});
  ChannelPartnerDetail.fromJson(Map<String, dynamic> json) {
    CompanyName = json['CompanyName'].toString().replaceAll("null", "");
    FullName = json['FullName'].toString().replaceAll("null", "");
    rera_number = json['rera_number'].toString().replaceAll("null", "");
    email = json['email'].toString().replaceAll("null", "");
    mobile_cc = json["mobile_cc"].toString().replaceAll("null", "");
    mobile = json["mobile"].toString().replaceAll("null", "");


  }

}
class Cost_Prop{
  String? ID;
  String? PropertyName;
  String? Address;
  String? FeaturedImage;
  String? fullname;




  Cost_Prop({this.ID,this.PropertyName,this.Address,this.FeaturedImage,this.fullname});
  Cost_Prop.fromJson(Map<String, dynamic> json) {
    ID = json['ID'].toString().replaceAll("null", "");
    PropertyName = json['PropertyName'].toString().replaceAll("null", "");
    Address = json['Address'].toString().replaceAll("null", "");
    FeaturedImage = json['FeaturedImage'].toString().replaceAll("null", "");
    fullname = json["fullname"].toString().replaceAll("null", "");


  }}



class MileStone{
  String MileStoneName="";
  String BSP="";
  String BasicInstallment="";
  String GSTAmount="";
  String TotalAmount="";
  String BBA="";
  String paid_status="";
  String id="";



  MileStone({required this.MileStoneName,required this.BSP,required this.BasicInstallment,required this.GSTAmount,required this.TotalAmount,required this.BBA,required this.paid_status,required this.id});
  MileStone.fromJson(Map<String, dynamic> json) {
    MileStoneName = json['MileStoneName'].toString().replaceAll("null", "");
    BSP = json['BSP'].toString().replaceAll("null", "");
    BasicInstallment = json['BasicInstallment'].toString().replaceAll("null", "");
    GSTAmount = json['GSTAmount'].toString().replaceAll("null", "");
    TotalAmount = json['TotalAmount'].toString().replaceAll("null", "");
    BBA = json['BBA'].toString().replaceAll("null", "");
    paid_status = json['paid_status'].toString().replaceAll("null", "");
    id = json['payment_plan_milestone_id'].toString().replaceAll("null", "");



  }

}

class Others{
  String charge_title="";
  String is_chargable="";
  String total_amount="";
  String title="";
  String unit_name="";
  String charge_amount="";
  String qtys="";
  String mandatory_unit_num="";

  String mandatory_price="";


  Others({required this.charge_title,required this.is_chargable,required this.total_amount,
    required this.title,required this.unit_name,required this.charge_amount,required this.qtys});
  Others.fromJson(Map<String, dynamic> json) {
    charge_title = json['charge_title'].toString().replaceAll("null", "");
    is_chargable = json['is_chargable'].toString().replaceAll("null", "");
    total_amount = json['total_amount'].toString().replaceAll("null", "");
    title = json['title'].toString().replaceAll("null", "");
    unit_name = json['unit_name'].toString().replaceAll("null", "");
    charge_amount = json['charge_amount'].toString().replaceAll("null", "");
    qtys = json['qty'].toString().replaceAll("null", "");
    mandatory_unit_num = json['mandatory_unit_num'].toString().replaceAll("null", "");
    mandatory_price = json['mandatory_price'].toString().replaceAll("null", "");


  }

}

class wallet_data{
  String total_points="";
  String redeem_points="";
  String balance_points="";
  wallet_data({required this.total_points,required this.redeem_points,required this.balance_points,
  });
  wallet_data.fromJson(Map<String, dynamic> json) {
    total_points = json['total_points'].toString().replaceAll("null", "0");
    redeem_points = json['redeem_points'].toString().replaceAll("null", "0");
    balance_points = json['balance_points'].toString().replaceAll("null", "0");


  }

}

class POints{
  String earn_points="";
  String redeem_points="";
  String balance_points="";
  POints({required this.earn_points,required this.redeem_points,required this.balance_points,
  });
  POints.fromJson(Map<String, dynamic> json) {
    earn_points =json['earn_points'].toString().replaceAll("null", "0");
    redeem_points = json['redeem_points'].toString().replaceAll("null", "0");
    balance_points = json['balance_points'].toString().replaceAll("null", "0");


  }

}



