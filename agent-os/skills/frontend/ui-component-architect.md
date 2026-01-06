---
name: ui-component-architect
description: Designs and implements reusable UI component systems
version: 1.0
---

# UI Component Architect

Builds reusable, accessible, and maintainable component libraries following atomic design principles and modern React/Angular patterns.

## Trigger Conditions

```yaml
task_mentions:
  - "component|ui|widget"
  - "design system|component library"
  - "atomic design|reusable"
file_extension:
  - .tsx
  - .jsx
  - .vue
file_contains:
  - "export.*function.*Component"
  - "export.*const.*:"
  - "@Component"
always_active_for_agents:
  - frontend-agent
```

## When to Load

- Creating new UI components
- Building component library
- Implementing design system
- Component refactoring

## Core Competencies

### Atomic Design Hierarchy

```
├── atoms/         # Basic building blocks
│   ├── Button/
│   ├── Input/
│   ├── Icon/
│   └── Text/
├── molecules/     # Combinations of atoms
│   ├── SearchInput/
│   ├── FormField/
│   └── Card/
├── organisms/     # Complex UI sections
│   ├── Header/
│   ├── ProductCard/
│   └── NavigationMenu/
├── templates/     # Page layouts
│   └── DashboardLayout/
└── pages/         # Actual pages
    └── Dashboard/
```

### Component Structure (React)

```tsx
// components/atoms/Button/Button.tsx
import { forwardRef } from 'react';
import { cn } from '@/lib/utils';
import { ButtonProps, buttonVariants } from './Button.types';

export const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = 'primary', size = 'md', isLoading, children, ...props }, ref) => {
    return (
      <button
        ref={ref}
        className={cn(buttonVariants({ variant, size }), className)}
        disabled={isLoading || props.disabled}
        {...props}
      >
        {isLoading ? (
          <span className="flex items-center gap-2">
            <Spinner size="sm" />
            Loading...
          </span>
        ) : (
          children
        )}
      </button>
    );
  }
);

Button.displayName = 'Button';
```

### Component Types

```tsx
// components/atoms/Button/Button.types.ts
import { VariantProps, cva } from 'class-variance-authority';

export const buttonVariants = cva(
  // Base styles
  'inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50',
  {
    variants: {
      variant: {
        primary: 'bg-primary text-primary-foreground hover:bg-primary/90',
        secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
        outline: 'border border-input bg-background hover:bg-accent',
        ghost: 'hover:bg-accent hover:text-accent-foreground',
        destructive: 'bg-destructive text-destructive-foreground hover:bg-destructive/90'
      },
      size: {
        sm: 'h-8 px-3 text-sm',
        md: 'h-10 px-4 text-sm',
        lg: 'h-12 px-6 text-base',
        icon: 'h-10 w-10'
      }
    },
    defaultVariants: {
      variant: 'primary',
      size: 'md'
    }
  }
);

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  isLoading?: boolean;
}
```

### Component Composition

```tsx
// components/molecules/FormField/FormField.tsx
interface FormFieldProps {
  label: string;
  name: string;
  error?: string;
  required?: boolean;
  children: React.ReactNode;
}

export function FormField({ label, name, error, required, children }: FormFieldProps) {
  return (
    <div className="space-y-2">
      <Label htmlFor={name} required={required}>
        {label}
      </Label>
      {children}
      {error && (
        <Text variant="error" size="sm">
          {error}
        </Text>
      )}
    </div>
  );
}

// Usage
<FormField label="Email" name="email" error={errors.email} required>
  <Input
    id="email"
    type="email"
    placeholder="Enter your email"
    {...register('email')}
  />
</FormField>
```

## Best Practices

### Compound Components Pattern

```tsx
// components/organisms/Tabs/Tabs.tsx
const TabsContext = createContext<TabsContextValue | null>(null);

export function Tabs({ children, defaultValue, onChange }: TabsProps) {
  const [activeTab, setActiveTab] = useState(defaultValue);

  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab, onChange }}>
      <div className="tabs">{children}</div>
    </TabsContext.Provider>
  );
}

Tabs.List = function TabsList({ children }: { children: React.ReactNode }) {
  return <div role="tablist" className="tabs-list">{children}</div>;
};

Tabs.Tab = function Tab({ value, children }: TabProps) {
  const { activeTab, setActiveTab } = useTabsContext();
  return (
    <button
      role="tab"
      aria-selected={activeTab === value}
      onClick={() => setActiveTab(value)}
    >
      {children}
    </button>
  );
};

Tabs.Panel = function TabsPanel({ value, children }: TabPanelProps) {
  const { activeTab } = useTabsContext();
  if (activeTab !== value) return null;
  return <div role="tabpanel">{children}</div>;
};

// Usage
<Tabs defaultValue="general">
  <Tabs.List>
    <Tabs.Tab value="general">General</Tabs.Tab>
    <Tabs.Tab value="security">Security</Tabs.Tab>
  </Tabs.List>
  <Tabs.Panel value="general">General settings...</Tabs.Panel>
  <Tabs.Panel value="security">Security settings...</Tabs.Panel>
</Tabs>
```

### Accessibility (a11y)

```tsx
// Always include proper ARIA attributes
<button
  aria-label="Close dialog"
  aria-pressed={isPressed}
  aria-disabled={isDisabled}
  role="button"
>
  <Icon name="close" aria-hidden="true" />
</button>

// Focus management
const dialogRef = useRef<HTMLDivElement>(null);

useEffect(() => {
  if (isOpen) {
    dialogRef.current?.focus();
  }
}, [isOpen]);

// Keyboard navigation
const handleKeyDown = (e: KeyboardEvent) => {
  switch (e.key) {
    case 'Escape':
      onClose();
      break;
    case 'Tab':
      trapFocus(e);
      break;
  }
};
```

### Component Documentation

```tsx
// Storybook story
export default {
  title: 'Atoms/Button',
  component: Button,
  argTypes: {
    variant: {
      control: 'select',
      options: ['primary', 'secondary', 'outline', 'ghost', 'destructive']
    },
    size: {
      control: 'select',
      options: ['sm', 'md', 'lg', 'icon']
    }
  }
} as Meta<typeof Button>;

export const Primary: StoryObj<typeof Button> = {
  args: {
    children: 'Button',
    variant: 'primary'
  }
};

export const AllVariants: StoryObj<typeof Button> = {
  render: () => (
    <div className="flex gap-2">
      <Button variant="primary">Primary</Button>
      <Button variant="secondary">Secondary</Button>
      <Button variant="outline">Outline</Button>
      <Button variant="ghost">Ghost</Button>
      <Button variant="destructive">Destructive</Button>
    </div>
  )
};
```

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Prop drilling | Hard to maintain | Use context or composition |
| Inline styles | Inconsistent | Use design tokens/CSS classes |
| Hardcoded colors | Not themeable | Use CSS variables |
| Missing key props | React warnings | Always use unique keys |
| No error boundaries | App crashes | Wrap with ErrorBoundary |

## Checklist

### Component Quality
- [ ] Single responsibility
- [ ] Props are well-typed
- [ ] Default props provided
- [ ] Accessible (ARIA, keyboard)
- [ ] Responsive design
- [ ] Dark mode support

### File Structure
- [ ] Component file
- [ ] Types file
- [ ] Styles (if separate)
- [ ] Tests
- [ ] Storybook story

### Documentation
- [ ] Props documented
- [ ] Usage examples
- [ ] Accessibility notes
- [ ] Edge cases covered

## Integration

### Works With
- state-manager (component state)
- interaction-designer (animations)
- design-system.md (tokens)

### Output
- React/Angular components
- Type definitions
- Storybook stories
- Unit tests
