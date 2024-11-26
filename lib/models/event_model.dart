class Event {
  final String id;
  final String title;
  final String secondTitle;
  final List<String> contractors;
  final List<String> eventProgram;
  final DateTime date;
  final String location;
  final String abbreviatedLocalization;
  final String imageUrl;
  final bool isPaid;

  Event({
    required this.id,
    required this.title,
    required this.secondTitle,
    required this.contractors,
    required this.eventProgram,
    required this.date,
    required this.location,
    required this.abbreviatedLocalization,
    required this.imageUrl,
    this.isPaid = true,
  });
}
