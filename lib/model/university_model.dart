class University {
  final String alphaTwoCode;
  final String name;
  final List<String>? web_pages;
  final String country;

  University(
      {required this.alphaTwoCode,
      required this.name,
      required this.web_pages,
      required this.country});

  factory University.fromJson(Map data){
    List<String> pages = [];
    data['web_pages'].forEach((element){
      pages.add(element);
    });
    return University(
      alphaTwoCode: data['alpha_two_code'],
      name: data['name'],
      web_pages: pages,
      country: data['country']
    );
  }
}
