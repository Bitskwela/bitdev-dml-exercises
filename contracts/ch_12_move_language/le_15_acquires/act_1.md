## Smart contract activity

Neri's `acquires` lesson becomes a real on-chain **task tracker**. Each user gets a
`TaskList` resource stored under their own address. Every function that reaches into
global storage with `borrow_global` / `borrow_global_mut` must declare `acquires
TaskList` — and that obligation **propagates up** the call chain. Functions that only use
`move_to` or `exists` need no annotation at all.

```move
module movestack::task_tracker {
    use std::signer;
    use std::string::String;
    use std::vector;

    /// Error codes
    const E_NOT_INITIALIZED: u64 = 1;
    const E_ALREADY_INITIALIZED: u64 = 2;
    const E_TASK_NOT_FOUND: u64 = 3;

    struct Task has store, drop, copy {
        id: u64,
        title: String,
        completed: bool,
    }

    struct TaskList has key {
        tasks: vector<Task>,
        next_id: u64,
    }

    fun get_task_list(addr: address): &TaskList {
        // TODO: assert initialized, borrow_global — add `acquires TaskList`
    }

    fun get_task_list_mut(addr: address): &mut TaskList {
        // TODO: assert initialized, borrow_global_mut — add `acquires TaskList`
    }

    public entry fun initialize(account: &signer) {
        // TODO: move_to a fresh TaskList (NO acquires needed)
    }

    public entry fun add_task(account: &signer, title: String) {
        // TODO: push a new Task — calls get_task_list_mut, so `acquires TaskList`
    }

    public entry fun complete_task(account: &signer, task_id: u64) {
        // TODO: find the task and mark completed — `acquires TaskList`
    }

    public entry fun delete_task(account: &signer, task_id: u64) {
        // TODO: find and remove the task — `acquires TaskList`
    }

    public fun get_task_count(addr: address): u64 {
        // TODO: calls get_task_list, so `acquires TaskList`
    }

    public fun task_exists(addr: address, task_id: u64): bool {
        // TODO: calls get_task_list, so `acquires TaskList`
    }

    public fun is_task_completed(addr: address, task_id: u64): bool {
        // TODO: calls get_task_list, so `acquires TaskList`
    }

    public fun has_task_list(addr: address): bool {
        // TODO: just exists<TaskList> (NO acquires needed)
    }
}
```

## Tasks for Learners

The whole lesson lives in `module movestack::task_tracker`. The point of the exercise is
to put `acquires TaskList` on exactly the functions that need it. Each snippet is copied
verbatim from the working solution — note which signatures carry `acquires` and which do
not.

- Define the two structs. `Task` is plain copyable data (`store, drop, copy`); `TaskList` is the resource (`key`):

  ```move
  struct Task has store, drop, copy {
      id: u64,
      title: String,
      completed: bool,
  }

  struct TaskList has key {
      tasks: vector<Task>,
      next_id: u64,
  }
  ```

- **`get_task_list`** — internal read helper. Uses `borrow_global`, so it **needs `acquires TaskList`**:

  ```move
  fun get_task_list(addr: address): &TaskList acquires TaskList {
      assert!(exists<TaskList>(addr), E_NOT_INITIALIZED);
      borrow_global<TaskList>(addr)
  }
  ```

- **`get_task_list_mut`** — internal write helper. Uses `borrow_global_mut`, so it **needs `acquires TaskList`**:

  ```move
  fun get_task_list_mut(addr: address): &mut TaskList acquires TaskList {
      assert!(exists<TaskList>(addr), E_NOT_INITIALIZED);
      borrow_global_mut<TaskList>(addr)
  }
  ```

- **`initialize`** — publishes a new list with `move_to`. **No `acquires`** is needed (publishing does not borrow):

  ```move
  public entry fun initialize(account: &signer) {
      let addr = signer::address_of(account);
      assert!(!exists<TaskList>(addr), E_ALREADY_INITIALIZED);

      let task_list = TaskList {
          tasks: vector::empty<Task>(),
          next_id: 1,
      };
      // move_to does NOT require acquires
      move_to(account, task_list);
  }
  ```

- **`add_task`** — calls `get_task_list_mut`, so the `acquires` obligation **propagates up** to it:

  ```move
  public entry fun add_task(
      account: &signer,
      title: String
  ) acquires TaskList {
      let addr = signer::address_of(account);
      let task_list = get_task_list_mut(addr);

      let task = Task {
          id: task_list.next_id,
          title,
          completed: false,
      };

      vector::push_back(&mut task_list.tasks, task);
      task_list.next_id = task_list.next_id + 1;
  }
  ```

- **`complete_task`** — scans the vector for the ID and flips `completed`; also `acquires TaskList`:

  ```move
  public entry fun complete_task(
      account: &signer,
      task_id: u64
  ) acquires TaskList {
      let addr = signer::address_of(account);
      let task_list = get_task_list_mut(addr);

      let i = 0;
      let len = vector::length(&task_list.tasks);
      while (i < len) {
          let task = vector::borrow_mut(&mut task_list.tasks, i);
          if (task.id == task_id) {
              task.completed = true;
              return
          };
          i = i + 1;
      };
      abort E_TASK_NOT_FOUND
  }
  ```

- **`delete_task`** — finds the task and removes it from the vector; `acquires TaskList`:

  ```move
  public entry fun delete_task(
      account: &signer,
      task_id: u64
  ) acquires TaskList {
      let addr = signer::address_of(account);
      let task_list = get_task_list_mut(addr);

      let i = 0;
      let len = vector::length(&task_list.tasks);
      while (i < len) {
          let task = vector::borrow(&task_list.tasks, i);
          if (task.id == task_id) {
              vector::remove(&mut task_list.tasks, i);
              return
          };
          i = i + 1;
      };
      abort E_TASK_NOT_FOUND
  }
  ```

- **`get_task_count`** — a view function that calls `get_task_list`, so it **must also** `acquires TaskList`:

  ```move
  public fun get_task_count(addr: address): u64 acquires TaskList {
      let task_list = get_task_list(addr);
      vector::length(&task_list.tasks)
  }
  ```

- **`task_exists`** — scans for an ID; calls `get_task_list`, so `acquires TaskList`:

  ```move
  public fun task_exists(addr: address, task_id: u64): bool acquires TaskList {
      let task_list = get_task_list(addr);
      let i = 0;
      let len = vector::length(&task_list.tasks);
      while (i < len) {
          let task = vector::borrow(&task_list.tasks, i);
          if (task.id == task_id) {
              return true
          };
          i = i + 1;
      };
      false
  }
  ```

- **`is_task_completed`** — returns a task's status, aborting if missing; `acquires TaskList`:

  ```move
  public fun is_task_completed(addr: address, task_id: u64): bool acquires TaskList {
      let task_list = get_task_list(addr);
      let i = 0;
      let len = vector::length(&task_list.tasks);
      while (i < len) {
          let task = vector::borrow(&task_list.tasks, i);
          if (task.id == task_id) {
              return task.completed
          };
          i = i + 1;
      };
      abort E_TASK_NOT_FOUND
  }
  ```

- **`has_task_list`** — the key contrast: it only uses `exists<TaskList>`, so it needs **NO** `acquires`:

  ```move
  public fun has_task_list(addr: address): bool {
      // exists does NOT require acquires
      exists<TaskList>(addr)
  }
  ```

- **(Optional / bonus)** The instructor solution ships a full `#[test]` suite (`test_initialize_success`, `test_add_task`, `test_complete_task`, `test_delete_task`, `test_independent_task_lists`, and several `#[expected_failure]` cases). Writing your own tests is encouraged but not required to complete the lesson.

### Breakdown for learners

**The `acquires` annotation** tells the Move compiler which global resources a function
may access. It is required for safety and to make resource access explicit.

**When to add `acquires TaskList`:**

- Functions using `borrow_global<TaskList>` → `get_task_list`
- Functions using `borrow_global_mut<TaskList>` → `get_task_list_mut`
- Functions that **call** a function with `acquires` → `add_task`, `complete_task`, `delete_task`, `get_task_count`, `task_exists`, `is_task_completed`

**When NOT to add `acquires`:**

- `initialize` — uses only `move_to` (publishing a resource).
- `has_task_list` — uses only `exists<TaskList>` (checking existence).

**Acquires propagation:** if function A calls function B and B has `acquires TaskList`,
then A must also declare `acquires TaskList`. That is exactly why all the entry and view
functions above carry the annotation even though only the two private helpers actually
call `borrow_global` / `borrow_global_mut`.

**Why this matters:**

- **Prevents reentrancy / double-borrow bugs:** the compiler knows what each call touches.
- **Explicit contracts:** the signature tells callers what global state a function reads or writes.
- **Compile-time safety:** global-storage access is tracked before the code ever runs.
