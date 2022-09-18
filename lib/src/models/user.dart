import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.providerId,
  });

  /// The current user's id (uid).
  final String id;

  final String? email;
  final String? name;
  final String? photo;
  final String? providerId;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  String toString() {
    // TODO: implement toString
    return 'id:$id, name:$name, email:$email, photo:$photo';
  }

  @override
  List<Object?> get props => [email, id, name, photo];
}
