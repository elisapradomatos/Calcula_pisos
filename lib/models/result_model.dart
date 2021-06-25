class ResultModel {
  double areaFloor;
  int piecesByWidth;
  int piecesByLength;
  double priceBypieces;

  ResultModel({
    this.areaFloor,
    this.piecesByWidth,
    this.piecesByLength,
    this.priceBypieces,
  });

  int get amountPieces => piecesByWidth * piecesByLength;
  int get amountFloor => piecesByWidth + piecesByLength;
  int get amountPiecesAndFooter => amountPieces + amountFloor;
  double get areaWithoutFooter => amountPieces * areaFloor;
  double get areaWithFooter => amountPiecesAndFooter * areaFloor;
  double get totalprice => amountPiecesAndFooter * priceBypieces;
}
