---
name: interaction-designer
description: Implements animations, transitions, and micro-interactions
version: 1.0
---

# Interaction Designer

Creates engaging user experiences through thoughtful animations, transitions, and micro-interactions using CSS and animation libraries.

## Trigger Conditions

```yaml
task_mentions:
  - "animation|transition|motion"
  - "micro-interaction|hover effect"
  - "framer motion|gsap|spring"
  - "skeleton|loading animation"
file_extension:
  - .tsx
  - .css
  - .scss
file_contains:
  - "motion."
  - "animate"
  - "transition"
  - "@keyframes"
always_active_for_agents:
  - frontend-agent
```

## When to Load

- Adding animations to components
- Creating page transitions
- Implementing micro-interactions
- Building loading states

## Core Competencies

### CSS Transitions

```css
/* Base transition utilities */
.transition-base {
  transition-property: color, background-color, border-color, opacity, transform;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  transition-duration: 150ms;
}

.transition-transform {
  transition-property: transform;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  transition-duration: 200ms;
}

/* Button hover effect */
.btn {
  transform: translateY(0);
  transition: transform 150ms ease, box-shadow 150ms ease;
}

.btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.btn:active {
  transform: translateY(0);
}
```

### CSS Keyframe Animations

```css
/* Skeleton loading shimmer */
@keyframes shimmer {
  0% {
    background-position: -200% 0;
  }
  100% {
    background-position: 200% 0;
  }
}

.skeleton {
  background: linear-gradient(
    90deg,
    #f0f0f0 25%,
    #e0e0e0 50%,
    #f0f0f0 75%
  );
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite;
}

/* Fade in animation */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.fade-in {
  animation: fadeIn 0.3s ease-out forwards;
}

/* Staggered list animation */
.stagger-item {
  opacity: 0;
  animation: fadeIn 0.3s ease-out forwards;
}

.stagger-item:nth-child(1) { animation-delay: 0ms; }
.stagger-item:nth-child(2) { animation-delay: 50ms; }
.stagger-item:nth-child(3) { animation-delay: 100ms; }
.stagger-item:nth-child(4) { animation-delay: 150ms; }
.stagger-item:nth-child(5) { animation-delay: 200ms; }
```

### Framer Motion Patterns

```tsx
// components/AnimatedPage.tsx
import { motion, AnimatePresence } from 'framer-motion';

const pageVariants = {
  initial: { opacity: 0, x: -20 },
  animate: { opacity: 1, x: 0 },
  exit: { opacity: 0, x: 20 }
};

export function AnimatedPage({ children }: { children: React.ReactNode }) {
  return (
    <motion.div
      variants={pageVariants}
      initial="initial"
      animate="animate"
      exit="exit"
      transition={{ duration: 0.3, ease: 'easeInOut' }}
    >
      {children}
    </motion.div>
  );
}

// Usage with router
function App() {
  const location = useLocation();

  return (
    <AnimatePresence mode="wait">
      <Routes location={location} key={location.pathname}>
        <Route path="/" element={<AnimatedPage><Home /></AnimatedPage>} />
        <Route path="/about" element={<AnimatedPage><About /></AnimatedPage>} />
      </Routes>
    </AnimatePresence>
  );
}
```

### Animated List

```tsx
// components/AnimatedList.tsx
const containerVariants = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.05
    }
  }
};

const itemVariants = {
  hidden: { opacity: 0, y: 20 },
  visible: {
    opacity: 1,
    y: 0,
    transition: { duration: 0.3 }
  }
};

export function AnimatedList<T>({
  items,
  renderItem,
  keyExtractor
}: AnimatedListProps<T>) {
  return (
    <motion.ul
      variants={containerVariants}
      initial="hidden"
      animate="visible"
    >
      {items.map((item, index) => (
        <motion.li
          key={keyExtractor(item)}
          variants={itemVariants}
          layout
        >
          {renderItem(item, index)}
        </motion.li>
      ))}
    </motion.ul>
  );
}
```

### Micro-interactions

```tsx
// Checkbox with animation
function AnimatedCheckbox({ checked, onChange }: CheckboxProps) {
  return (
    <motion.button
      onClick={() => onChange(!checked)}
      className="w-6 h-6 rounded border-2 flex items-center justify-center"
      animate={{
        backgroundColor: checked ? '#3b82f6' : '#ffffff',
        borderColor: checked ? '#3b82f6' : '#d1d5db'
      }}
      transition={{ duration: 0.2 }}
    >
      <motion.svg
        viewBox="0 0 24 24"
        className="w-4 h-4 text-white"
        initial={false}
        animate={{ scale: checked ? 1 : 0 }}
        transition={{ type: 'spring', stiffness: 500, damping: 30 }}
      >
        <path
          fill="none"
          stroke="currentColor"
          strokeWidth="3"
          d="M5 12l5 5L19 7"
        />
      </motion.svg>
    </motion.button>
  );
}

// Button with loading spinner
function LoadingButton({ isLoading, children, ...props }: LoadingButtonProps) {
  return (
    <button {...props} disabled={isLoading}>
      <AnimatePresence mode="wait">
        {isLoading ? (
          <motion.span
            key="loading"
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.8 }}
          >
            <Spinner size="sm" />
          </motion.span>
        ) : (
          <motion.span
            key="content"
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.8 }}
          >
            {children}
          </motion.span>
        )}
      </AnimatePresence>
    </button>
  );
}
```

## Best Practices

### Performance Guidelines

```tsx
// Use transform and opacity (GPU-accelerated)
// ✅ Good
.animate-good {
  transform: translateX(100px);
  opacity: 0.5;
}

// ❌ Avoid (triggers layout)
.animate-bad {
  left: 100px;
  width: 200px;
}

// Use will-change sparingly
.will-animate {
  will-change: transform;
}

// Remove will-change after animation
element.addEventListener('animationend', () => {
  element.style.willChange = 'auto';
});
```

### Reduced Motion Support

```tsx
// Hook for reduced motion preference
function usePrefersReducedMotion() {
  const [prefersReduced, setPrefersReduced] = useState(false);

  useEffect(() => {
    const mediaQuery = window.matchMedia('(prefers-reduced-motion: reduce)');
    setPrefersReduced(mediaQuery.matches);

    const handler = (e: MediaQueryListEvent) => setPrefersReduced(e.matches);
    mediaQuery.addEventListener('change', handler);
    return () => mediaQuery.removeEventListener('change', handler);
  }, []);

  return prefersReduced;
}

// Usage
function AnimatedComponent() {
  const prefersReduced = usePrefersReducedMotion();

  return (
    <motion.div
      animate={{ x: 100 }}
      transition={prefersReduced ? { duration: 0 } : { duration: 0.3 }}
    >
      Content
    </motion.div>
  );
}

// CSS approach
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

### Animation Timing

| Duration | Use Case |
|----------|----------|
| 100-150ms | Hover states, button clicks |
| 200-300ms | UI element transitions |
| 300-500ms | Page transitions, modals |
| 500ms+ | Complex sequences, attention-grabbing |

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Animating layout properties | Jank, poor performance | Use transform/opacity |
| Too many animations | Distracting | Animate key interactions only |
| Ignoring reduced motion | Accessibility issue | Check prefers-reduced-motion |
| Blocking interactions | Poor UX | Keep animations short |
| Missing exit animations | Jarring | Use AnimatePresence |

## Checklist

### Animation Quality
- [ ] Smooth 60fps performance
- [ ] Appropriate duration/easing
- [ ] Exit animations included
- [ ] Reduced motion supported

### Implementation
- [ ] GPU-accelerated properties used
- [ ] will-change used sparingly
- [ ] No layout thrashing
- [ ] Tested on low-end devices

### UX Considerations
- [ ] Animations enhance (not distract)
- [ ] Loading states animated
- [ ] Feedback on interactions
- [ ] Consistent animation language

## Integration

### Works With
- ui-component-architect (component animations)
- state-manager (animation state)
- design-system.md (animation tokens)

### Output
- CSS animations/transitions
- Framer Motion components
- Animation utilities
- Skeleton components
