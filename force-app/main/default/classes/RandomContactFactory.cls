public with sharing class RandomContactFactory {
  public static List<Contact> generateRandomContacts(
    Integer numCtc,
    String lastname
  ) {
    List<Contact> contacts = new List<Contact>();

    for (Integer i = 0; i < numCtc; i++) {
      Contact cnt = new Contact(
        Firstname = 'Test ' + numCtc,
        Lastname = lastname
      );
      contacts.add(cnt);
    }

    return contacts;
  }
}