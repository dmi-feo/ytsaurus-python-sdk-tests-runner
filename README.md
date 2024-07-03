Want to run YTSaurus Python SDK test, but don't know how? It's never been easier:

```shell
YT_REPO=~/repos/ytsaurus ./run_wrapper_tests test_cypress_commands.py
```

All you need is:
- docker runtime
- cloned ytsaurus repository (a.k.a YT_REPO)

Pass all the arguments that you would pass to pytest:
```shell
YT_REPO=~/repos/ytsaurus ./run_wrapper_tests test_operations.py::TestOperations::test_merge -s --trace
```
