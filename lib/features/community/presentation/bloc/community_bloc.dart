import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/community/presentation/bloc/community_event.dart';
import 'package:islamic_app/features/community/presentation/bloc/community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(CommunityInitial()) {
    on<LoadCommunityData>(_onLoadCommunityData);
    on<CreateDiscussion>(_onCreateDiscussion);
    on<DonateToCharity>(_onDonateToCharity);
  }

  Future<void> _onLoadCommunityData(
    LoadCommunityData event,
    Emitter<CommunityState> emit,
  ) async {
    emit(CommunityLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Mock Discussions
      final discussions = [
        const Discussion(
          id: '1',
          title: 'Understanding Ramadan Fasting',
          author: 'Ahmad Ali',
          preview: 'What are the best practices for fasting during Ramadan?',
          replies: 24,
          timeAgo: '2 hours ago',
        ),
        const Discussion(
          id: '2',
          title: 'Hajj Preparations',
          author: 'Fatima Hassan',
          preview: 'Planning my first Hajj journey, any tips?',
          replies: 45,
          timeAgo: '5 hours ago',
        ),
        const Discussion(
          id: '3',
          title: 'Learning Arabic Online',
          author: 'Mohammed Khan',
          preview: 'Best resources for learning Quranic Arabic?',
          replies: 18,
          timeAgo: '1 day ago',
        ),
      ];

      // Mock Charities
      final charities = [
        const Charity(
          id: '1',
          name: 'Feed the Hungry',
          description: 'Provide meals to those in need during Ramadan',
          goal: 50000,
          raised: 35000,
          category: 'Food Relief',
        ),
        const Charity(
          id: '2',
          name: 'Build a Mosque',
          description: 'Help construct a new mosque in rural area',
          goal: 200000,
          raised: 125000,
          category: 'Infrastructure',
        ),
        const Charity(
          id: '3',
          name: 'Education for All',
          description: 'Support Islamic education for underprivileged',
          goal: 30000,
          raised: 22000,
          category: 'Education',
        ),
      ];

      // Mock Articles
      final articles = [
        const Article(
          id: '1',
          title: 'The Importance of Prayer in Daily Life',
          author: 'Sheikh Abdullah',
          summary: 'Understanding how prayer connects us with Allah...',
          readTime: '5 min read',
          category: 'Spirituality',
        ),
        const Article(
          id: '2',
          title: 'Islamic Finance: A Beginner\'s Guide',
          author: 'Dr. Aisha Rahman',
          summary: 'Learn about halal investment and banking...',
          readTime: '8 min read',
          category: 'Finance',
        ),
        const Article(
          id: '3',
          title: 'Parenting in Islam',
          author: 'Umm Yusuf',
          summary: 'Raising children with Islamic values...',
          readTime: '6 min read',
          category: 'Family',
        ),
      ];

      emit(CommunityLoaded(
        discussions: discussions,
        charities: charities,
        articles: articles,
      ));
    } catch (e) {
      emit(CommunityError('Failed to load community data: ${e.toString()}'));
    }
  }

  void _onCreateDiscussion(
    CreateDiscussion event,
    Emitter<CommunityState> emit,
  ) {
    // Handle discussion creation
  }

  void _onDonateToCharity(
    DonateToCharity event,
    Emitter<CommunityState> emit,
  ) {
    // Handle charity donation
  }
}



