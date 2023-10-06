class UriRecordDTO {
  String id;
  String text;

  UriRecordDTO({required this.id, required this.text});

  factory UriRecordDTO.fromData(String data) {
    final parts = data.split(' ');
    final textStart = data.indexOf('text=') + 'text='.length;
    final extractedText = data.substring(textStart);
    return UriRecordDTO(
      id: parts[1].replaceAll('id=', ''),
      text: extractedText,
    );
  }
}
