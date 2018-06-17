class Categoria {
  int id;
  String nome;

  Categoria(this.id, this.nome);

  static Categoria fromMap(data){
    return new Categoria(data['id'], data['nome']);
  }
}