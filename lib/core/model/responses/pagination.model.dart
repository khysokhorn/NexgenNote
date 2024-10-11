class PaginationModel {
  final int? pageNumber;
  final int? pageSize;
  final int? totalPages;
  final int? totalRecords;

  PaginationModel(
      this.pageNumber, this.pageSize, this.totalPages, this.totalRecords);
}
