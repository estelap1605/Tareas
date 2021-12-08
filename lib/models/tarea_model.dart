class TareaModel{
int? idTarea;
String? nomTarea;
String? dscTarea;
String? fechaEntrega;
String? entregada;

/*NotasModel( int id, String titulo, String detalle ){
  this.id = id;
  this. titulo = titulo;
  this.detalle = detalle;
}*/
// este esquema sirve para obtener un tipo de dato y lo transforma en un objeto
TareaModel({this.idTarea, this.nomTarea, this.dscTarea, this.fechaEntrega, this.entregada});

//Map -> object
factory TareaModel.fromMap(Map<String, dynamic> map){
return TareaModel(
  idTarea: map['idTarea'],
  nomTarea: map['nomTarea'],
  dscTarea: map['dscTarea'],
  fechaEntrega: map['fechaEntrega'],
  entregada: map['entregada']
);
}

//object -> Map
  //servira cuando queremos llenar con datos en la BD
Map<String,dynamic> toMap(){
  return {
    'idTarea' : idTarea,
    'nomTarea': nomTarea,
    'dscTarea': dscTarea,
    'fechaEntrega': fechaEntrega,
    'entregada': entregada
  };
}

}