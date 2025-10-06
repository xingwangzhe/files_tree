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
fn example() -> Unit raise @fs.IOError {
  // 构建文件树 / Build file tree
  let tree = build_tree(".")

  // 直接打印 / Print directly
  print_tree(tree)

  // 或获取字符串 / Or get string representation
  let tree_str = tree_to_string(tree)
  println(tree_str)
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


