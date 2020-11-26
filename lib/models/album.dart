class Album  {
	int userId;
	int id;
	String title;

	Album({this.userId, this.id, this.title});

	factory Album.fromJson(Map<String, dynamic> json) {
		return Album(
			userId: json['userId'],
			id: json['id'],
			title: json['title'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userId'] = this.userId;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}


}
