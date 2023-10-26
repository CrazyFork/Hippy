
## annoations

```
* m:mark
* m:cpp
* m:todo
```


```
.
├── CMakeLists.txt
├── include
│   └── footstone
│       ├── base_time.h                             //
│       ├── base_timer.h                            // 
│       ├── idle_timer.h                            // idle_timer and idle_task are related, it has a timeout trait
│       ├── repeating_timer.h
│       ├── one_shot_timer.h

│       ├── check.h                                 //
│       ├── log_level.h                             // logging
│       ├── log_settings.h
│       ├── logging.h                               // logging
│       ├── macros.h

│       ├── persistent_object_map.h

│       ├── deserializer.h                          //
│       ├── serializer.h
│       ├── string_utils.h                          // string utils
│       ├── string_view.h                           // 
│       ├── string_view_utils.h                     //
│       ├── hippy_value.h


│       ├── time_delta.h                            // time span, 
│       ├── time_point.h                            // a certain point in timeline

│       ├── driver.h                                // driver is the thing that actually execute task from task queue
│       ├── cv_driver.h                             // driver implementation using cpp condition variable
│       ├── platform                                // driver implementation using platform function
│       │   ├── adr
│       │   │   └── looper_driver.h
│       │   └── ios
│       │       └── looper_driver.h
│       ├── hash.h                                  // hash extention on container types
│       ├── idle_task.h                             // a task with timeout
│       ├── task.h                                  // a task is a function to be run
│       ├── task_runner.h
│       ├── worker.h                                // a worker added more functionalities on top of driver (has a immediate task queue; 2 runner(pending&running);)
│       ├── worker_impl.h                           // a worker has name and can create shared pointer out of self
│       └── worker_manager.h                        // 
└── src
    ├── base_timer.cc
    ├── cv_driver.cc
    ├── deserializer.cc
    ├── hippy_value.cc
    ├── idle_task.cc
    ├── idle_timer.cc
    ├── log_settings.cc
    ├── log_settings_state.cc
    ├── one_shot_timer.cc
    ├── platform
    │   ├── adr
    │   │   ├── logging.cc
    │   │   ├── looper_driver.cc
    │   │   └── worker_impl.cc
    │   └── ios
    │       ├── logging.cc
    │       ├── looper_driver.cc
    │       └── worker_impl.cc
    ├── repeating_timer.cc
    ├── serializer.cc
    ├── string_utils.cc
    ├── string_view.cc
    ├── task.cc
    ├── task_runner.cc
    ├── worker.cc
    └── worker_manager.cc
```


key notes
* how a logger is implemented
* how a event loop/task queue scheduler got implemented
* 
