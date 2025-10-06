## 文件树库 / File Tree Library

一个 MoonBit 文件树库，用于递归构建和以 ASCII 树形格式显示目录结构。

### 主要功能 / Main Features

- 递归遍历目录结构 / Recursively traverse directory structures
- 生成美观的 ASCII 树形图 / Generate beautiful ASCII tree diagrams
- 支持字符串输出和直接打印 / Support both string output and direct printing
- 支持跨平台路径格式 / Support cross-platform path formats


#### 基本用法 / Basic Usage

```moonbit
///|
fn tesst() -> Unit raise {
  let tree_node = build_tree("./target")
  print_tree(tree_node)
}

//For fn main

///|
fn main_() -> Unit {
  tesst() catch {
    e => println("Error: \{e}")
  }
}
```

#### 示例输出 / Example Output

```
./
├── src/
│   ├── main.mbt
│   └── utils.mbt
├── README.md
└── README.mbt.md
```

### 重要说明 / Important Notes

#### 路径解析机制 / Path Resolution Mechanism

**相对路径是相对于程序运行时的工作目录（CWD），而不是源代码文件所在的目录。**

**Relative paths are resolved relative to the Current Working Directory (CWD) where the program runs, NOT relative to the source code file location.**

这是因为底层实现：
- `build_tree()` 调用 `@fs.is_dir()` 和 `@fs.read_dir()`
- 这些函数通过 FFI 调用 C 标准库函数（`stat()`, `opendir()` 等）
- 路径解析由**操作系统内核**完成，遵循 POSIX 标准
- 相对路径基准点是进程的当前工作目录，由 shell 在启动程序时设置

This is because of the underlying implementation:
- `build_tree()` calls `@fs.is_dir()` and `@fs.read_dir()`
- These functions use FFI to call C standard library functions (`stat()`, `opendir()`, etc.)
- Path resolution is handled by the **OS kernel**, following POSIX standards
- The base directory for relative paths is the process's current working directory, set by the shell when the program starts

**示例 / Example:**

如果从 `/home/user/project/` 目录运行程序：  
If running the program from `/home/user/project/`:

```
build_tree(".")      → 遍历 /home/user/project/
                       Traverses /home/user/project/

build_tree("./src")  → 遍历 /home/user/project/src/
                       Traverses /home/user/project/src/

build_tree("../")    → 遍历 /home/user/
                       Traverses /home/user/
```

**建议 / Recommendations:**

1. 在项目根目录运行测试和程序 / Run tests and programs from the project root directory
2. 使用相对路径时要注意当前工作目录 / Be aware of the current working directory when using relative paths
3. 如需使用绝对路径可直接传入完整路径 / Use absolute paths if you need path independence


