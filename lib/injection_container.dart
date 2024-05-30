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
import 'package:flutter_project/features/auth/domain/usecases/sign_in_google_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:flutter_project/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:flutter_project/features/auth/presentaion/cubit/auth/auth_cubit.dart';
import 'package:flutter_project/features/auth/presentaion/cubit/forgot_password/forgot_password_cubit.dart';

import 'package:flutter_project/features/auth/presentaion/cubit/sign_in/sign_in_cubit.dart';
import 'package:flutter_project/features/auth/presentaion/cubit/sign_in_google/sign_in_google_cubit.dart';
import 'package:flutter_project/features/auth/presentaion/cubit/sign_up/sign_up_cubit.dart';
import 'package:flutter_project/features/book/data/data_sources/remote/best_seller_book_api_service.dart';
import 'package:flutter_project/features/book/data/data_sources/remote/book_api_service.dart';
import 'package:flutter_project/features/book/data/repository/best_seller_book_repository_impl.dart';
import 'package:flutter_project/features/book/data/repository/book_repository_impl.dart';
import 'package:flutter_project/features/book/domain/repository/best_seller_book_repository.dart';
import 'package:flutter_project/features/book/domain/repository/book_repository.dart';
import 'package:flutter_project/features/book/domain/usecases/get_best_seller_book.dart';
import 'package:flutter_project/features/book/domain/usecases/get_book.dart';
import 'package:flutter_project/features/book/prensentation/cubit/book/remote/remote_best_seller_book/remote_best_seller_book_cubit.dart';
import 'package:flutter_project/features/book/prensentation/cubit/book/remote/remote_book/remote_book_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //dio
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<FirebaseAuthDataSource>(FirebaseAuthDataSourceImpl(
      FirebaseAuth.instance, FirebaseFirestore.instance));
  sl.registerSingleton<BookApiService>(BookApiService(sl()));
  sl.registerSingleton<BestSellerBookApiService>(
      BestSellerBookApiService(sl()));

  sl.registerSingleton<FirebaseAuthRepository>(
      FirebaseAuthRepositoryImpl(sl()));
  sl.registerSingleton<BookRepository>(BookRepositoryImpl(sl()));
  sl.registerSingleton<BestSellerBookRepository>(
      BestSellerBookRepositoryImpl(sl()));

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
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl()));
  sl.registerSingleton<SendPasswordResetEmailUseCase>(SendPasswordResetEmailUseCase(sl()));

  // sl.registerSingleton<SignInGoogleUsecase>(SignInGoogleUsecase(sl()));

  // sl.registerSingleton<GetBookUseCase>(GetBookUseCase(sl()));
  // sl.registerSingleton<GetBestSellerBookUseCase>(
  //     GetBestSellerBookUseCase(sl()));

  //Cubit
  sl.registerFactory<SignInCubit>(() => SignInCubit(sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl()));
  // sl.registerFactory<SignInGoogleCubit>(() => SignInGoogleCubit(sl()));
  sl.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(sl()));

  // sl.registerFactory<RemoteBookCubit>(() => RemoteBookCubit(sl()));
  // sl.registerFactory<RemoteBestSellerBookCubit>(
  //     () => RemoteBestSellerBookCubit(sl()));
}
