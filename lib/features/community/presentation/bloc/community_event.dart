import 'package:equatable/equatable.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object?> get props => [];
}

class LoadCommunityData extends CommunityEvent {}

class CreateDiscussion extends CommunityEvent {
  final String title;
  final String content;

  const CreateDiscussion(this.title, this.content);

  @override
  List<Object?> get props => [title, content];
}

class DonateToCharity extends CommunityEvent {
  final String charityId;
  final double amount;

  const DonateToCharity(this.charityId, this.amount);

  @override
  List<Object?> get props => [charityId, amount];
}



