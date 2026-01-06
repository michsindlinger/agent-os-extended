---
name: state-manager
description: Implements state management patterns and data flow
version: 1.0
---

# State Manager

Designs and implements application state management using appropriate patterns (Context, Redux, Zustand, Signals) based on complexity and requirements.

## Trigger Conditions

```yaml
task_mentions:
  - "state|store|context"
  - "redux|zustand|mobx|recoil"
  - "global state|local state"
  - "data flow|state machine"
file_extension:
  - .tsx
  - .ts
file_contains:
  - "createContext"
  - "useReducer"
  - "create("
  - "configureStore"
always_active_for_agents:
  - frontend-agent
```

## When to Load

- Implementing state management
- Refactoring data flow
- Adding global/shared state
- Optimizing re-renders

## Core Competencies

### State Management Decision Tree

```
┌─────────────────────────────────────────────────┐
│            How complex is the state?            │
└─────────────────────┬───────────────────────────┘
                      │
        ┌─────────────┴─────────────┐
        │                           │
   Simple (2-3 values)        Complex (many values)
        │                           │
        ▼                           ▼
┌───────────────┐         ┌─────────────────┐
│   useState    │         │ Is state shared │
│   useReducer  │         │ across pages?   │
└───────────────┘         └────────┬────────┘
                                   │
                     ┌─────────────┴─────────────┐
                     │                           │
                  No (local)               Yes (global)
                     │                           │
                     ▼                           ▼
              ┌──────────────┐          ┌──────────────────┐
              │ React Context │         │ Zustand / Redux  │
              └──────────────┘          │ / Jotai          │
                                        └──────────────────┘
```

### React Context (Simple Global State)

```tsx
// contexts/AuthContext.tsx
interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  isLoading: boolean;
}

interface AuthContextValue extends AuthState {
  login: (credentials: Credentials) => Promise<void>;
  logout: () => Promise<void>;
  refreshToken: () => Promise<void>;
}

const AuthContext = createContext<AuthContextValue | null>(null);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [state, setState] = useState<AuthState>({
    user: null,
    isAuthenticated: false,
    isLoading: true
  });

  const login = useCallback(async (credentials: Credentials) => {
    setState(prev => ({ ...prev, isLoading: true }));
    try {
      const user = await authService.login(credentials);
      setState({ user, isAuthenticated: true, isLoading: false });
    } catch (error) {
      setState({ user: null, isAuthenticated: false, isLoading: false });
      throw error;
    }
  }, []);

  const logout = useCallback(async () => {
    await authService.logout();
    setState({ user: null, isAuthenticated: false, isLoading: false });
  }, []);

  const value = useMemo(
    () => ({ ...state, login, logout, refreshToken }),
    [state, login, logout, refreshToken]
  );

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
}
```

### Zustand (Lightweight Global State)

```tsx
// stores/cartStore.ts
import { create } from 'zustand';
import { persist, devtools } from 'zustand/middleware';

interface CartItem {
  productId: string;
  name: string;
  price: number;
  quantity: number;
}

interface CartState {
  items: CartItem[];
  total: number;
}

interface CartActions {
  addItem: (item: Omit<CartItem, 'quantity'>) => void;
  removeItem: (productId: string) => void;
  updateQuantity: (productId: string, quantity: number) => void;
  clearCart: () => void;
}

export const useCartStore = create<CartState & CartActions>()(
  devtools(
    persist(
      (set, get) => ({
        items: [],
        total: 0,

        addItem: (item) => set((state) => {
          const existing = state.items.find(i => i.productId === item.productId);
          if (existing) {
            return {
              items: state.items.map(i =>
                i.productId === item.productId
                  ? { ...i, quantity: i.quantity + 1 }
                  : i
              ),
              total: state.total + item.price
            };
          }
          return {
            items: [...state.items, { ...item, quantity: 1 }],
            total: state.total + item.price
          };
        }),

        removeItem: (productId) => set((state) => {
          const item = state.items.find(i => i.productId === productId);
          return {
            items: state.items.filter(i => i.productId !== productId),
            total: state.total - (item ? item.price * item.quantity : 0)
          };
        }),

        updateQuantity: (productId, quantity) => set((state) => {
          const item = state.items.find(i => i.productId === productId);
          if (!item) return state;

          const diff = quantity - item.quantity;
          return {
            items: state.items.map(i =>
              i.productId === productId ? { ...i, quantity } : i
            ),
            total: state.total + (diff * item.price)
          };
        }),

        clearCart: () => set({ items: [], total: 0 })
      }),
      { name: 'cart-storage' }
    ),
    { name: 'CartStore' }
  )
);

// Selectors for optimized re-renders
export const useCartItemCount = () =>
  useCartStore((state) => state.items.reduce((sum, i) => sum + i.quantity, 0));

export const useCartTotal = () =>
  useCartStore((state) => state.total);
```

### useReducer (Complex Local State)

```tsx
// hooks/useCheckoutForm.ts
type CheckoutState = {
  step: 'shipping' | 'payment' | 'review';
  shippingAddress: Address | null;
  paymentMethod: PaymentMethod | null;
  isProcessing: boolean;
  error: string | null;
};

type CheckoutAction =
  | { type: 'SET_SHIPPING'; payload: Address }
  | { type: 'SET_PAYMENT'; payload: PaymentMethod }
  | { type: 'NEXT_STEP' }
  | { type: 'PREV_STEP' }
  | { type: 'START_PROCESSING' }
  | { type: 'PROCESSING_ERROR'; payload: string }
  | { type: 'RESET' };

function checkoutReducer(state: CheckoutState, action: CheckoutAction): CheckoutState {
  switch (action.type) {
    case 'SET_SHIPPING':
      return { ...state, shippingAddress: action.payload };
    case 'SET_PAYMENT':
      return { ...state, paymentMethod: action.payload };
    case 'NEXT_STEP':
      const steps = ['shipping', 'payment', 'review'] as const;
      const currentIndex = steps.indexOf(state.step);
      return { ...state, step: steps[currentIndex + 1] ?? state.step };
    case 'PREV_STEP':
      const stepsBack = ['shipping', 'payment', 'review'] as const;
      const idx = stepsBack.indexOf(state.step);
      return { ...state, step: stepsBack[idx - 1] ?? state.step };
    case 'START_PROCESSING':
      return { ...state, isProcessing: true, error: null };
    case 'PROCESSING_ERROR':
      return { ...state, isProcessing: false, error: action.payload };
    case 'RESET':
      return initialState;
    default:
      return state;
  }
}

export function useCheckoutForm() {
  const [state, dispatch] = useReducer(checkoutReducer, initialState);

  const setShipping = useCallback((address: Address) => {
    dispatch({ type: 'SET_SHIPPING', payload: address });
    dispatch({ type: 'NEXT_STEP' });
  }, []);

  return { state, setShipping, /* ... */ };
}
```

## Best Practices

### State Colocation

```tsx
// Keep state as close to where it's used as possible
// ❌ Don't lift state unnecessarily
function App() {
  const [searchQuery, setSearchQuery] = useState(''); // Too high!
  return <SearchPage query={searchQuery} onQueryChange={setSearchQuery} />;
}

// ✅ Keep state local when only one component needs it
function SearchPage() {
  const [searchQuery, setSearchQuery] = useState('');
  return <SearchInput value={searchQuery} onChange={setSearchQuery} />;
}
```

### Derived State

```tsx
// ❌ Storing derived state
const [items, setItems] = useState<Item[]>([]);
const [filteredItems, setFilteredItems] = useState<Item[]>([]); // Derived!
const [total, setTotal] = useState(0); // Derived!

// ✅ Compute derived values
const [items, setItems] = useState<Item[]>([]);
const [filter, setFilter] = useState('');

const filteredItems = useMemo(
  () => items.filter(item => item.name.includes(filter)),
  [items, filter]
);

const total = useMemo(
  () => items.reduce((sum, item) => sum + item.price, 0),
  [items]
);
```

### Optimizing Re-renders

```tsx
// Zustand selectors for fine-grained subscriptions
const userName = useUserStore((state) => state.user?.name);

// Memoized context values
const value = useMemo(() => ({ user, login, logout }), [user]);

// Split contexts for unrelated data
<AuthProvider>
  <ThemeProvider>
    <CartProvider>
      {children}
    </CartProvider>
  </ThemeProvider>
</AuthProvider>
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Global state for local | Unnecessary complexity | Use useState/useReducer |
| Storing API responses | Stale data | Use React Query/SWR |
| Mutating state directly | Bugs, no re-render | Always create new objects |
| Prop drilling | Hard to maintain | Use context or composition |
| Single giant store | Performance issues | Split by domain |

## Checklist

### State Design
- [ ] State colocation evaluated
- [ ] Derived state not stored
- [ ] Appropriate tool chosen
- [ ] State shape documented

### Performance
- [ ] Selectors used for subscriptions
- [ ] Memoization where needed
- [ ] Context split appropriately
- [ ] DevTools enabled

### Testing
- [ ] State transitions tested
- [ ] Edge cases covered
- [ ] Persistence tested (if used)

## Integration

### Works With
- api-bridge-builder (server state)
- ui-component-architect (consuming state)
- interaction-designer (UI state)

### Output
- Context providers
- Store definitions
- Custom hooks
- State selectors
