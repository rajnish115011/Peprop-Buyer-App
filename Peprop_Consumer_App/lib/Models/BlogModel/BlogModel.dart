class BlogModel {
  int? id;
  String? date;
  String? link;
  Title? title;
  Content? content;
  Excerpt? excerpt;
  int? authorID;

  BlogModel({this.id, this.date, this.link,
    this.title, this.content, this.excerpt, this.authorID});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    link = json['link'];
    authorID = json['author'];

    title = json['title'] != "" ? new Title.fromJson(json['title']) : null;
    content =
    json['content'] != "" ? new Content.fromJson(json['content']) : null;
    excerpt = json['excerpt'] != "" ? new Excerpt.fromJson(json['excerpt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['link'] = this.link;
    data['author'] = this.authorID;
    if (this.title != null) {
      data['title'] = this.title?.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content?.toJson();
    }
    if (this.excerpt != null) {
      data['excerpt'] = this.excerpt?.toJson();
    }
    return data;
  }
}

class Title {
  String? rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}

class Excerpt {
  String? rendered;
  bool? protected;

  Excerpt({this.rendered, this.protected});

  Excerpt.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}


class AuthorModel {
  int? id;
  String? name;

  AuthorModel({this.id, this.name,});

  AuthorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class BImageModel {
  int? id;
  String? imageLink;

  BImageModel({this.id, this.imageLink,});

  BImageModel.fromJson(Map<String, dynamic> json) {
    id = json['post'];
    imageLink = json['source_url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post'] = this.id;
    data['source_url'] = this.imageLink;
    return data;
  }
}
