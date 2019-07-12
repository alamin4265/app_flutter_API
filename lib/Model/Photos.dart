class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;
Photo._({this.id,this.title, this.thumbnailUrl});
factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo._(
      id:json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}