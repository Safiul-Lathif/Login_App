class Login {
  final String teacherId;
  final String firstName;
  final String mobile;
  final int changePassword;
  final String loginId;
  final String token;

  Login(
      {required this.teacherId,
      required this.firstName,
      required this.mobile,
      required this.changePassword,
      required this.loginId,
      required this.token});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      teacherId: json["teacher_data"]["teacher_id"],
      firstName: json["teacher_data"]["first_name"],
      mobile: json["teacher_data"]["mobile_no"],
      changePassword: json["teacher_data"]["change_password"],
      loginId: json["teacher_data"]["user_login_id"],
      token: json["token"],
    );
  }
}

class SchoolData {
  SchoolData({
    required this.id,
    required this.schoolName,
    required this.schoolId,
    required this.schoolContactPerson,
    required this.schoolContactNumb,
    required this.schoolLandlineNumb,
    required this.schoolMailId,
    required this.schoolAddress,
    required this.pincode,
    required this.district,
    required this.studentCount,
    required this.demoRequest,
    required this.serviceSubscribed,
    required this.knownFrom,
    required this.coOrdinator,
    required this.referedSchool,
    required this.createdBy,
    required this.createdAt,
    required this.urlKey,
    required this.demoGivenBy,
    required this.feesInclusive,
    required this.cmsAuthStatus,
    required this.reportcardStatusBar,
    required this.motherNameVisibility,
    required this.updatedAt,
    required this.promotedClass,
    required this.detainedClass,
    required this.promotedRemark,
    required this.detainedRemark,
    required this.clientConfig,
    required this.logo,
  });

  int id;
  String schoolName;
  String schoolId;
  String schoolContactPerson;
  String schoolContactNumb;
  String schoolLandlineNumb;
  String schoolMailId;
  String schoolAddress;
  int pincode;
  int district;
  int studentCount;
  int demoRequest;
  String serviceSubscribed;
  String knownFrom;
  dynamic coOrdinator;
  String referedSchool;
  dynamic createdBy;
  DateTime createdAt;
  String urlKey;
  dynamic demoGivenBy;
  String feesInclusive;
  int cmsAuthStatus;
  int reportcardStatusBar;
  int motherNameVisibility;
  dynamic updatedAt;
  int promotedClass;
  int detainedClass;
  int promotedRemark;
  int detainedRemark;
  int clientConfig;
  dynamic logo;

  factory SchoolData.fromJson(Map<String, dynamic> json) => SchoolData(
        id: json["id"],
        schoolName: json["school_name"],
        schoolId: json["school_id"],
        schoolContactPerson: json["school_contact_person"],
        schoolContactNumb: json["school_contact_numb"],
        schoolLandlineNumb: json["school_landline_numb"],
        schoolMailId: json["school_mail_id"],
        schoolAddress: json["school_address"],
        pincode: json["pincode"],
        district: json["district"],
        studentCount: json["student_count"],
        demoRequest: json["demo_request"],
        serviceSubscribed: json["service_subscribed"],
        knownFrom: json["known_from"],
        coOrdinator: json["co_ordinator"],
        referedSchool: json["refered_school"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        urlKey: json["url_key"],
        demoGivenBy: json["demo_given_by"],
        feesInclusive: json["fees_inclusive"],
        cmsAuthStatus: json["cms_auth_status"],
        reportcardStatusBar: json["reportcard_status_bar"],
        motherNameVisibility: json["mother_name_visibility"],
        updatedAt: json["updated_at"],
        promotedClass: json["promoted_class"],
        detainedClass: json["detained_class"],
        promotedRemark: json["promoted_remark"],
        detainedRemark: json["detained_remark"],
        clientConfig: json["client_config"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_name": schoolName,
        "school_id": schoolId,
        "school_contact_person": schoolContactPerson,
        "school_contact_numb": schoolContactNumb,
        "school_landline_numb": schoolLandlineNumb,
        "school_mail_id": schoolMailId,
        "school_address": schoolAddress,
        "pincode": pincode,
        "district": district,
        "student_count": studentCount,
        "demo_request": demoRequest,
        "service_subscribed": serviceSubscribed,
        "known_from": knownFrom,
        "co_ordinator": coOrdinator,
        "refered_school": referedSchool,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "url_key": urlKey,
        "demo_given_by": demoGivenBy,
        "fees_inclusive": feesInclusive,
        "cms_auth_status": cmsAuthStatus,
        "reportcard_status_bar": reportcardStatusBar,
        "mother_name_visibility": motherNameVisibility,
        "updated_at": updatedAt,
        "promoted_class": promotedClass,
        "detained_class": detainedClass,
        "promoted_remark": promotedRemark,
        "detained_remark": detainedRemark,
        "client_config": clientConfig,
        "logo": logo,
      };
}

class TeacherData {
  TeacherData({
    required this.teacherTableId,
    required this.teacherId,
    required this.firstName,
    required this.mobileNo,
    required this.changePassword,
    required this.userLoginId,
  });

  int teacherTableId;
  String teacherId;
  String firstName;
  String mobileNo;
  int changePassword;
  String userLoginId;

  factory TeacherData.fromJson(Map<String, dynamic> json) => TeacherData(
        teacherTableId: json["teacher_table_id"],
        teacherId: json["teacher_id"],
        firstName: json["first_name"],
        mobileNo: json["mobile_no"],
        changePassword: json["change_password"],
        userLoginId: json["user_login_id"],
      );

  Map<String, dynamic> toJson() => {
        "teacher_table_id": teacherTableId,
        "teacher_id": teacherId,
        "first_name": firstName,
        "mobile_no": mobileNo,
        "change_password": changePassword,
        "user_login_id": userLoginId,
      };
}
