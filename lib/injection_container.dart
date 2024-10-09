import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:flutter_project/features/auth/data/data_source/remote/auth_data_source_impl.dart';
import 'package:flutter_project/features/auth/data/repository/firebase_auth_repository_impl.dart';
import 'package:flutter_project/features/auth/domain/repository/firebase_auth_repository.dart';
import 'package:flutter_project/features/auth/domain/usecases/create_user_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/get_current_uid_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/is_sign_in_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/send_password_reset_email_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:flutter_project/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_project/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:flutter_project/features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:flutter_project/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:flutter_project/features/books/data/data_sources/remote/book_api_data_source/book_api_data_source.dart';
import 'package:flutter_project/features/books/data/data_sources/remote/firebase_book_data_source/firebase_book_data_source.dart';
import 'package:flutter_project/features/books/data/data_sources/remote/firebase_book_data_source/firebase_book_data_source_impl.dart';
import 'package:flutter_project/features/books/data/repository/book_repository/book_repository_impl.dart';
import 'package:flutter_project/features/books/data/repository/firebase_book_repository/firebase_book_repository_impl.dart';
import 'package:flutter_project/features/books/domain/repository/book_repository.dart';
import 'package:flutter_project/features/books/domain/repository/firebase_book_repository.dart';
import 'package:flutter_project/features/books/domain/usecases/create_book_use_case.dart';
import 'package:flutter_project/features/books/domain/usecases/get_book_use_case.dart';
import 'package:flutter_project/features/books/presentation/cubit/book/remote/remote_book/remote_book_cubit.dart';
import 'package:flutter_project/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_project/features/user/data/data_source/firebase_user_book_data_source/user_mark_as_read_data_source/user_mark_as_read_data_source.dart';
import 'package:flutter_project/features/user/data/data_source/firebase_user_book_data_source/user_mark_as_read_data_source/user_mark_as_read_data_source_impl.dart';
import 'package:flutter_project/features/user/data/repository/firebase_user_mark_as_read_repository_impl.dart';
import 'package:flutter_project/features/user/domain/repository/firebase_user_mark_as_read_repository.dart';
import 'package:flutter_project/features/user/domain/usecases/user_add_to_want_to_read_use_case.dart';
import 'package:flutter_project/features/user/domain/usecases/user_favorite_book_use_case.dart';
import 'package:flutter_project/features/user/domain/usecases/user_get_only_favorite_read_book.dart';
import 'package:flutter_project/features/user/domain/usecases/user_get_read_books_use_case.dart';
import 'package:flutter_project/features/user/domain/usecases/user_get_want_to_read_use_case.dart';
import 'package:flutter_project/features/user/domain/usecases/user_mark_as_read_use_case.dart';
import 'package:flutter_project/features/user/presentation/cubit/user_mark_as_read_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //dio
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<FirebaseAuthDataSource>(FirebaseAuthDataSourceImpl(
      FirebaseAuth.instance, FirebaseFirestore.instance));
  sl.registerSingleton<BookApiDataSource>(BookApiDataSource(sl()));
  sl.registerSingleton<RemoteBookDataSource>(
      RemoteBookDataSourceImpl(FirebaseFirestore.instance));
  sl.registerSingleton<UserMarkAsReadDataSource>(
      UserMarkAsReadDataSourceImpl(FirebaseFirestore.instance));

  // sl.registerSingleton<BestSellerBookApiService>(
  //     BestSellerBookApiService(sl()));

  sl.registerSingleton<FirebaseAuthRepository>(
      FirebaseAuthRepositoryImpl(sl()));
  sl.registerSingleton<BookRepository>(BookRepositoryImpl(sl()));
  sl.registerSingleton<FirebaseBookRepository>(
      FirebaseBookRepositoryImpl(sl()));
  sl.registerSingleton<FirebaseUserMarkAsReadRepository>(
      FirebaseUserMarkAsReadRepositoryImpl(sl()));

  // sl.registerSingleton<BestSellerBookRepository>(
  //     BestSellerBookRepositoryImpl(sl()));

  //UseCases
  sl.registerFactory(
    () => AuthCubit(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );
  sl.registerSingleton<CreateUserUseCase>(CreateUserUseCase(sl()));
  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl()));
  sl.registerSingleton<IsSignInUseCase>(IsSignInUseCase(sl()));
  sl.registerSingleton<GetCurrentUidUseCase>(GetCurrentUidUseCase(sl()));

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl()));
  sl.registerSingleton<SendPasswordResetEmailUseCase>(
      SendPasswordResetEmailUseCase(sl()));

  // sl.registerSingleton<SignInGoogleUsecase>(SignInGoogleUsecase(sl()));

  sl.registerSingleton<CreateBookUseCase>(CreateBookUseCase(sl()));

  sl.registerSingleton<GetBookUseCase>(GetBookUseCase(sl()));
  sl.registerSingleton<UserMarkAsReadUseCase>(UserMarkAsReadUseCase(sl()));

  sl.registerSingleton<UserGetOnlyFavoriteReadBook>(
      UserGetOnlyFavoriteReadBook(sl()));

  sl.registerSingleton<UserGetReadBooksUseCase>(UserGetReadBooksUseCase(sl()));
  sl.registerSingleton<UserFavoriteBookUseCase>(UserFavoriteBookUseCase(sl()));

  sl.registerSingleton<UserAddToWantToReadUseCase>(
      UserAddToWantToReadUseCase(sl()));
  sl.registerSingleton<UserGetWantToReadUseCase>(
      UserGetWantToReadUseCase(sl()));

  // sl.registerSingleton<GetBestSellerBookUseCase>(
  //     GetBestSellerBookUseCase(sl()));

  //Cubit
  sl.registerFactory<SignInCubit>(() => SignInCubit(sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl()));
  // sl.registerFactory<SignInGoogleCubit>(() => SignInGoogleCubit(sl()));
  sl.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(sl()));

  sl.registerFactory<RemoteBookCubit>(() => RemoteBookCubit(sl(), sl()));
  sl.registerFactory<UserMarkAsReadCubit>(
      () => UserMarkAsReadCubit(sl(), sl(), sl()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl(), sl(), sl()));

  // sl.registerFactory<RemoteBestSellerBookCubit>(
  //     () => RemoteBestSellerBookCubit(sl()));
}
