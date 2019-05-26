class Book {
  String author;
  String name;
  String imageUrl;
  String star;
  String releaseDate;
  String desc;

  Book(this.author, this.name, this.desc, this.imageUrl, this.releaseDate,
      this.star);
  Book.Empty() {}
  List<Book> delete(String name, List<Book> list) {
    list.removeWhere((test) => test.name == name);
    return list;
  }

  String add(Book book, List<Book> list) {
    if (list.length==3) return 'It was added before.';
    return 'Item is added to list.';
  }
}
