DateTime timeConvertor(String time) {
  if (time == null) return null;
  final List<int> _timeSteps = time.split(':').map((e) => int.parse(e)).toList();
  final _date = DateTime.now();

  return DateTime(
    _date.year,
    _date.month,
    _date.day,
    _timeSteps[0],
    _timeSteps[1],
    _timeSteps[2],
  );
}
