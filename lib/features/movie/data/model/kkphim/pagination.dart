class Pagination {
  final int totalItems;
  final int totalItemsPerPage;
  final int currentPage;
  final int totalPages;

  Pagination({
    required this.totalItems,
    required this.totalItemsPerPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      Pagination(
        totalItems: json["totalItems"],
        totalItemsPerPage: json["totalItemsPerPage"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalItemsPerPage": totalItemsPerPage,
        "currentPage": currentPage,
        "totalPages": totalPages,
      };
}
