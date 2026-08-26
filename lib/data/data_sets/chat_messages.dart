import 'package:anyamar/data/models/chat/chat_message_model.dart';
import 'package:anyamar/data/models/chat/chat_user.dart';
import 'package:anyamar/data/models/enums/user_type_enum.dart';

List<ChatMessage> chatMessages = [
  ChatMessage(
    sender: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    receipient: ChatUser(
      userName: 'Luigi',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'Hello',
    chatTime: DateTime(2026, 3, 20),
  ),
  ChatMessage(
    receipient: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    sender: ChatUser(
      userName: 'Luigi',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'I\'m fine thankyou',
    chatTime: DateTime(2026, 3, 21),
  ),
  ChatMessage(
    sender: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    receipient: ChatUser(
      userName: 'Luigi',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'Kindly pay your rent in time',
    chatTime: DateTime(2026, 3, 21),
  ),
  ChatMessage(
    receipient: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    sender: ChatUser(
      userName: 'Luigi',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'Noted thanks',
    chatTime: DateTime.now(),
  ),
  ChatMessage(
    sender: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    receipient: ChatUser(
      userName: 'Luigi',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage:
        'A very long text here to test responsiveness of the chat bubble widget, bare with me this is a very very extremely long and redudant paragraph, with no breaks just constant rumbling.',
    chatTime: DateTime.now(),
  ),
];
List<ChatMessage> chatMessages2 = [
  ChatMessage(
    sender: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    receipient: ChatUser(
      userName: 'Sephile',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'Hello',
    chatTime: DateTime(2026, 3, 20),
  ),
  ChatMessage(
    receipient: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    sender: ChatUser(
      userName: 'Sadio',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'I\'m fine thankyou',
    chatTime: DateTime(2026, 3, 21),
  ),
  ChatMessage(
    sender: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    receipient: ChatUser(
      userName: 'Mane',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'Kindly pay your rent in time',
    chatTime: DateTime(2026, 3, 21),
  ),
];

List<ChatMessage> chatMessages3 = [
  ChatMessage(
    sender: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    receipient: ChatUser(
      userName: 'Mandla',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'Hello',
    chatTime: DateTime(2026, 3, 20),
  ),
  ChatMessage(
    receipient: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    sender: ChatUser(
      userName: 'Mandla',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'I\'m fine thankyou',
    chatTime: DateTime(2026, 3, 21),
  ),
];
List<ChatMessage> chatMessages4 = [
  ChatMessage(
    sender: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    receipient: ChatUser(
      userName: 'Sarafina',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'Hello',
    chatTime: DateTime(2026, 3, 20),
  ),
  ChatMessage(
    receipient: ChatUser(
      userName: 'Sarafina',
      userId: '001',
      userType: UserType.landlord,
    ),
    sender: ChatUser(
      userName: 'Sadio',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'I\'m fine thankyou',
    chatTime: DateTime(2026, 3, 21),
  ),
];
List<ChatMessage> chatMessages5 = [
  ChatMessage(
    sender: ChatUser(
      userName: 'Mario',
      userId: '001',
      userType: UserType.landlord,
    ),
    receipient: ChatUser(
      userName: 'AJ',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'Hello',
    chatTime: DateTime(2026, 3, 20),
  ),
  ChatMessage(
    receipient: ChatUser(
      userName: 'AJ',
      userId: '001',
      userType: UserType.landlord,
    ),
    sender: ChatUser(
      userName: 'Sadio',
      userId: '002',
      userType: UserType.tenant,
    ),
    chatMessage: 'I\'m fine thankyou',
    chatTime: DateTime(2026, 3, 21),
  ),
];
