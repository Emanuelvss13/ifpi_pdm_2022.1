class CriptoResource {
  final String? iconUrl;
  final String? title;
  final String? link;

  CriptoResource(
      {required this.iconUrl, required this.title, required this.link});

  factory CriptoResource.fromJson(Map<String, dynamic> json) {
    final iconUrl = json['icon_url'] as String?;
    final title = json['title'] as String?;
    final link = json['link'] as String?;
    return CriptoResource(iconUrl: iconUrl, title: title, link: link);
  }
}
