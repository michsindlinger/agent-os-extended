# State Management Specification

> Template for documenting state management approach
> Use this template when planning application-wide state

## State Management Overview

**Approach**: [Context API / Redux / NgRx / Zustand / Service-based]
**Scope**: [Global application state / Feature-specific state]
**Purpose**: [Brief description of what state is managed]

## State Structure

### Global State Shape

```typescript
interface AppState {
  auth: AuthState;
  users: UsersState;
  ui: UIState;
}

interface AuthState {
  currentUser: User | null;
  isAuthenticated: boolean;
  loading: boolean;
}

interface UsersState {
  list: User[];
  selectedId: number | null;
  loading: boolean;
  error: string | null;
}

interface UIState {
  theme: 'light' | 'dark';
  sidebarOpen: boolean;
}
```

---

## Context API (React)

### Context Creation

```typescript
// contexts/AuthContext.tsx
import React, { createContext, useContext, useState, ReactNode } from 'react';
import { User } from '../types/User';

interface AuthContextType {
  currentUser: User | null;
  isAuthenticated: boolean;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [currentUser, setCurrentUser] = useState<User | null>(null);

  const login = async (email: string, password: string) => {
    // API call to login
    const user = await AuthService.login(email, password);
    setCurrentUser(user);
  };

  const logout = () => {
    setCurrentUser(null);
  };

  const value = {
    currentUser,
    isAuthenticated: currentUser !== null,
    login,
    logout
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
};
```

### Usage in Components

```typescript
import { useAuth } from '../contexts/AuthContext';

const UserProfile: React.FC = () => {
  const { currentUser, logout } = useAuth();

  if (!currentUser) {
    return <div>Not authenticated</div>;
  }

  return (
    <div>
      <h2>{currentUser.name}</h2>
      <button onClick={logout}>Logout</button>
    </div>
  );
};
```

---

## Redux (React)

### Store Setup

```typescript
// store/index.ts
import { configureStore } from '@reduxjs/toolkit';
import authReducer from './slices/authSlice';
import usersReducer from './slices/usersSlice';

export const store = configureStore({
  reducer: {
    auth: authReducer,
    users: usersReducer
  }
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
```

### Slice Definition

```typescript
// store/slices/usersSlice.ts
import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';
import { User } from '../../types/User';
import { UserService } from '../../services/UserService';

interface UsersState {
  list: User[];
  loading: boolean;
  error: string | null;
}

const initialState: UsersState = {
  list: [],
  loading: false,
  error: null
};

// Async thunk for fetching users
export const fetchUsers = createAsyncThunk(
  'users/fetchUsers',
  async () => {
    const users = await UserService.getUsers();
    return users;
  }
);

const usersSlice = createSlice({
  name: 'users',
  initialState,
  reducers: {
    addUser: (state, action: PayloadAction<User>) => {
      state.list.push(action.payload);
    },
    removeUser: (state, action: PayloadAction<number>) => {
      state.list = state.list.filter(user => user.id !== action.payload);
    }
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchUsers.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(fetchUsers.fulfilled, (state, action) => {
        state.loading = false;
        state.list = action.payload;
      })
      .addCase(fetchUsers.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message || 'Failed to fetch users';
      });
  }
});

export const { addUser, removeUser } = usersSlice.actions;
export default usersSlice.reducer;
```

### Usage in Components

```typescript
import { useSelector, useDispatch } from 'react-redux';
import { RootState, AppDispatch } from '../store';
import { fetchUsers, addUser } from '../store/slices/usersSlice';

const UserList: React.FC = () => {
  const dispatch = useDispatch<AppDispatch>();
  const { list, loading, error } = useSelector((state: RootState) => state.users);

  useEffect(() => {
    dispatch(fetchUsers());
  }, [dispatch]);

  const handleAddUser = (user: User) => {
    dispatch(addUser(user));
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <div>
      {list.map(user => (
        <div key={user.id}>{user.name}</div>
      ))}
    </div>
  );
};
```

---

## NgRx (Angular)

### State Interface

```typescript
// store/state/app.state.ts
import { UsersState } from './users.state';
import { AuthState } from './auth.state';

export interface AppState {
  auth: AuthState;
  users: UsersState;
}
```

### Actions

```typescript
// store/actions/users.actions.ts
import { createAction, props } from '@ngrx/store';
import { User } from '../../models/user.model';

export const loadUsers = createAction('[Users] Load Users');

export const loadUsersSuccess = createAction(
  '[Users] Load Users Success',
  props<{ users: User[] }>()
);

export const loadUsersFailure = createAction(
  '[Users] Load Users Failure',
  props<{ error: string }>()
);

export const addUser = createAction(
  '[Users] Add User',
  props<{ user: User }>()
);
```

### Reducer

```typescript
// store/reducers/users.reducer.ts
import { createReducer, on } from '@ngrx/store';
import * as UsersActions from '../actions/users.actions';
import { User } from '../../models/user.model';

export interface UsersState {
  list: User[];
  loading: boolean;
  error: string | null;
}

export const initialState: UsersState = {
  list: [],
  loading: false,
  error: null
};

export const usersReducer = createReducer(
  initialState,
  on(UsersActions.loadUsers, state => ({
    ...state,
    loading: true,
    error: null
  })),
  on(UsersActions.loadUsersSuccess, (state, { users }) => ({
    ...state,
    loading: false,
    list: users
  })),
  on(UsersActions.loadUsersFailure, (state, { error }) => ({
    ...state,
    loading: false,
    error
  })),
  on(UsersActions.addUser, (state, { user }) => ({
    ...state,
    list: [...state.list, user]
  }))
);
```

### Effects

```typescript
// store/effects/users.effects.ts
import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { of } from 'rxjs';
import { map, mergeMap, catchError } from 'rxjs/operators';
import { UserService } from '../../services/user.service';
import * as UsersActions from '../actions/users.actions';

@Injectable()
export class UsersEffects {
  loadUsers$ = createEffect(() =>
    this.actions$.pipe(
      ofType(UsersActions.loadUsers),
      mergeMap(() =>
        this.userService.getUsers().pipe(
          map(users => UsersActions.loadUsersSuccess({ users })),
          catchError(error => of(UsersActions.loadUsersFailure({ error: error.message })))
        )
      )
    )
  );

  constructor(
    private actions$: Actions,
    private userService: UserService
  ) {}
}
```

### Selectors

```typescript
// store/selectors/users.selectors.ts
import { createSelector, createFeatureSelector } from '@ngrx/store';
import { UsersState } from '../reducers/users.reducer';

export const selectUsersState = createFeatureSelector<UsersState>('users');

export const selectAllUsers = createSelector(
  selectUsersState,
  (state: UsersState) => state.list
);

export const selectUsersLoading = createSelector(
  selectUsersState,
  (state: UsersState) => state.loading
);

export const selectUsersError = createSelector(
  selectUsersState,
  (state: UsersState) => state.error
);
```

### Usage in Components

```typescript
import { Component, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { AppState } from '../store/state/app.state';
import * as UsersActions from '../store/actions/users.actions';
import * as UsersSelectors from '../store/selectors/users.selectors';
import { User } from '../models/user.model';

@Component({
  selector: 'app-user-list',
  template: `
    <div *ngIf="loading$ | async">Loading...</div>
    <div *ngIf="error$ | async as error">Error: {{ error }}</div>
    <div *ngFor="let user of users$ | async">{{ user.name }}</div>
  `
})
export class UserListComponent implements OnInit {
  users$: Observable<User[]>;
  loading$: Observable<boolean>;
  error$: Observable<string | null>;

  constructor(private store: Store<AppState>) {
    this.users$ = this.store.select(UsersSelectors.selectAllUsers);
    this.loading$ = this.store.select(UsersSelectors.selectUsersLoading);
    this.error$ = this.store.select(UsersSelectors.selectUsersError);
  }

  ngOnInit(): void {
    this.store.dispatch(UsersActions.loadUsers());
  }

  handleAddUser(user: User): void {
    this.store.dispatch(UsersActions.addUser({ user }));
  }
}
```

---

## Service-Based State (Angular - Simpler Alternative)

```typescript
// services/user-state.service.ts
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { User } from '../models/user.model';
import { UserService } from './user.service';

@Injectable({
  providedIn: 'root'
})
export class UserStateService {
  private usersSubject = new BehaviorSubject<User[]>([]);
  private loadingSubject = new BehaviorSubject<boolean>(false);
  private errorSubject = new BehaviorSubject<string | null>(null);

  users$: Observable<User[]> = this.usersSubject.asObservable();
  loading$: Observable<boolean> = this.loadingSubject.asObservable();
  error$: Observable<string | null> = this.errorSubject.asObservable();

  constructor(private userService: UserService) {}

  async loadUsers(): Promise<void> {
    try {
      this.loadingSubject.next(true);
      this.errorSubject.next(null);
      const users = await this.userService.getUsers();
      this.usersSubject.next(users);
    } catch (error) {
      this.errorSubject.next('Failed to load users');
    } finally {
      this.loadingSubject.next(false);
    }
  }

  addUser(user: User): void {
    const currentUsers = this.usersSubject.value;
    this.usersSubject.next([...currentUsers, user]);
  }

  removeUser(userId: number): void {
    const currentUsers = this.usersSubject.value;
    this.usersSubject.next(currentUsers.filter(u => u.id !== userId));
  }
}
```

---

## State Management Best Practices

### When to Use Global State

**Use Global State For**:
- User authentication status
- Application theme/settings
- Cached data used across multiple pages
- Real-time notifications

**Use Local State For**:
- Form inputs
- UI toggles (modals, dropdowns)
- Page-specific data
- Temporary filters/search

### Performance Considerations

**Avoid Over-Rendering**:
```typescript
// ✅ Good: Select only what you need
const userName = useSelector((state: RootState) => state.auth.currentUser?.name);

// ❌ Bad: Select entire state (causes re-render on any state change)
const state = useSelector((state: RootState) => state);
```

**Memoize Selectors** (Redux):
```typescript
import { createSelector } from '@reduxjs/toolkit';

const selectUsers = (state: RootState) => state.users.list;
const selectSearchTerm = (state: RootState) => state.users.searchTerm;

const selectFilteredUsers = createSelector(
  [selectUsers, selectSearchTerm],
  (users, searchTerm) => {
    return users.filter(user =>
      user.name.toLowerCase().includes(searchTerm.toLowerCase())
    );
  }
);
```

### Testing State Management

**Test Reducers**:
```typescript
describe('usersReducer', () => {
  it('handles loadUsersSuccess', () => {
    const users = [{ id: 1, name: 'Alice' }];
    const action = loadUsersSuccess({ users });
    const state = usersReducer(initialState, action);

    expect(state.loading).toBe(false);
    expect(state.list).toEqual(users);
  });
});
```

**Test Selectors**:
```typescript
describe('selectAllUsers', () => {
  it('returns user list from state', () => {
    const state: RootState = {
      users: { list: [{ id: 1, name: 'Alice' }], loading: false, error: null }
    };

    const result = selectAllUsers(state);
    expect(result).toEqual([{ id: 1, name: 'Alice' }]);
  });
});
```

---

## Implementation Checklist

**Setup**:
- [ ] Choose state management approach
- [ ] Configure store/context
- [ ] Define state interfaces

**State Structure**:
- [ ] Define global state shape
- [ ] Create actions/reducers (Redux/NgRx)
- [ ] Create selectors
- [ ] Create effects (for async operations)

**Integration**:
- [ ] Wrap app with Provider/Store
- [ ] Connect components to state
- [ ] Implement data loading
- [ ] Implement state updates

**Testing**:
- [ ] Test reducers
- [ ] Test selectors
- [ ] Test effects
- [ ] Test component integration

---

## Notes

- Use Context API for simple global state (auth, theme)
- Use Redux/NgRx for complex state with many updates
- Keep state normalized (avoid nested objects)
- Use selectors to derive computed values
- Test state logic independently from UI
