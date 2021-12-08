class Clima {
    
    static String GetID(json) {
    String id_filter="";
    json.forEach((key, value) {
      json.keys.forEach((key) {
        if (key == 'results') {
          id_filter = key;
        }
      });
    });
  return id_filter;
  }
  
   String? date;
   String ? weekday;
   late int? max;
   late int ?min;
   late String? description;
   late String ? condition;

  Clima(
      {required date,
      required  weekday,
      required  max,
      required  min,
      required  description,
      required  condition});



Clima.fromJson(Map<dynamic, dynamic> json) {
  String filtro_id =  Clima.GetID(json);
  json.forEach((key, value) {
    json.keys.forEach((key) {
      if (key == 'results') {
        filtro_id = key;
      }
    });
    print(json[filtro_id]['date']);
  });


   

    date = json[filtro_id]['date'];
    weekday = json[filtro_id]['weekday'];
    max = json[filtro_id]['max'];
    min = json[filtro_id]['min'];
    description = json[filtro_id]['description'];
    condition = json[filtro_id]['condition'];
    
    
  }
}