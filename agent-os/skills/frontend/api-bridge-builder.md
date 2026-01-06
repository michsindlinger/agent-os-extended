---
name: api-bridge-builder
description: Implements API integration and server state management
version: 1.0
---

# API Bridge Builder

Connects frontend to backend APIs using modern data fetching patterns (React Query, SWR), handles caching, optimistic updates, and error states.

## Trigger Conditions

```yaml
task_mentions:
  - "api|fetch|request"
  - "react query|swr|tanstack"
  - "endpoint|backend integration"
  - "cache|optimistic update"
file_extension:
  - .tsx
  - .ts
file_contains:
  - "useQuery"
  - "useMutation"
  - "fetch("
  - "axios"
always_active_for_agents:
  - frontend-agent
```

## When to Load

- Implementing API calls
- Setting up data fetching
- Handling loading/error states
- Implementing optimistic updates

## Core Competencies

### API Client Setup

```typescript
// lib/api/client.ts
import axios, { AxiosError, AxiosInstance } from 'axios';

const createApiClient = (): AxiosInstance => {
  const client = axios.create({
    baseURL: process.env.NEXT_PUBLIC_API_URL,
    timeout: 10000,
    headers: {
      'Content-Type': 'application/json'
    }
  });

  // Request interceptor for auth
  client.interceptors.request.use((config) => {
    const token = getAccessToken();
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  });

  // Response interceptor for errors
  client.interceptors.response.use(
    (response) => response,
    async (error: AxiosError) => {
      if (error.response?.status === 401) {
        // Try refresh token
        const newToken = await refreshAccessToken();
        if (newToken && error.config) {
          error.config.headers.Authorization = `Bearer ${newToken}`;
          return client.request(error.config);
        }
        // Redirect to login
        window.location.href = '/login';
      }
      return Promise.reject(error);
    }
  );

  return client;
};

export const apiClient = createApiClient();
```

### React Query Setup

```typescript
// lib/query/queryClient.ts
import { QueryClient } from '@tanstack/react-query';

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000, // 5 minutes
      gcTime: 10 * 60 * 1000, // 10 minutes (formerly cacheTime)
      retry: (failureCount, error) => {
        if (error instanceof ApiError && error.status >= 400 && error.status < 500) {
          return false; // Don't retry client errors
        }
        return failureCount < 3;
      },
      refetchOnWindowFocus: false
    },
    mutations: {
      retry: false
    }
  }
});
```

### Query Hooks Pattern

```typescript
// features/users/api/useUsers.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

// Query keys factory
export const userKeys = {
  all: ['users'] as const,
  lists: () => [...userKeys.all, 'list'] as const,
  list: (filters: UserFilters) => [...userKeys.lists(), filters] as const,
  details: () => [...userKeys.all, 'detail'] as const,
  detail: (id: string) => [...userKeys.details(), id] as const
};

// Fetch users list
export function useUsers(filters: UserFilters = {}) {
  return useQuery({
    queryKey: userKeys.list(filters),
    queryFn: async () => {
      const { data } = await apiClient.get<UsersResponse>('/api/v1/users', {
        params: filters
      });
      return data;
    },
    placeholderData: keepPreviousData // For pagination
  });
}

// Fetch single user
export function useUser(id: string) {
  return useQuery({
    queryKey: userKeys.detail(id),
    queryFn: async () => {
      const { data } = await apiClient.get<User>(`/api/v1/users/${id}`);
      return data;
    },
    enabled: !!id // Don't fetch if no id
  });
}

// Create user mutation
export function useCreateUser() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (newUser: CreateUserDto) => {
      const { data } = await apiClient.post<User>('/api/v1/users', newUser);
      return data;
    },
    onSuccess: () => {
      // Invalidate and refetch user lists
      queryClient.invalidateQueries({ queryKey: userKeys.lists() });
    }
  });
}

// Update user with optimistic update
export function useUpdateUser() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({ id, updates }: { id: string; updates: UpdateUserDto }) => {
      const { data } = await apiClient.patch<User>(`/api/v1/users/${id}`, updates);
      return data;
    },
    onMutate: async ({ id, updates }) => {
      // Cancel outgoing refetches
      await queryClient.cancelQueries({ queryKey: userKeys.detail(id) });

      // Snapshot previous value
      const previousUser = queryClient.getQueryData<User>(userKeys.detail(id));

      // Optimistically update
      queryClient.setQueryData<User>(userKeys.detail(id), (old) => ({
        ...old!,
        ...updates
      }));

      return { previousUser };
    },
    onError: (err, { id }, context) => {
      // Rollback on error
      if (context?.previousUser) {
        queryClient.setQueryData(userKeys.detail(id), context.previousUser);
      }
    },
    onSettled: (data, error, { id }) => {
      // Refetch after mutation
      queryClient.invalidateQueries({ queryKey: userKeys.detail(id) });
    }
  });
}
```

### Component Usage

```tsx
// features/users/components/UserList.tsx
export function UserList() {
  const [filters, setFilters] = useState<UserFilters>({});
  const { data, isLoading, error, isFetching } = useUsers(filters);

  if (isLoading) {
    return <UserListSkeleton />;
  }

  if (error) {
    return <ErrorState error={error} onRetry={() => refetch()} />;
  }

  return (
    <div>
      {isFetching && <LoadingOverlay />}
      <UserFilters value={filters} onChange={setFilters} />
      <ul>
        {data?.users.map((user) => (
          <UserListItem key={user.id} user={user} />
        ))}
      </ul>
      <Pagination
        page={data?.meta.page ?? 1}
        totalPages={data?.meta.totalPages ?? 1}
        onChange={(page) => setFilters((f) => ({ ...f, page }))}
      />
    </div>
  );
}
```

## Best Practices

### Error Handling

```typescript
// Typed API errors
class ApiError extends Error {
  constructor(
    message: string,
    public status: number,
    public code: string,
    public details?: unknown
  ) {
    super(message);
  }
}

// Error boundary for queries
function QueryErrorBoundary({ children }: { children: React.ReactNode }) {
  return (
    <QueryErrorResetBoundary>
      {({ reset }) => (
        <ErrorBoundary onReset={reset} fallback={ErrorFallback}>
          {children}
        </ErrorBoundary>
      )}
    </QueryErrorResetBoundary>
  );
}

// Error component with retry
function ErrorFallback({ error, resetErrorBoundary }: FallbackProps) {
  return (
    <div role="alert">
      <p>Something went wrong:</p>
      <pre>{error.message}</pre>
      <button onClick={resetErrorBoundary}>Try again</button>
    </div>
  );
}
```

### Infinite Queries (Pagination)

```typescript
export function useInfiniteUsers() {
  return useInfiniteQuery({
    queryKey: userKeys.lists(),
    queryFn: async ({ pageParam = 1 }) => {
      const { data } = await apiClient.get<UsersResponse>('/api/v1/users', {
        params: { page: pageParam, limit: 20 }
      });
      return data;
    },
    getNextPageParam: (lastPage) =>
      lastPage.meta.page < lastPage.meta.totalPages
        ? lastPage.meta.page + 1
        : undefined,
    initialPageParam: 1
  });
}

// Usage with virtual list
function InfiniteUserList() {
  const { data, fetchNextPage, hasNextPage, isFetchingNextPage } = useInfiniteUsers();

  const allUsers = data?.pages.flatMap((page) => page.users) ?? [];

  return (
    <VirtualList
      items={allUsers}
      onEndReached={() => hasNextPage && fetchNextPage()}
      footer={isFetchingNextPage ? <LoadingSpinner /> : null}
    />
  );
}
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Fetching in useEffect | No caching, race conditions | Use React Query/SWR |
| Manual cache management | Error-prone, complex | Let query library handle |
| No loading states | Poor UX | Always show loading UI |
| Ignoring errors | Silent failures | Display error messages |
| Over-fetching | Performance waste | Use query keys, staleTime |

## Checklist

### API Integration
- [ ] Query keys factory defined
- [ ] Error handling implemented
- [ ] Loading states handled
- [ ] Caching strategy configured

### Data Fetching
- [ ] Appropriate staleTime set
- [ ] Retry logic configured
- [ ] Pagination implemented (if needed)
- [ ] Prefetching for critical paths

### Mutations
- [ ] Optimistic updates (if applicable)
- [ ] Cache invalidation on success
- [ ] Error rollback implemented
- [ ] Success/error toasts shown

## Integration

### Works With
- state-manager (client state)
- ui-component-architect (loading/error UI)
- architect-api-designer (API contracts)

### Output
- API client configuration
- Query hooks
- Mutation hooks
- Error handling utilities
