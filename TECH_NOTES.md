# Business Finder - Technical Notes

## Architecture

**Clean Architecture** with Provider state management, Dio networking, and SharedPreferences caching.

### Key Components
- **Models**: `Business` and `Service` with validation and `CardData` interface
- **Services**: `BusinessService` (Dio) + `StorageService` (SharedPreferences)
- **Provider**: `BusinessProvider` for reactive state management
- **UI**: Generic `InfoCard<T>` widget with loading/error/empty states

### Data Flow
```
JSON → Dio → BusinessService → StorageService → BusinessProvider → UI
```

## Features
- Provider state management
- Dio networking (local JSON)
- Reusable generic card widget
- Local persistence with offline support
- Search with real-time filtering
- Complete state handling (loading/error/empty)
- Data normalization (`biz_name` → `name`)

## Trade-offs

| Decision | Trade-off | Improvement |
|----------|-----------|-------------|
| Local JSON + Dio | Simple but unrealistic | Real API with proper error handling |
| Basic SharedPreferences | No TTL/invalidation | Cache expiration strategies |
| Simple error handling | Basic categorization | Specific error types + better UX |

## Future Improvements
- **API**: Real REST endpoints with retry logic
- **Caching**: TTL, invalidation, background refresh
- **Testing**: Unit, widget, and integration tests
- **Performance**: Pagination, image caching, optimized rendering
- **UX**: Animations, skeleton loading, debounced search
- **Architecture**: modular pattern, dependency injection

## Development Flow
1. Setup dependencies and data
2. Create models with validation
3. Implement state management
4. Build UI with all states
5. Polish and document
