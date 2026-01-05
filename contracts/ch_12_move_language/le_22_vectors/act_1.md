### Smart contract activity

```move
module vector_demo::task_queue {
    use std::vector;

    // TODO: Define Task struct with copy, drop, store abilities

    /// Creates a new task
    public fun create_task(id: u64, priority: u8): Task {
        Task { id, priority }
    }

    /// Gets the ID from a task
    public fun get_task_id(task: &Task): u64 {
        task.id
    }

    /// Gets the priority from a task
    public fun get_task_priority(task: &Task): u8 {
        task.priority
    }

    /// Creates an empty task queue
    public fun create_queue(): vector<Task> {
        vector::empty()
    }

    // TODO: Implement add_task

    // TODO: Implement remove_last_task

    // TODO: Implement get_queue_size

    // TODO: Implement find_task_index

    // TODO: Implement remove_task_by_id

    // TODO: Implement get_highest_priority_task

    // TODO: Implement pop_highest_priority
}
```

## Tasks for Learners

- Define the `Task` struct with `copy`, `drop`, and `store` abilities:

  - Fields: `id: u64`, `priority: u8` (higher = more urgent)

  ```move
  struct Task has copy, drop, store {
      id: u64,
      priority: u8,
  }
  ```

- Implement `add_task` to add a new task to the end of the queue:

  ```move
  public fun add_task(queue: &mut vector<Task>, id: u64, priority: u8) {
      let task = create_task(id, priority);
      vector::push_back(queue, task);
  }
  ```

- Implement `remove_last_task` to pop and return the most recently added task:

  ```move
  public fun remove_last_task(queue: &mut vector<Task>): Task {
      vector::pop_back(queue)
  }
  ```

- Implement `get_queue_size` to return the number of tasks in the queue:

  ```move
  public fun get_queue_size(queue: &vector<Task>): u64 {
      vector::length(queue)
  }
  ```

- Implement `find_task_index` to find a task by its ID and return its index:

  - Return `(true, index)` if found
  - Return `(false, 0)` if not found

  ```move
  public fun find_task_index(queue: &vector<Task>, task_id: u64): (bool, u64) {
      let mut i = 0;
      let len = vector::length(queue);
      while (i < len) {
          let task = vector::borrow(queue, i);
          if (task.id == task_id) {
              return (true, i)
          };
          i = i + 1;
      };
      (false, 0)
  }
  ```

- Implement `remove_task_by_id` to remove a specific task by its ID:

  - Remove the task if found, return true
  - Return false if task not found

  ```move
  public fun remove_task_by_id(queue: &mut vector<Task>, task_id: u64): bool {
      let (found, index) = find_task_index(queue, task_id);
      if (found) {
          vector::remove(queue, index);
          true
      } else {
          false
      }
  }
  ```

- Implement `get_highest_priority_task` to find and return a copy of the highest priority task:

  - Return the task with highest priority value
  - If multiple have same priority, return first found
  - Aborts if queue is empty

  ```move
  public fun get_highest_priority_task(queue: &vector<Task>): Task {
      let len = vector::length(queue);
      assert!(len > 0, 0);

      let mut highest_idx = 0;
      let mut highest_priority = vector::borrow(queue, 0).priority;
      let mut i = 1;

      while (i < len) {
          let task = vector::borrow(queue, i);
          if (task.priority > highest_priority) {
              highest_priority = task.priority;
              highest_idx = i;
          };
          i = i + 1;
      };

      *vector::borrow(queue, highest_idx)
  }
  ```

- Implement `pop_highest_priority` to remove and return the highest priority task:

  ```move
  public fun pop_highest_priority(queue: &mut vector<Task>): Task {
      let len = vector::length(queue);
      assert!(len > 0, 0);

      let mut highest_idx = 0;
      let mut highest_priority = vector::borrow(queue, 0).priority;
      let mut i = 1;

      while (i < len) {
          let task = vector::borrow(queue, i);
          if (task.priority > highest_priority) {
              highest_priority = task.priority;
              highest_idx = i;
          };
          i = i + 1;
      };

      vector::remove(queue, highest_idx)
  }
  ```

### Breakdown for learners

- Vector Basics:

  - `vector<T>` is a dynamic array type in Move
  - Defined in `std::vector` module
  - Requires element type to have `store` ability

- Creating Vectors:

  - `vector::empty<T>()` - creates empty vector
  - `vector[a, b, c]` - literal syntax for creating with values

- Adding Elements:

  - `vector::push_back(&mut v, elem)` - adds element to end
  - Takes mutable reference to vector

- Removing Elements:

  - `vector::pop_back(&mut v)` - removes and returns last element
  - `vector::remove(&mut v, index)` - removes element at index, shifts remaining
  - `vector::swap_remove(&mut v, index)` - removes by swapping with last (faster, unordered)

- Reading Elements:

  - `vector::borrow(&v, index)` - returns immutable reference
  - `vector::borrow_mut(&mut v, index)` - returns mutable reference
  - `vector::length(&v)` - returns number of elements

- Iteration Pattern:

  - Use while loop with index counter
  - Access elements with `vector::borrow`
  - Increment index manually
