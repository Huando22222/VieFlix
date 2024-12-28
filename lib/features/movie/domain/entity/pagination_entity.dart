import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final int totalItems;
  final int totalItemsPerPage;
  final int currentPage;
  final int totalPages;

  const PaginationEntity({
    required this.totalItems,
    required this.totalItemsPerPage,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  List<Object?> get props =>
      [totalItems, totalItemsPerPage, currentPage, totalPages];
}
