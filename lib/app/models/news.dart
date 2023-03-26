class News {
  String? Id_Contenido_Cliente,
      Titulo,
      Descripcion,
      Tipo,
      Url_Imagen,
      Url_Pagina,
      Id_Estatus,
      Fecha_Alta,
      Usuario_Alta,
      Fecha_Modificacion,
      Usuario_Modificacion;

  News(
      {this.Id_Contenido_Cliente,
      this.Titulo,
      this.Descripcion,
      this.Tipo,
      this.Url_Imagen,
      this.Url_Pagina,
      this.Id_Estatus,
      this.Fecha_Alta,
      this.Usuario_Alta,
      this.Fecha_Modificacion,
      this.Usuario_Modificacion});

  factory News.fromJSON(Map<String, dynamic> parsedJson) {
    return News(
      Id_Contenido_Cliente: parsedJson['Id_Contenido_Cliente'].toString(),
      Titulo: parsedJson['Titulo'].toString(),
      Descripcion: parsedJson['Descripcion'].toString(),
      Tipo: parsedJson['Tipo'].toString(),
      Url_Imagen: parsedJson['Url_Imagen'].toString(),
      Url_Pagina: parsedJson['Url_Pagina'].toString(),
      Id_Estatus: parsedJson['Id_Estatus'].toString(),
      Fecha_Alta: parsedJson['Fecha_Alta'].toString(),
      Usuario_Alta: parsedJson['Usuario_Alta'].toString(),
      Fecha_Modificacion: parsedJson['Fecha_Modificacion'].toString(),
      Usuario_Modificacion: parsedJson['Usuario_Modificacion'].toString(),
    );
  }
}
