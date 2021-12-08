class ForeCast {
  String? date;
  String? weekday;
  int? max;
  int? min;
  String? description;
  String? condition;

  
  ForeCast({
    this.date,
    this.weekday,
    this.max,
    this.min,
    this.description,
    this.condition
  });

  factory ForeCast.fromJson(Map<String, dynamic> json) {
    return ForeCast(
      date: json["date"],
      weekday: json["weekday"],
      max: json["max"],
      min: json["min"],
      description: json["description"],
      condition: json["condition"]
    );
  }
}
