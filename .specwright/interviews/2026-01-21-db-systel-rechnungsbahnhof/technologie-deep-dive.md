# Technologie Deep-Dive: .NET, C#, React

> Wichtige Konzepte, Best Practices und Anti-Patterns für technische Interview-Fragen

---

## C# / .NET Core

### 1. Async/Await - Die häufigsten Fehler

**Anti-Pattern: async void**

```csharp
// FALSCH - Exceptions können nicht gefangen werden
public async void ProcessData() { ... }

// RICHTIG - immer Task zurückgeben
public async Task ProcessDataAsync() { ... }
```

> **Interview-Antwort:** "async void ist nur für Event-Handler erlaubt. Bei allen anderen Methoden Task oder Task<T> zurückgeben, sonst können Exceptions nicht propagiert werden."

**Anti-Pattern: .Result oder .Wait() blockieren**

```csharp
// FALSCH - kann zu Deadlocks führen
var result = GetDataAsync().Result;

// RICHTIG - await verwenden
var result = await GetDataAsync();
```
> **Interview-Antwort:** "Blocking auf async Code kann zu Deadlocks führen, besonders in ASP.NET wo der SynchronizationContext wichtig ist. Immer await durchziehen - async all the way."

**Best Practice: ConfigureAwait(false) in Libraries**

```csharp
// In Library-Code - kein UI-Context nötig
var data = await httpClient.GetAsync(url).ConfigureAwait(false);
```
> **Interview-Antwort:** "In Library-Code ConfigureAwait(false) verwenden, um nicht unnötig auf den ursprünglichen Context zu warten. In ASP.NET Core ist das weniger kritisch, aber in .NET Framework wichtig."

---

### 2. Dependency Injection - Service Lifetimes

**Die drei Lifetimes:**

| Lifetime | Beschreibung | Typischer Use Case |
|----------|--------------|-------------------|
| **Transient** | Jede Anfrage = neue Instanz | Leichtgewichtige, zustandslose Services |
| **Scoped** | Eine Instanz pro HTTP-Request | DbContext, Unit of Work |
| **Singleton** | Eine Instanz für die App-Lebensdauer | Caches, Konfiguration |

**Anti-Pattern: Captive Dependency**

```csharp
// PROBLEM: Singleton hält Scoped Service
public class MySingleton  // Singleton
{
    private readonly IScopedService _scoped;  // FEHLER!

    public MySingleton(IScopedService scoped)
    {
        _scoped = scoped;  // Scoped wird zu "gefangenem" Singleton
    }
}
```
> **Interview-Antwort:** "Ein Singleton darf keine Scoped oder Transient Dependencies haben - die werden dann auch zu Singletons. Für solche Fälle IServiceScopeFactory injizieren und bei Bedarf einen Scope erstellen."

---

### 3. Entity Framework - N+1 Problem (auch in .NET!)

**Das Problem:**

```csharp
// SCHLECHT - N+1 Queries
var orders = await context.Orders.ToListAsync();
foreach (var order in orders)
{
    // Jeder Zugriff = neuer DB-Call!
    Console.WriteLine(order.Customer.Name);
}

// GUT - Eager Loading
var orders = await context.Orders
    .Include(o => o.Customer)
    .ToListAsync();
```

**Weitere EF Best Practices:**

```csharp
// AsNoTracking für Read-Only Queries (Performance!)
var products = await context.Products
    .AsNoTracking()
    .Where(p => p.IsActive)
    .ToListAsync();

// Projection statt volle Entities
var names = await context.Products
    .Select(p => new { p.Id, p.Name })
    .ToListAsync();
```

> **Interview-Antwort:** "N+1 ist auch in EF ein Problem. Lösung: Include() für Eager Loading, oder besser noch Projection mit Select() wenn nicht alle Daten gebraucht werden. Für Read-Only immer AsNoTracking() verwenden."

---

### 4. LINQ - Deferred Execution verstehen

**Das Problem:**

```csharp
// Query wird NICHT sofort ausgeführt
var query = products.Where(p => p.Price > 100);

// Erst hier wird die Datenbank abgefragt
foreach (var p in query) { }

// PROBLEM: Multiple Enumeration
var expensive = products.Where(p => p.Price > 100);
var count = expensive.Count();      // Query 1
var first = expensive.First();      // Query 2 (!)

// LÖSUNG: Materialisieren
var expensive = products.Where(p => p.Price > 100).ToList();
var count = expensive.Count;        // In-Memory
var first = expensive.First();      // In-Memory
```

> **Interview-Antwort:** "LINQ verwendet Deferred Execution - die Query wird erst bei Enumeration ausgeführt. Wenn man das Ergebnis mehrfach braucht, mit ToList() materialisieren, sonst wird die Query mehrfach ausgeführt."

---

### 5. Null Handling - Modern C#

**Nullable Reference Types (C# 8+):**

```csharp
// Nicht-nullable - Compiler warnt bei null
string name = GetName();

// Explizit nullable
string? middleName = GetMiddleName();

// Null-conditional und Null-coalescing
var length = middleName?.Length ?? 0;

// Null-forgiving (wenn man sicher ist)
var upper = middleName!.ToUpper();
```

> **Interview-Antwort:** "Seit C# 8 gibt es Nullable Reference Types. Das hilft, NullReferenceExceptions zur Compile-Zeit zu finden statt zur Runtime. Der ?. Operator und ?? sind essentiell für sauberen Null-Handling-Code."

---

### 6. Memory & Performance

**IDisposable richtig verwenden:**

```csharp
// IMMER using für IDisposable
using var connection = new SqlConnection(connectionString);
using var reader = await command.ExecuteReaderAsync();

// Oder mit Block
using (var stream = new FileStream(...))
{
    // ...
} // Dispose wird automatisch aufgerufen
```

**String Performance:**

```csharp
// SCHLECHT für viele Concatenations
string result = "";
for (int i = 0; i < 1000; i++)
    result += i.ToString();  // Jedes Mal neuer String!

// GUT
var sb = new StringBuilder();
for (int i = 0; i < 1000; i++)
    sb.Append(i);
var result = sb.ToString();
```

> **Interview-Antwort:** "Strings sind immutable in C# - jede Concatenation erzeugt einen neuen String. Bei Schleifen oder vielen Operationen StringBuilder verwenden. Und IDisposable immer mit using - sonst Memory Leaks."

---

## React

### 1. Hooks - Rules & Anti-Patterns

**Die zwei Regeln:**
1. Hooks nur auf Top-Level aufrufen (nicht in Loops, Conditions, nested Functions)
2. Hooks nur in React Function Components oder Custom Hooks aufrufen

**Anti-Pattern: Conditional Hooks**

```jsx
// FALSCH - Hook in Condition
function Component({ isLoggedIn }) {
  if (isLoggedIn) {
    const [user, setUser] = useState(null);  // FEHLER!
  }
  // ...
}

// RICHTIG - Hook immer aufrufen, Condition im Hook
function Component({ isLoggedIn }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    if (isLoggedIn) {
      fetchUser().then(setUser);
    }
  }, [isLoggedIn]);
}
```

> **Interview-Antwort:** "Hooks müssen immer in derselben Reihenfolge aufgerufen werden - React trackt sie über die Aufruf-Reihenfolge. Deshalb keine Hooks in Conditions oder Loops."

---

### 2. useEffect - Die häufigsten Fehler

**Anti-Pattern: Fehlende Dependencies**

```jsx
// FALSCH - userId fehlt in Dependencies
useEffect(() => {
  fetchUser(userId);
}, []);  // Warnung: exhaustive-deps

// RICHTIG
useEffect(() => {
  fetchUser(userId);
}, [userId]);
```

**Anti-Pattern: Fehlende Cleanup-Function**

```jsx
// FALSCH - Memory Leak bei unmount
useEffect(() => {
  const subscription = subscribeToData(id);
  // Subscription bleibt aktiv nach unmount!
}, [id]);

// RICHTIG
useEffect(() => {
  const subscription = subscribeToData(id);
  return () => subscription.unsubscribe();  // Cleanup!
}, [id]);
```

**Anti-Pattern: Race Conditions**

```jsx
// PROBLEM: Alte Requests können nach neuen ankommen
useEffect(() => {
  fetchData(id).then(setData);
}, [id]);

// LÖSUNG: Cancelled-Flag
useEffect(() => {
  let cancelled = false;

  fetchData(id).then(data => {
    if (!cancelled) setData(data);
  });

  return () => { cancelled = true; };
}, [id]);
```

> **Interview-Antwort:** "useEffect hat drei häufige Fallstricke: fehlende Dependencies führen zu Stale Closures, fehlende Cleanups zu Memory Leaks, und bei async Code muss man Race Conditions beachten wenn sich Dependencies ändern bevor der Request fertig ist."

---

### 3. Performance - Unnecessary Re-renders vermeiden

**Problem: Referenzielle Gleichheit**

```jsx
// SCHLECHT - neues Objekt bei jedem Render
function Parent() {
  // Jedes Render = neues Object = Child re-rendert
  return <Child config={{ theme: 'dark' }} />;
}

// GUT - useMemo für stabile Referenz
function Parent() {
  const config = useMemo(() => ({ theme: 'dark' }), []);
  return <Child config={config} />;
}
```

**useCallback - Wann sinnvoll?**

```jsx
// NICHT NÖTIG - einfache Komponente
function Simple() {
  const handleClick = () => console.log('clicked');
  return <button onClick={handleClick}>Click</button>;
}

// SINNVOLL - wenn Callback als Dependency oder an memoized Child
function Parent() {
  const [count, setCount] = useState(0);

  // Stabile Referenz für memoized Child
  const handleIncrement = useCallback(() => {
    setCount(c => c + 1);
  }, []);

  return <MemoizedChild onIncrement={handleIncrement} />;
}
```

> **Interview-Antwort:** "useMemo und useCallback sind nicht immer nötig - sie haben auch Overhead. Sinnvoll sind sie wenn: 1) der Wert als Dependency in useEffect verwendet wird, 2) er an ein memoized Child geht, oder 3) die Berechnung wirklich teuer ist."

---

### 4. useState vs useReducer

**useState - für einfachen State:**

```jsx
const [count, setCount] = useState(0);
const [name, setName] = useState('');
```

**useReducer - für komplexen State:**

```jsx
// Wenn State-Logik komplex ist oder State voneinander abhängt
const [state, dispatch] = useReducer(reducer, initialState);

function reducer(state, action) {
  switch (action.type) {
    case 'INCREMENT':
      return { ...state, count: state.count + 1 };
    case 'SET_NAME':
      return { ...state, name: action.payload };
    default:
      return state;
  }
}
```

> **Interview-Antwort:** "useState für einfachen, unabhängigen State. useReducer wenn der State komplex ist, mehrere Werte zusammenhängen, oder die Update-Logik kompliziert ist. useReducer macht den State-Flow auch besser testbar."

---

### 5. Refs - Mehr als nur DOM-Zugriff

**DOM-Zugriff:**

```jsx
function TextInput() {
  const inputRef = useRef(null);

  const focusInput = () => inputRef.current?.focus();

  return <input ref={inputRef} />;
}
```

**Mutable Werte ohne Re-render:**

```jsx
function Timer() {
  const [count, setCount] = useState(0);
  const intervalRef = useRef(null);  // Kein Re-render bei Änderung!

  useEffect(() => {
    intervalRef.current = setInterval(() => {
      setCount(c => c + 1);
    }, 1000);

    return () => clearInterval(intervalRef.current);
  }, []);
}
```

**Previous Value speichern:**

```jsx
function usePrevious(value) {
  const ref = useRef();
  useEffect(() => {
    ref.current = value;
  });
  return ref.current;
}
```

> **Interview-Antwort:** "useRef hat zwei Use Cases: DOM-Zugriff und mutable Werte die keinen Re-render auslösen sollen. Der Wert bleibt über Renders erhalten, aber Änderungen triggern keinen Re-render."

---

### 6. Controlled vs Uncontrolled Components

**Controlled - React kontrolliert den Wert:**

```jsx
function ControlledInput() {
  const [value, setValue] = useState('');

  return (
    <input
      value={value}
      onChange={e => setValue(e.target.value)}
    />
  );
}
```

**Uncontrolled - DOM kontrolliert den Wert:**

```jsx
function UncontrolledInput() {
  const inputRef = useRef();

  const handleSubmit = () => {
    console.log(inputRef.current.value);
  };

  return <input ref={inputRef} defaultValue="" />;
}
```

> **Interview-Antwort:** "Controlled Components geben React die volle Kontrolle - jede Änderung geht durch State. Uncontrolled sind einfacher für Fire-and-Forget-Fälle wie File Inputs. Generell Controlled bevorzugen für bessere Kontrolle und Validierung."

---

## Interview-Fragen zum Üben

### C# / .NET

1. "Was ist der Unterschied zwischen Scoped, Transient und Singleton in DI?"
2. "Wie vermeiden Sie das N+1 Problem in Entity Framework?"
3. "Warum sollte man async void vermeiden?"
4. "Was ist Deferred Execution in LINQ?"
5. "Wie funktionieren Nullable Reference Types?"

### React

1. "Warum dürfen Hooks nicht in Conditions stehen?"
2. "Wann verwenden Sie useCallback vs useMemo?"
3. "Wie vermeiden Sie Race Conditions in useEffect?"
4. "Was ist der Unterschied zwischen useState und useReducer?"
5. "Wann würden Sie Controlled vs Uncontrolled Components verwenden?"

---

## Quick-Reference Card

### C# Don'ts
- async void (außer Event-Handler)
- .Result oder .Wait() auf Tasks
- Singleton mit Scoped Dependency
- LINQ mehrfach enumerieren
- String concatenation in Loops

### React Don'ts
- Hooks in Conditions/Loops
- useEffect ohne Cleanup bei Subscriptions
- Objekte/Arrays als inline Props (referenzielle Gleichheit)
- Fehlende Dependencies in useEffect
- useMemo/useCallback überall (Overhead!)
