//
//  AppDependencies.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 8/23/26.
//

import SwiftData
import HornsAppCore

/// Single composition root for the app. Builds repositories and use cases in one place
/// so Views and ViewModels stay free of infrastructure wiring.
@MainActor
final class AppDependencies {
    let appSettings: AppSettings

    private lazy var renderRepository: RenderRepository = {
        RenderRepositoryImpl(
            renderRemoteDataSource: SocketManager(
                renderStorageDataSource: HaFileReaderManager()
            )
        )
    }()

    init(appSettings: AppSettings = AppSettings()) {
        self.appSettings = appSettings
    }

    // MARK: - Repositories

    func concertRepository(context: ModelContext) -> ConcertRepository {
        ConcertRepositoryImpl(
            concertStorageDataSource: SwiftDataManager(context: context),
            concertRemoteDataSource: AlamoFireWrapper(appSettings: appSettings)
        )
    }

    func getRenderRepository() -> RenderRepository {
        renderRepository
    }

    // MARK: - Use Cases

    func makeGetConcertsUseCase(context: ModelContext) -> GetConcertsUseCase {
        GetConcertsUseCase(concertRepository: concertRepository(context: context))
    }

    func makeGetConcertUseCase(context: ModelContext) -> GetConcertUseCase {
        let repository = concertRepository(context: context)
        return GetConcertUseCase(
            concertRepository: repository,
            getFavoriteConcertsUseCase: makeGetFavoriteConcertsUseCase(context: context)
        )
    }

    func makeGetFavoriteConcertsUseCase(context: ModelContext) -> GetFavoriteConcertsUseCase {
        GetFavoriteConcertsUseCase(concertRepository: concertRepository(context: context))
    }

    func makeUpdateFavoriteConcertUseCase(context: ModelContext) -> UpdateFavoriteConcertUseCase {
        UpdateFavoriteConcertUseCase(concertRepository: concertRepository(context: context))
    }

    func makeGetUpcomingConcertsUseCase(context: ModelContext) -> GetUpcomingConcertsUseCase {
        GetUpcomingConcertsUseCase(
            concertRepository: concertRepository(context: context),
            filterConcertsByCategoryUseCase: FilterConcertsByCategoryUseCase()
        )
    }

    func makeGetHomeRenderUseCase() -> GetHomeRenderUseCase {
        UseCaseFactory().createGetHomeRenderUseCase(repository: renderRepository)
    }
}
