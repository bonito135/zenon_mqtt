List<dynamic> convertNumberedObjToList(Map<dynamic, dynamic> obj) {
  var returnList = [];
  if (obj.isEmpty) return [];

  for (var MapEntry(:key, :value) in obj.entries) {
    returnList.add(value);
  }

  return returnList;
}
