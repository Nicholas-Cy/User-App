import '../utils/constants.dart';

class JobPost {
  const JobPost({
    required this.id,
    required this.image,
    required this.title,
    required this.companyName,
    required this.jobTypeAndLocation,
    required this.salaryInfo,
  });
  final int id;
  final String image;
  final String title;
  final String companyName;
  final String jobTypeAndLocation;
  final String salaryInfo;
  // factory JobPost.fromJson(Map<String, dynamic> json) {
  //   return JobPost(
  //     id: json['id'],
  //     image: json['partner']['profile_picture'],
  //     title: json['title'],
  //     companyName: json['partner']['display_name'],
  //     jobTypeAndLocation:
  //         "${json['job_type']['name']} - ${(json['country'] == null) ? 'Remote' : '${json['city']}, ${json['country']}'}",
  //     salaryInfo: json['no_pay_range'] == 1
  //         ? 'N/A'
  //         : '${AppConstants.CURRENCY_PREFIX}${json['min_salary_range']} - ${AppConstants.CURRENCY_PREFIX}${json['max_salary_range']} / Annual',
  //   );
  // }
  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      id: json['id'],
      image: json['partner']['profile_picture'],
      title: json['title'] ?? 'Unknown Title', // Provide a default value for title
      companyName: json['partner']['display_name'] ?? 'Unknown Company', // Provide a default value for company name
      jobTypeAndLocation: "${json['job_type']['name'] ?? 'Unknown Job Type'} - ${json['city'] ?? 'Remote, ${json['country'] ?? 'Unknown Country'}'}",
      salaryInfo: json['no_pay_range'] == 1
          ? 'N/A'
          : '${AppConstants.CURRENCY_PREFIX}${json['min_salary_range'] ?? 'N/A'} - ${AppConstants.CURRENCY_PREFIX}${json['max_salary_range'] ?? 'N/A'} / Annual',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partner': {
        'profile_picture': image,
        'display_name': companyName,
      },
      'title': title,
      'job_type': {
        'name': jobTypeAndLocation.split(' - ')[0],
      },
      'country': jobTypeAndLocation.split(' - ')[1] == 'Remote'
          ? null
          : jobTypeAndLocation.split(', ')[1],
      'city': jobTypeAndLocation.split(', ')[0],
      'min_salary_range': salaryInfo == 'N/A'
          ? null
          : int.parse(salaryInfo.split(' - ')[0].replaceAll(AppConstants.CURRENCY_PREFIX, '')),
      'max_salary_range': salaryInfo == 'N/A'
          ? null
          : int.parse(salaryInfo.split(' - ')[1].replaceAll(AppConstants.CURRENCY_PREFIX, '').split(' /')[0]),
      'no_pay_range': salaryInfo == 'N/A' ? 1 : 0, // Adjusted condition here
    };
  }

//
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'partner': {
  //       'profile_picture': image,
  //       'display_name': companyName,
  //     },
  //     'title': title,
  //     'job_type': {
  //       'name': jobTypeAndLocation.split(' - ')[0],
  //     },
  //     'country': jobTypeAndLocation.split(' - ')[1] == 'Remote'
  //         ? null
  //         : jobTypeAndLocation.split(', ')[1],
  //     'city': jobTypeAndLocation.split(', ')[0],
  //     'min_salary_range': salaryInfo == 'N/A'
  //         ? null
  //         : int.parse(salaryInfo.split(' - ')[0].replaceAll(AppConstants.CURRENCY_PREFIX, '')),
  //     'max_salary_range': salaryInfo == 'N/A'
  //         ? null
  //         : int.parse(salaryInfo.split(' - ')[1].replaceAll(AppConstants.CURRENCY_PREFIX, '').split(' /')[0]),
  //     'no_pay_range': salaryInfo == 'N/A' ? 1 : 0,
  //   };
  // }
}
