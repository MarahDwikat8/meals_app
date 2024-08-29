class Area {

final String strArea;
Area({required this.strArea});

factory Area.fromJson(Map<String,dynamic> json){
return Area(strArea: json['strArea'],
);
}


}