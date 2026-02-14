# Page Specification

> Template for documenting full page/view requirements
> Use this template when planning a new page with routing

## Page Overview

**Page Name**: `[PageName]Page`
**Route**: `/[route-path]`
**Purpose**: [Brief description of page purpose]
**Location**: `src/pages/[PageName]/` or `src/views/[PageName]/`

## Page Responsibilities

1. **[Responsibility 1]**: [e.g., Display user dashboard with statistics]
2. **[Responsibility 2]**: [e.g., Manage page-level state]
3. **[Responsibility 3]**: [e.g., Coordinate multiple child components]
4. **[Responsibility 4]**: [e.g., Handle routing and navigation]

## Routing Configuration

### Route Definition

**Path**: `/[path]`
**Parameters**: [None / `/:id` / `/:id/:subId`]
**Query Params**: [`?search`, `?page`, `?filter`]

**Example Route** (React Router):
```typescript
<Route path="/users/:id" element={<UserDetailPage />} />
```

**Example Route** (Angular):
```typescript
{
  path: 'users/:id',
  component: UserDetailPageComponent
}
```

### Route Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| id | number | Yes | User ID to display |
| tab | string | No | Active tab (profile/settings/activity) |

**Access Route Params** (React):
```typescript
import { useParams } from 'react-router-dom';

const { id, tab } = useParams<{ id: string; tab?: string }>();
```

**Access Route Params** (Angular):
```typescript
import { ActivatedRoute } from '@angular/router';

constructor(private route: ActivatedRoute) {}

ngOnInit(): void {
  const id = this.route.snapshot.paramMap.get('id');
  const tab = this.route.snapshot.queryParamMap.get('tab');
}
```

---

## Page Structure

### Layout

```
┌─────────────────────────────────────┐
│         Header/Navigation           │
├─────────────────────────────────────┤
│                                     │
│         Page Header                 │
│   (Title, Actions, Breadcrumbs)     │
│                                     │
├─────────────────────────────────────┤
│                                     │
│                                     │
│         Main Content                │
│   (Components, Sections)            │
│                                     │
│                                     │
├─────────────────────────────────────┤
│         Footer (optional)           │
└─────────────────────────────────────┘
```

### Sections

| Section | Components | Purpose |
|---------|------------|---------|
| Header | PageHeader, Breadcrumbs | Page title and navigation |
| Filters | FilterBar, SearchInput | Filter and search controls |
| Content | [ComponentList] | Main page content |
| Sidebar | [SidebarComponents] | Secondary content/navigation |

---

## Child Components

### Components Used

| Component | Purpose | Props |
|-----------|---------|-------|
| [Component1] | [Purpose] | [List of props] |
| [Component2] | [Purpose] | [List of props] |

**Example**:
| Component | Purpose | Props |
|-----------|---------|-------|
| UserList | Display list of users | users, loading, error, onUserSelect |
| UserCard | Display individual user | user, onClick |
| Pagination | Page navigation | currentPage, totalPages, onPageChange |

---

## State Management

### Page-Level State

| State Variable | Type | Initial Value | Purpose |
|----------------|------|---------------|---------|
| data | Type[] | [] | Main data for page |
| loading | boolean | true | Loading state |
| error | string \| null | null | Error message |
| currentPage | number | 1 | Pagination current page |
| filters | FilterType | {} | Active filters |

**Example State** (React):
```typescript
const [users, setUsers] = useState<User[]>([]);
const [loading, setLoading] = useState(true);
const [error, setError] = useState<string | null>(null);
const [currentPage, setCurrentPage] = useState(1);
const [searchTerm, setSearchTerm] = useState('');
```

### Global State (if needed)

**Redux/NgRx State**:
- User authentication state
- Application settings
- Cached data

**Example Redux** (React):
```typescript
import { useSelector, useDispatch } from 'react-redux';

const currentUser = useSelector((state: RootState) => state.auth.user);
const dispatch = useDispatch();
```

---

## Data Loading

### Initial Load

**Trigger**: Page mount / route navigation

**Data Sources**:
- API endpoint: `GET /api/[resources]`
- Query params for filtering/pagination

**Example** (React):
```typescript
useEffect(() => {
  loadPageData();
}, [currentPage, searchTerm]); // Reload when dependencies change

const loadPageData = async () => {
  try {
    setLoading(true);
    setError(null);
    const data = await UserService.getUsers({
      page: currentPage,
      search: searchTerm
    });
    setUsers(data);
  } catch (err) {
    setError('Failed to load users');
  } finally {
    setLoading(false);
  }
};
```

### Data Refresh

**Triggers**:
- User action (click refresh button)
- After create/update/delete operation
- Periodic auto-refresh (if applicable)

**Example**:
```typescript
const handleRefresh = () => {
  loadPageData();
};

const handleUserDeleted = async (userId: number) => {
  await UserService.deleteUser(userId);
  loadPageData(); // Refresh list after deletion
};
```

---

## Page Actions

### Primary Actions

| Action | Handler | API Call | Success Behavior |
|--------|---------|----------|------------------|
| Create | handleCreate | POST /api/[resources] | Redirect to detail page |
| Edit | handleEdit | PUT /api/[resources]/{id} | Update UI, show toast |
| Delete | handleDelete | DELETE /api/[resources]/{id} | Remove from list, refresh |

**Example Actions** (React):
```typescript
const handleCreate = async (data: UserCreateRequest) => {
  try {
    const newUser = await UserService.createUser(data);
    navigate(`/users/${newUser.id}`); // Redirect to detail page
  } catch (err) {
    setError('Failed to create user');
  }
};

const handleDelete = async (userId: number) => {
  if (!confirm('Are you sure you want to delete this user?')) {
    return;
  }

  try {
    await UserService.deleteUser(userId);
    loadPageData(); // Refresh list
  } catch (err) {
    setError('Failed to delete user');
  }
};
```

### Secondary Actions

| Action | Handler | Effect |
|--------|---------|--------|
| Filter | handleFilter | Update filters, reload data |
| Search | handleSearch | Update search term, reload data |
| Sort | handleSort | Update sort order, reload data |
| Export | handleExport | Download data as CSV/PDF |

---

## Page Navigation

### Breadcrumbs

**Example Path**: Home > Users > User Detail

```typescript
const breadcrumbs = [
  { label: 'Home', path: '/' },
  { label: 'Users', path: '/users' },
  { label: user?.name || 'Loading...', path: `/users/${id}` }
];
```

### Navigation Between Pages

**From list to detail**:
```typescript
const handleUserClick = (user: User) => {
  navigate(`/users/${user.id}`);
};
```

**Back to list**:
```typescript
const handleBack = () => {
  navigate('/users');
};
```

---

## Query Parameters

### URL State Management

| Query Param | Type | Default | Purpose |
|-------------|------|---------|---------|
| page | number | 1 | Current page number |
| search | string | '' | Search term |
| filter | string | 'all' | Active filter |

**Read/Write Query Params** (React):
```typescript
import { useSearchParams } from 'react-router-dom';

const [searchParams, setSearchParams] = useSearchParams();

// Read
const page = Number(searchParams.get('page')) || 1;
const search = searchParams.get('search') || '';

// Write
const updatePage = (newPage: number) => {
  setSearchParams({ page: String(newPage), search });
};
```

**Why Use Query Params**:
- Shareable URLs (users can bookmark filtered views)
- Browser back/forward works correctly
- Persistent state across page refreshes

---

## Page UI States

### Loading State

**Display**: Full-page skeleton loader

```typescript
if (loading && !users.length) {
  return <PageSkeleton />;
}
```

### Error State

**Display**: Error message with retry button

```typescript
if (error && !users.length) {
  return (
    <ErrorPage
      message={error}
      onRetry={loadPageData}
    />
  );
}
```

### Empty State

**Display**: Empty state with call-to-action

```typescript
if (!loading && users.length === 0) {
  return (
    <EmptyState
      title="No users found"
      message="Get started by creating your first user"
      action={<Button onClick={openCreateModal}>Create User</Button>}
    />
  );
}
```

### Success State

**Display**: Normal page content

```typescript
return (
  <PageContainer>
    <PageHeader title="Users" actions={<CreateButton />} />
    <FilterBar onFilterChange={handleFilterChange} />
    <UserList users={users} onUserClick={handleUserClick} />
    <Pagination page={currentPage} totalPages={totalPages} onChange={setCurrentPage} />
  </PageContainer>
);
```

---

## Full Page Template (React)

```typescript
import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, useSearchParams } from 'react-router-dom';
import { [Type] } from '../../types/[Type]';
import { [Service] } from '../../services/[Service]';
import { PageContainer } from '../../components/layout/PageContainer';
import { PageHeader } from '../../components/layout/PageHeader';
import { [ChildComponent] } from '../../components/[ChildComponent]';
import styles from './[PageName]Page.module.css';

export const [PageName]Page: React.FC = () => {
  // Router hooks
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();

  // State
  const [data, setData] = useState<Type[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Query params
  const currentPage = Number(searchParams.get('page')) || 1;
  const searchTerm = searchParams.get('search') || '';

  // Effects
  useEffect(() => {
    loadData();
  }, [currentPage, searchTerm]);

  // Data loading
  const loadData = async () => {
    try {
      setLoading(true);
      setError(null);
      const result = await Service.getData({ page: currentPage, search: searchTerm });
      setData(result);
    } catch (err) {
      setError('Failed to load data');
    } finally {
      setLoading(false);
    }
  };

  // Event handlers
  const handleItemClick = (item: Type) => {
    navigate(`/[path]/${item.id}`);
  };

  const handlePageChange = (page: number) => {
    setSearchParams({ page: String(page), search: searchTerm });
  };

  // Render states
  if (loading && !data.length) {
    return <div className={styles.loading}>Loading...</div>;
  }

  if (error && !data.length) {
    return (
      <div className={styles.error}>
        <p>{error}</p>
        <button onClick={loadData}>Retry</button>
      </div>
    );
  }

  if (!loading && data.length === 0) {
    return <div className={styles.empty}>No items found</div>;
  }

  // Render
  return (
    <PageContainer>
      <PageHeader title="[Page Title]" />
      <div className={styles.content}>
        <[ChildComponent]
          items={data}
          onItemClick={handleItemClick}
        />
      </div>
    </PageContainer>
  );
};
```

---

## Full Page Template (Angular)

```typescript
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { [Type] } from '../../models/[type].model';
import { [Service] } from '../../services/[service].service';

@Component({
  selector: 'app-[page-name]',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './[page-name].component.html',
  styleUrls: ['./[page-name].component.css']
})
export class [PageName]Component implements OnInit {
  data: Type[] = [];
  loading = true;
  error: string | null = null;

  currentPage = 1;
  searchTerm = '';

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private service: [Service]
  ) {}

  ngOnInit(): void {
    // Read query params
    this.route.queryParamMap.subscribe(params => {
      this.currentPage = Number(params.get('page')) || 1;
      this.searchTerm = params.get('search') || '';
      this.loadData();
    });
  }

  async loadData(): Promise<void> {
    try {
      this.loading = true;
      this.error = null;
      this.data = await this.service.getData({
        page: this.currentPage,
        search: this.searchTerm
      });
    } catch (err) {
      this.error = 'Failed to load data';
    } finally {
      this.loading = false;
    }
  }

  handleItemClick(item: Type): void {
    this.router.navigate(['/[path]', item.id]);
  }

  handlePageChange(page: number): void {
    this.router.navigate([], {
      queryParams: { page, search: this.searchTerm }
    });
  }
}
```

---

## Testing Requirements

### Page Tests

**Test Cases**:
| Test | Purpose |
|------|---------|
| Renders with route params | Verify page loads with URL parameters |
| Loads data on mount | Verify API called on page load |
| Updates data on query param change | Verify reload when page/search changes |
| Navigates to detail page | Verify click navigates correctly |
| Handles errors | Verify error message shown on API failure |

**Example Test** (React):
```typescript
import { render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import { [PageName]Page } from './[PageName]Page';
import { [Service] } from '../../services/[Service]';

jest.mock('../../services/[Service]');

describe('[PageName]Page', () => {
  it('loads data on mount', async () => {
    const mockData = [{ id: 1, name: 'Item 1' }];
    (Service.getData as jest.Mock).mockResolvedValue(mockData);

    render(
      <MemoryRouter initialEntries={['/[path]']}>
        <Routes>
          <Route path="/[path]" element={<[PageName]Page />} />
        </Routes>
      </MemoryRouter>
    );

    await waitFor(() => {
      expect(screen.getByText('Item 1')).toBeInTheDocument();
    });
  });

  it('reads query parameters', async () => {
    (Service.getData as jest.Mock).mockResolvedValue([]);

    render(
      <MemoryRouter initialEntries={['/[path]?page=2&search=test']}>
        <Routes>
          <Route path="/[path]" element={<[PageName]Page />} />
        </Routes>
      </MemoryRouter>
    );

    await waitFor(() => {
      expect(Service.getData).toHaveBeenCalledWith({
        page: 2,
        search: 'test'
      });
    });
  });
});
```

---

## Implementation Checklist

**Setup**:
- [ ] Create page file ([PageName]Page.tsx/.ts)
- [ ] Create styles file ([PageName]Page.module.css/.css)
- [ ] Create test file ([PageName]Page.test.tsx/.spec.ts)
- [ ] Configure routing

**State Management**:
- [ ] Define page-level state
- [ ] Implement URL query param management
- [ ] Connect to global state (if needed)

**Data Loading**:
- [ ] Implement initial data load
- [ ] Implement data refresh on filter/page change
- [ ] Handle loading state
- [ ] Handle error state

**Page Structure**:
- [ ] Implement page header
- [ ] Implement breadcrumbs/navigation
- [ ] Implement main content area
- [ ] Implement child components integration

**User Actions**:
- [ ] Implement create/edit/delete actions
- [ ] Implement filter/search/sort
- [ ] Implement pagination
- [ ] Implement navigation

**Testing**:
- [ ] Test data loading
- [ ] Test query param handling
- [ ] Test navigation
- [ ] Test user actions
- [ ] Coverage ≥80%

---

## Notes

- Keep pages focused on coordination, not complex logic
- Extract complex logic to custom hooks/services
- Use URL query params for shareable state
- Handle all page states (loading, error, empty, success)
- Implement breadcrumbs for navigation context
- Test with different route parameters
