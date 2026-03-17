# Final CRUD Project

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+31.0+-+COVER.png)

## Scene

Kuya Miguel closed his laptop and looked at Tian seriously. "You've come a long way -- from 'Hello, World!' to templates and exception handling. But there's one final test: can you build a complete, professional-grade system?"

"Build a full CRUD system for barangay resident management," Kuya Miguel said. "Create, Read, Update, Delete. Use classes for organization, inheritance for code reuse, polymorphism for flexibility, exceptions for robustness, and STL for data management."

Tian thought about his journey -- the confusion with pointers, the breakthrough moments understanding OOP. Every lesson built toward this. "I'm ready," Tian said, opening the IDE with focus. "Then let's build something great," Kuya Miguel replied.

## C++ Topics: CRUD System Integration

![31.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+31.1.png)

### Inheritance (Person -> Resident)

> A `Person` base class holds shared attributes like `name` and `age`. `Resident` inherits from `Person` and adds `id` and `status`. This avoids duplicating common fields.

### Polymorphism (virtual display)

> Marking `display()` as `virtual` in `Person` and overriding it in `Resident` ensures the correct version is called through base pointers. This enables uniform handling of different person types.

### STL Containers (vector, smart pointers)

> `vector<unique_ptr<Resident>>` provides dynamic storage with automatic memory cleanup. No manual `delete` needed -- smart pointers handle deallocation when elements are removed.

### Exception Handling (validation)

> Throw `invalid_argument` for empty names and `runtime_error` for not-found lookups. Catch blocks in `main` prevent crashes and display meaningful error messages.

### CRUD Operations

> **Create**: Add residents with validation. **Read**: Display all or find by ID. **Update**: Change status by ID. **Delete**: Remove by ID using `remove_if` and `erase`. **Save**: Write to file with `ofstream`.

#### Sample syntax

```cpp
class BarangayManager {
    vector<unique_ptr<Resident>> residents;
public:
    void addResident(string name, int age) {
        if (name.empty()) throw invalid_argument("Name cannot be empty!");
        residents.push_back(make_unique<Resident>(nextId++, name, age));
    }
    Resident* findById(int id) {
        for (auto& r : residents)
            if (r->getId() == id) return r.get();
        throw runtime_error("Resident not found!");
    }
    void deleteResident(int id) {
        auto it = remove_if(residents.begin(), residents.end(),
            [id](const unique_ptr<Resident>& r) { return r->getId() == id; });
        residents.erase(it, residents.end());
    }
};
```

The manager uses `unique_ptr` for automatic memory management, `remove_if` with a lambda for deletion, and exceptions for error cases. This combines OOP, STL, templates, and exception handling into one cohesive system.
