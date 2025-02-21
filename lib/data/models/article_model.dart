class NewsResponse {

  String? status;
  String? copyright;
  Response? response;

  NewsResponse({this.status, this.copyright, this.response});

  NewsResponse.fromJson(Map<String, dynamic> json) {
  status = json["status"];
  copyright = json["copyright"];
  response = json["response"] == null ? null : Response.fromJson(json["response"]);
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["status"] = status;
  _data["copyright"] = copyright;
  if(response != null) {
  _data["response"] = response?.toJson();
  }
  return _data;
  }
  }

  class Response {
  List<Docs>? docs;
  Meta? meta;

  Response({this.docs, this.meta});

  Response.fromJson(Map<String, dynamic> json) {
  docs = json["docs"] == null ? null : (json["docs"] as List).map((e) => Docs.fromJson(e)).toList();
  meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  if(docs != null) {
  _data["docs"] = docs?.map((e) => e.toJson()).toList();
  }
  if(meta != null) {
  _data["meta"] = meta?.toJson();
  }
  return _data;
  }
  }

  class Meta {
  int? hits;
  int? offset;
  int? time;

  Meta({this.hits, this.offset, this.time});

  Meta.fromJson(Map<String, dynamic> json) {
  hits = json["hits"];
  offset = json["offset"];
  time = json["time"];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["hits"] = hits;
  _data["offset"] = offset;
  _data["time"] = time;
  return _data;
  }
  }

  class Docs {
  String? abstract;
  String? webUrl;
  String? snippet;
  String? leadParagraph;
  String? source;
  List<Multimedia>? multimedia;
  Headline? headline;
  List<Keywords>? keywords;
  String? pubDate;
  String? documentType;
  String? newsDesk;
  String? sectionName;
  Byline? byline;
  String? typeOfMaterial;
  String? id;
  int? wordCount;
  String? uri;

  Docs({this.abstract, this.webUrl, this.snippet, this.leadParagraph, this.source, this.multimedia, this.headline, this.keywords, this.pubDate, this.documentType, this.newsDesk, this.sectionName, this.byline, this.typeOfMaterial, this.id, this.wordCount, this.uri});

  Docs.fromJson(Map<String, dynamic> json) {
  abstract = json["abstract"];
  webUrl = json["web_url"];
  snippet = json["snippet"];
  leadParagraph = json["lead_paragraph"];
  source = json["source"];
  multimedia = json["multimedia"] == null ? null : (json["multimedia"] as List).map((e) => Multimedia.fromJson(e)).toList();
  headline = json["headline"] == null ? null : Headline.fromJson(json["headline"]);
  keywords = json["keywords"] == null ? null : (json["keywords"] as List).map((e) => Keywords.fromJson(e)).toList();
  pubDate = json["pub_date"];
  documentType = json["document_type"];
  newsDesk = json["news_desk"];
  sectionName = json["section_name"];
  byline = json["byline"] == null ? null : Byline.fromJson(json["byline"]);
  typeOfMaterial = json["type_of_material"];
  id = json["_id"];
  wordCount = json["word_count"];
  uri = json["uri"];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["abstract"] = abstract;
  _data["web_url"] = webUrl;
  _data["snippet"] = snippet;
  _data["lead_paragraph"] = leadParagraph;
  _data["source"] = source;
  if(multimedia != null) {
  _data["multimedia"] = multimedia?.map((e) => e.toJson()).toList();
  }
  if(headline != null) {
  _data["headline"] = headline?.toJson();
  }
  if(keywords != null) {
  _data["keywords"] = keywords?.map((e) => e.toJson()).toList();
  }
  _data["pub_date"] = pubDate;
  _data["document_type"] = documentType;
  _data["news_desk"] = newsDesk;
  _data["section_name"] = sectionName;
  if(byline != null) {
  _data["byline"] = byline?.toJson();
  }
  _data["type_of_material"] = typeOfMaterial;
  _data["_id"] = id;
  _data["word_count"] = wordCount;
  _data["uri"] = uri;
  return _data;
  }
  }

  class Byline {
  String? original;
  List<Person>? person;
  dynamic organization;

  Byline({this.original, this.person, this.organization});

  Byline.fromJson(Map<String, dynamic> json) {
  original = json["original"];
  person = json["person"] == null ? null : (json["person"] as List).map((e) => Person.fromJson(e)).toList();
  organization = json["organization"];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["original"] = original;
  if(person != null) {
  _data["person"] = person?.map((e) => e.toJson()).toList();
  }
  _data["organization"] = organization;
  return _data;
  }
  }

  class Person {
  String? firstname;
  dynamic middlename;
  String? lastname;
  dynamic qualifier;
  dynamic title;
  String? role;
  String? organization;
  int? rank;

  Person({this.firstname, this.middlename, this.lastname, this.qualifier, this.title, this.role, this.organization, this.rank});

  Person.fromJson(Map<String, dynamic> json) {
  firstname = json["firstname"];
  middlename = json["middlename"];
  lastname = json["lastname"];
  qualifier = json["qualifier"];
  title = json["title"];
  role = json["role"];
  organization = json["organization"];
  rank = json["rank"];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["firstname"] = firstname;
  _data["middlename"] = middlename;
  _data["lastname"] = lastname;
  _data["qualifier"] = qualifier;
  _data["title"] = title;
  _data["role"] = role;
  _data["organization"] = organization;
  _data["rank"] = rank;
  return _data;
  }
  }

  class Keywords {
  String? name;
  String? value;
  int? rank;
  String? major;

  Keywords({this.name, this.value, this.rank, this.major});

  Keywords.fromJson(Map<String, dynamic> json) {
  name = json["name"];
  value = json["value"];
  rank = json["rank"];
  major = json["major"];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["name"] = name;
  _data["value"] = value;
  _data["rank"] = rank;
  _data["major"] = major;
  return _data;
  }
  }

  class Headline {
  String? main;
  dynamic kicker;
  dynamic contentKicker;
  dynamic printHeadline;
  dynamic name;
  dynamic seo;
  dynamic sub;

  Headline({this.main, this.kicker, this.contentKicker, this.printHeadline, this.name, this.seo, this.sub});

  Headline.fromJson(Map<String, dynamic> json) {
  main = json["main"];
  kicker = json["kicker"];
  contentKicker = json["content_kicker"];
  printHeadline = json["print_headline"];
  name = json["name"];
  seo = json["seo"];
  sub = json["sub"];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["main"] = main;
  _data["kicker"] = kicker;
  _data["content_kicker"] = contentKicker;
  _data["print_headline"] = printHeadline;
  _data["name"] = name;
  _data["seo"] = seo;
  _data["sub"] = sub;
  return _data;
  }
  }

  class Multimedia {
  int? rank;
  String? subtype;
  dynamic caption;
  dynamic credit;
  String? type;
  String? url;
  int? height;
  int? width;
  Legacy? legacy;
  String? subType;
  String? cropName;

  Multimedia({this.rank, this.subtype, this.caption, this.credit, this.type, this.url, this.height, this.width, this.legacy, this.subType, this.cropName});

  Multimedia.fromJson(Map<String, dynamic> json) {
  rank = json["rank"];
  subtype = json["subtype"];
  caption = json["caption"];
  credit = json["credit"];
  type = json["type"];
  url = json["url"];
  height = json["height"];
  width = json["width"];
  legacy = json["legacy"] == null ? null : Legacy.fromJson(json["legacy"]);
  subType = json["subType"];
  cropName = json["crop_name"];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["rank"] = rank;
  _data["subtype"] = subtype;
  _data["caption"] = caption;
  _data["credit"] = credit;
  _data["type"] = type;
  _data["url"] = url;
  _data["height"] = height;
  _data["width"] = width;
  if(legacy != null) {
  _data["legacy"] = legacy?.toJson();
  }
  _data["subType"] = subType;
  _data["crop_name"] = cropName;
  return _data;
  }
  }

  class Legacy {
  String? xlarge;
  int? xlargewidth;
  int? xlargeheight;

  Legacy({this.xlarge, this.xlargewidth, this.xlargeheight});

  Legacy.fromJson(Map<String, dynamic> json) {
  xlarge = json["xlarge"];
  xlargewidth = json["xlargewidth"];
  xlargeheight = json["xlargeheight"];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> _data = <String, dynamic>{};
  _data["xlarge"] = xlarge;
  _data["xlargewidth"] = xlargewidth;
  _data["xlargeheight"] = xlargeheight;
  return _data;
  }
  }
