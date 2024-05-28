String? validateUserName(String? value) {
  if (value == null || value.isEmpty) {
    return "Name is required";
  }
  if (value.length > 128) {
    return "Name must be at most 128 characters long";
  }
  if (value.length < 3) {
    return 'Name not valid';
  }
  if (!RegExp("^[a-zA-Z]+").hasMatch(value)) {
    return "Names must start with a letter and can only contain letters, numbers, or underscores";
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return "Address is required";
  }
  if (value.length > 128) {
    return "Address must be at most 128 characters long";
  }
  if (value.length < 3) {
    return 'Address not valid';
  }
  return null;
}

String? validateJobTitle(String? value) {
  if (value == null || value.isEmpty) {
    return "Jobtitle is required";
  }
  if (value.length > 128) {
    return "Jobtitle must be at most 128 characters long";
  }

  return null;
}

String? validateUpdateDate(String? value) {
  if (value == null || value.isEmpty) {
    return "Updatedate is required";
  }

  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email is required";
  }
  if (value.length > 128) {
    return "Email must be at most 128 characters long";
  }

  return null;
}

String? validateIncome(String? value) {
  if (value == null || value.isEmpty) {
    return "Income is required";
  }
  if (value.length > 128) {
    return "Name must be at most 128 characters long";
  }
  return null;
}
