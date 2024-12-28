import 'package:vie_flix/features/movie/domain/entity/pagination_entity.dart';

class Pagination extends PaginationEntity {
  const Pagination({
    required super.totalItems,
    required super.totalItemsPerPage,
    required super.currentPage,
    required super.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalItems: json["total_items"] ?? json["totalItems"],
        totalItemsPerPage: json["items_per_page"] ?? json["totalItemsPerPage"],
        currentPage: json["current_page"] ?? json["currentPage"],
        totalPages: json["total_page"] ?? json["totalPages"],
      );
}
