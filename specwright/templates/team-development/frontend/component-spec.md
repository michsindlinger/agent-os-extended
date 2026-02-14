# Component Specification

> Template for documenting React/Angular component requirements
> Use this template when planning a new UI component

## Component Overview

**Component Name**: `[ComponentName]`
**Type**: [Presentational / Container / Form / Layout]
**Purpose**: [Brief description of component responsibility]
**Location**: `src/components/[ComponentName]/`

## Component Responsibilities

1. **[Responsibility 1]**: [e.g., Display list of items]
2. **[Responsibility 2]**: [e.g., Handle user interactions]
3. **[Responsibility 3]**: [e.g., Manage local state]
4. **[Responsibility 4]**: [e.g., Call API service]

## Props Interface (React) / Input Properties (Angular)

### Required Props

| Prop | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| prop1 | string | Yes | - | Description of prop1 |
| prop2 | number | Yes | - | Description of prop2 |

### Optional Props

| Prop | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| onAction | (item: Type) => void | No | - | Callback when action occurs |
| className | string | No | '' | Additional CSS classes |
| initialValue | string | No | '' | Initial input value |

**Example Props Interface** (React):
```typescript
interface UserListProps {
  users: User[];                        // Required: Array of users to display
  loading?: boolean;                    // Optional: Loading state
  error?: string | null;                // Optional: Error message
  onUserSelect?: (user: User) => void;  // Optional: Called when user clicked
  className?: string;                   // Optional: Custom CSS class
}
```

**Example Input Properties** (Angular):
```typescript
@Component({
  selector: 'app-user-list',
  // ...
})
export class UserListComponent {
  @Input() users: User[] = [];
  @Input() loading = false;
  @Input() error: string | null = null;
  @Output() userSelect = new EventEmitter<User>();
}
```

---

## State Management

### Local State (React useState / Angular component state)

| State Variable | Type | Initial Value | Purpose |
|----------------|------|---------------|---------|
| searchTerm | string | '' | Filter/search input value |
| selectedId | number \| null | null | Currently selected item |
| isOpen | boolean | false | Modal/dropdown open state |

**Example State** (React):
```typescript
const [searchTerm, setSearchTerm] = useState<string>('');
const [selectedId, setSelectedId] = useState<number | null>(null);
const [isOpen, setIsOpen] = useState<boolean>(false);
```

**Example State** (Angular):
```typescript
searchTerm = '';
selectedId: number | null = null;
isOpen = false;
```

### Computed/Derived State

| Computed Value | Type | Depends On | Purpose |
|----------------|------|------------|---------|
| filteredItems | Item[] | items, searchTerm | Filtered list based on search |
| hasSelection | boolean | selectedId | Whether any item is selected |

**Example Computed** (React):
```typescript
const filteredUsers = useMemo(() => {
  return users.filter(user =>
    user.name.toLowerCase().includes(searchTerm.toLowerCase())
  );
}, [users, searchTerm]);

const hasSelection = selectedId !== null;
```

**Example Computed** (Angular):
```typescript
get filteredUsers(): User[] {
  return this.users.filter(user =>
    user.name.toLowerCase().includes(this.searchTerm.toLowerCase())
  );
}

get hasSelection(): boolean {
  return this.selectedId !== null;
}
```

---

## Event Handlers

### User Interactions

| Event | Handler | Parameters | Action |
|-------|---------|------------|--------|
| Click item | handleItemClick | item: Item | Call onItemSelect callback |
| Change search | handleSearchChange | event: ChangeEvent | Update searchTerm state |
| Submit form | handleSubmit | event: FormEvent | Validate and call onSubmit |

**Example Handlers** (React):
```typescript
const handleUserClick = (user: User) => {
  setSelectedId(user.id);
  onUserSelect?.(user);
};

const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
  setSearchTerm(event.target.value);
};
```

**Example Handlers** (Angular):
```typescript
handleUserClick(user: User): void {
  this.selectedId = user.id;
  this.userSelect.emit(user);
}

handleSearchChange(event: Event): void {
  this.searchTerm = (event.target as HTMLInputElement).value;
}
```

---

## Side Effects

### React useEffect / Angular Lifecycle

| Effect | Trigger | Purpose | Cleanup |
|--------|---------|---------|---------|
| Load data | Component mount | Fetch data from API | - |
| Subscribe | Component mount | Subscribe to observable | Unsubscribe |
| Update title | selectedId change | Update page title | - |

**Example Effects** (React):
```typescript
useEffect(() => {
  loadUsers();
}, []); // Run once on mount

useEffect(() => {
  if (selectedId) {
    document.title = `User ${selectedId}`;
  }
}, [selectedId]); // Run when selectedId changes
```

**Example Lifecycle** (Angular):
```typescript
ngOnInit(): void {
  this.loadUsers();
}

ngOnChanges(changes: SimpleChanges): void {
  if (changes['selectedId']) {
    document.title = `User ${this.selectedId}`;
  }
}

ngOnDestroy(): void {
  // Cleanup subscriptions
}
```

---

## API Integration

### Services/Hooks Used

| Service/Hook | Method | Purpose |
|--------------|--------|---------|
| UserService | getUsers() | Fetch all users |
| UserService | createUser(data) | Create new user |
| useUsers hook | - | Manage user list state (React) |

**Example API Usage** (React):
```typescript
const [users, setUsers] = useState<User[]>([]);
const [loading, setLoading] = useState(true);
const [error, setError] = useState<string | null>(null);

useEffect(() => {
  const loadUsers = async () => {
    try {
      setLoading(true);
      const data = await UserService.getUsers();
      setUsers(data);
    } catch (err) {
      setError('Failed to load users');
    } finally {
      setLoading(false);
    }
  };

  loadUsers();
}, []);
```

**Example API Usage** (Angular):
```typescript
users: User[] = [];
loading = true;
error: string | null = null;

constructor(private userService: UserService) {}

ngOnInit(): void {
  this.loadUsers();
}

async loadUsers(): Promise<void> {
  try {
    this.loading = true;
    this.error = null;
    this.users = await this.userService.getUsers();
  } catch (err) {
    this.error = 'Failed to load users';
  } finally {
    this.loading = false;
  }
}
```

---

## UI States

### Loading State

**Display**: Skeleton loader or spinner

**Condition**: `loading === true`

**Example**:
```typescript
if (loading) {
  return <div className="loading">Loading...</div>;
}
```

### Error State

**Display**: Error message with retry button

**Condition**: `error !== null`

**Example**:
```typescript
if (error) {
  return (
    <div className="error">
      <p>{error}</p>
      <button onClick={retry}>Retry</button>
    </div>
  );
}
```

### Empty State

**Display**: "No items found" message

**Condition**: `items.length === 0 && !loading && !error`

**Example**:
```typescript
if (filteredUsers.length === 0) {
  return <div className="empty">No users found</div>;
}
```

### Success State

**Display**: Normal component UI

**Condition**: `!loading && !error && items.length > 0`

---

## Accessibility Requirements

| Requirement | Implementation | ARIA Attribute |
|-------------|----------------|----------------|
| Keyboard navigation | Focus management, Tab order | tabIndex, onKeyDown |
| Screen reader support | Semantic HTML, labels | aria-label, aria-describedby |
| Focus indicators | Visible focus styles | :focus-visible CSS |
| Error announcements | Announce errors to screen readers | aria-live="polite" |

**Example Accessibility**:
```typescript
<button
  onClick={handleClick}
  aria-label="Delete user"
  aria-describedby="delete-help"
>
  Delete
</button>
<span id="delete-help" className="sr-only">
  This action cannot be undone
</span>
```

---

## Styling Approach

**Method**: [CSS Modules / styled-components / Tailwind CSS / Angular Material]

**File**: `[ComponentName].module.css` or `[ComponentName].component.css`

**Key Classes**:
| Class | Purpose |
|-------|---------|
| .container | Main component wrapper |
| .header | Component header section |
| .content | Main content area |
| .footer | Component footer section |
| .error | Error message styling |
| .loading | Loading state styling |

**Example Styles** (CSS Modules):
```css
.container {
  padding: 1rem;
  border: 1px solid #ddd;
  border-radius: 0.5rem;
}

.header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 1rem;
}

.error {
  color: #c00;
  padding: 0.5rem;
  background: #fee;
  border-radius: 0.25rem;
}
```

---

## Component Structure (React)

**File**: `src/components/[ComponentName]/[ComponentName].tsx`

```typescript
import React, { useState, useEffect } from 'react';
import { [Type] } from '../../types/[Type]';
import { [Service] } from '../../services/[Service]';
import styles from './[ComponentName].module.css';

interface [ComponentName]Props {
  prop1: string;
  prop2?: number;
  onAction?: (item: Type) => void;
}

export const [ComponentName]: React.FC<[ComponentName]Props> = ({
  prop1,
  prop2 = 0,
  onAction
}) => {
  // State
  const [state, setState] = useState<Type[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Effects
  useEffect(() => {
    loadData();
  }, []);

  // Event handlers
  const handleClick = (item: Type) => {
    onAction?.(item);
  };

  // API calls
  const loadData = async () => {
    try {
      setLoading(true);
      const data = await Service.getData();
      setState(data);
    } catch (err) {
      setError('Failed to load data');
    } finally {
      setLoading(false);
    }
  };

  // Render states
  if (loading) return <div className={styles.loading}>Loading...</div>;
  if (error) return <div className={styles.error}>{error}</div>;

  // Render
  return (
    <div className={styles.container}>
      <h2>{prop1}</h2>
      {/* Component content */}
    </div>
  );
};
```

---

## Component Structure (Angular)

**File**: `src/app/components/[component-name]/[component-name].component.ts`

```typescript
import { Component, Input, Output, EventEmitter, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { [Type] } from '../../models/[type].model';
import { [Service] } from '../../services/[service].service';

@Component({
  selector: 'app-[component-name]',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './[component-name].component.html',
  styleUrls: ['./[component-name].component.css']
})
export class [ComponentName]Component implements OnInit {
  @Input() prop1!: string;
  @Input() prop2 = 0;
  @Output() action = new EventEmitter<Type>();

  // State
  items: Type[] = [];
  loading = true;
  error: string | null = null;

  constructor(private service: [Service]) {}

  ngOnInit(): void {
    this.loadData();
  }

  handleClick(item: Type): void {
    this.action.emit(item);
  }

  async loadData(): Promise<void> {
    try {
      this.loading = true;
      this.error = null;
      this.items = await this.service.getData();
    } catch (err) {
      this.error = 'Failed to load data';
    } finally {
      this.loading = false;
    }
  }
}
```

---

## Testing Requirements

### Component Tests

**Framework**: React Testing Library / Angular Testing Library

**Test Cases**:
| Test | Purpose |
|------|---------|
| Renders with props | Verify component renders with provided props |
| Loading state | Verify loading indicator shown initially |
| Error state | Verify error message shown on failure |
| Empty state | Verify empty message when no items |
| User interaction | Verify click handlers called correctly |
| Accessibility | Verify keyboard navigation, ARIA attributes |

**Example Test** (React Testing Library):
```typescript
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { [ComponentName] } from './[ComponentName]';
import { [Service] } from '../../services/[Service]';

jest.mock('../../services/[Service]');

describe('[ComponentName]', () => {
  it('renders loading state initially', () => {
    (Service.getData as jest.Mock).mockImplementation(
      () => new Promise(() => {})
    );

    render(<[ComponentName] prop1="test" />);
    expect(screen.getByText('Loading...')).toBeInTheDocument();
  });

  it('renders items after loading', async () => {
    const mockData = [{ id: 1, name: 'Item 1' }];
    (Service.getData as jest.Mock).mockResolvedValue(mockData);

    render(<[ComponentName] prop1="test" />);

    await waitFor(() => {
      expect(screen.getByText('Item 1')).toBeInTheDocument();
    });
  });

  it('calls onAction when item clicked', async () => {
    const mockData = [{ id: 1, name: 'Item 1' }];
    (Service.getData as jest.Mock).mockResolvedValue(mockData);
    const handleAction = jest.fn();

    render(<[ComponentName] prop1="test" onAction={handleAction} />);

    await waitFor(() => {
      expect(screen.getByText('Item 1')).toBeInTheDocument();
    });

    await userEvent.click(screen.getByText('Item 1'));
    expect(handleAction).toHaveBeenCalledWith(mockData[0]);
  });
});
```

**Coverage Target**: ≥80%

---

## Implementation Checklist

**Setup**:
- [ ] Create component file ([ComponentName].tsx/.ts)
- [ ] Create styles file ([ComponentName].module.css/.css)
- [ ] Create test file ([ComponentName].test.tsx/.spec.ts)
- [ ] Define Props/Input interface

**State Management**:
- [ ] Define local state variables
- [ ] Define computed/derived values
- [ ] Implement event handlers

**API Integration**:
- [ ] Import service/hook
- [ ] Implement data loading
- [ ] Handle loading state
- [ ] Handle error state

**UI Implementation**:
- [ ] Implement loading state UI
- [ ] Implement error state UI
- [ ] Implement empty state UI
- [ ] Implement success state UI

**Accessibility**:
- [ ] Semantic HTML elements
- [ ] Keyboard navigation support
- [ ] ARIA attributes where needed
- [ ] Focus management

**Testing**:
- [ ] Test renders with props
- [ ] Test loading state
- [ ] Test error state
- [ ] Test user interactions
- [ ] Test accessibility
- [ ] Coverage ≥80%

**Styling**:
- [ ] Component styles complete
- [ ] Responsive design (mobile, tablet, desktop)
- [ ] Dark mode support (if applicable)
- [ ] Consistent with design system

---

## Notes

- Use functional components (React) or standalone components (Angular)
- Follow framework-specific best practices
- Keep components focused and single-responsibility
- Extract complex logic to custom hooks (React) or services (Angular)
- Handle all UI states (loading, error, empty, success)
- Test user behavior, not implementation details
