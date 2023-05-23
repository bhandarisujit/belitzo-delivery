class ShiftModel {
  int id;
  String name;
  String startTime;
  String endTime;
  int status;
  String createdAt;
  String updatedAt;

  ShiftModel(
      {this.id,
        this.name,
        this.startTime,
        this.endTime,
        this.status,
        this.createdAt,
        this.updatedAt});

  ShiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}