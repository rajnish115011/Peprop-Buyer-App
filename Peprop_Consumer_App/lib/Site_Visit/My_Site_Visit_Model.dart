



class My_Site_Visit_Model {
  String? taskId;
  String? leadId;
  String? leadName;
  String? rmName;
  String? propertyName;
  String? propertyId;
  String? fromSchedule;
  String? toSchedule;
  String? status;
  String? visitCount;
  String? from_time;
  String? to_time;
  String? Address;
  String? owner_id;
  String? description;
  String? cus_status;
  String? is_approved;
  String? created_by;
  String? rm_mobile;
  String? FeaturedImage;






  My_Site_Visit_Model(
      {this.taskId,
        this.leadId,
        this.leadName,
        this.rmName,
        this.propertyName,
        this.propertyId,
        this.fromSchedule,
        this.toSchedule,
        this.status,
        this.visitCount,
        this.from_time,
        this.to_time,
        this.Address,
        this.owner_id,
        this.description,
        this.cus_status,
        this.is_approved,
        this.created_by,
        this.rm_mobile,


      });

  My_Site_Visit_Model.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    leadId = json['lead_id'];
    leadName = json['lead_name'];
    rmName = json['rm_name'].toString().replaceAll("null", "");
    propertyName = json['property_name'];
    propertyId = json['property_id'];
    fromSchedule = json['from_schedule'];
    toSchedule = json['to_schedule'];
    status = json['status'];
    visitCount = json['visit_count'];
    from_time = json['from_time'];
    to_time = json['to_time'];
    Address = json['Address'];
    owner_id = json['owner_id'];
    description = json['description'].toString().replaceAll("null", "");
    cus_status = json['cus_status'];
    is_approved = json['is_approved'];
    created_by = json['created_by'];
    rm_mobile = json['rm_mobile'].toString().replaceAll("null", "");
    FeaturedImage = json['FeaturedImage'].toString().replaceAll("null", "");


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['lead_id'] = this.leadId;
    data['lead_name'] = this.leadName;
    data['rm_name'] = this.rmName;
    data['property_name'] = this.propertyName;
    data['property_id'] = this.propertyId;
    data['from_schedule'] = this.fromSchedule;
    data['to_schedule'] = this.toSchedule;
    data['status'] = this.status;
    data['visit_count'] = this.visitCount;
    data['from_time'] = this.from_time;
    data['to_time'] = this.to_time;
    data['Address'] = this.Address;
    return data;
  }
}


class My_Site {
  String? first_name;
  String? last_name;
  String? address_1;
  String? PropertyTitle;
  String? propertyName;
  String? propertyId;
  String? fromSchedule;
  String? toSchedule;
  String? status;
  String? visitCount;
  String? from_time;
  String? to_time;
  String? Address;
  String? owner_id;
  String? description;
  String? property_id;
  String? task_id;
  String? subject;
  String? lead_id;
  String? cus_status;












  My_Site.fromJson(Map<String, dynamic> json) {
    first_name = json['first_name'].toString().replaceAll("null", "");
    last_name = json['last_name'].toString().replaceAll("null", "");
    address_1 = json['address_1'].toString().replaceAll("null", "");
    PropertyTitle = json['PropertyTitle'].toString().replaceAll("null", "");
    propertyName = json['property_name'].toString().replaceAll("null", "");
    propertyId = json['property_id'].toString().replaceAll("null", "");
    fromSchedule = json['from_schedule'].toString().replaceAll("null", "");
    toSchedule = json['to_schedule'].toString().replaceAll("null", "");
    status = json['status'].toString().replaceAll("null", "");
    visitCount = json['visit_count'].toString().replaceAll("null", "");
    from_time = json['from_time'].toString().replaceAll("null", "");
    to_time = json['to_time'].toString().replaceAll("null", "");
    Address = json['Address'].toString().replaceAll("null", "");
    owner_id = json['owner_id'].toString().replaceAll("null", "");
    description = json['description'].toString().replaceAll("null", "");
    property_id = json['property_id'].toString().replaceAll("null", "");
    task_id = json['task_id'].toString().replaceAll("null", "");
    subject = json['subject'].toString().replaceAll("null", "");
    lead_id = json['lead_id'].toString().replaceAll("null", "");
    cus_status = json['cus_status'].toString().replaceAll("null", "");




  }

}