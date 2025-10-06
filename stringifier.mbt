///|
/// Convert a single file tree node to string (recursive helper function)
/// 将单个文件树节点转换为字符串（递归辅助函数）
fn node_to_string(node : FileNode, prefix : String, is_last : Bool) -> String {
  // 选择分支符号
  let branch = if is_last { "└── " } else { "├── " }
  match node {
    File(name) =>
      // 返回文件行
      prefix + branch + name + "\n"
    Directory(name, children) => {
      // 构建目录行
      let mut result = prefix + branch + name + "/\n"

      // 计算子节点的新前缀
      let new_prefix = if is_last { prefix + "    " } else { prefix + "│   " }

      // 递归处理所有子节点
      let len = children.length()
      for i = 0; i < len; i = i + 1 {
        result = result + node_to_string(children[i], new_prefix, i == len - 1)
      }
      result
    }
  }
}

///|
/// Convert the complete file tree to a multi-line string
/// 将完整的文件树转换为多行字符串
///
/// # Parameters
/// ## 参数
///
/// - `node`: The root node of the file tree
/// - `node`: 文件树的根节点
///
/// # Returns
/// ## 返回值
///
/// - `String`: A multi-line string representation of the file tree
/// - `String`: 文件树的多行字符串表示
///
/// # Examples
/// ## 示例
///
/// ```moonbit
/// let tree = build_tree(".")
/// let tree_str = tree_to_string(tree)
/// println(tree_str)
/// // Output:
/// // .
/// // ├── src/
/// // │   └── main.mbt
/// // └── README.md
/// ```
pub fn tree_to_string(node : FileNode) -> String {
  match node {
    File(name) =>
      // 如果根节点是文件，直接返回文件名
      name + "\n"
    Directory(name, children) => {
      // 构建根目录行
      let mut result = name + "/\n"

      // 处理所有子节点
      let len = children.length()
      for i = 0; i < len; i = i + 1 {
        result = result + node_to_string(children[i], "", i == len - 1)
      }
      result
    }
  }
}

///|
/// Test tree_to_string with simple file
/// 测试tree_to_string简单文件
test "tree_to_string simple file" {
  let tree = File("test.txt")
  let result = tree_to_string(tree)
  inspect(result, content="test.txt\n")
}

///|
/// Test tree_to_string with simple directory
/// 测试tree_to_string简单目录
test "tree_to_string simple directory" {
  let tree = Directory("test_dir", [File("file1.txt"), File("file2.txt")])
  let result = tree_to_string(tree)
  let expected = "test_dir/\n├── file1.txt\n└── file2.txt\n"
  inspect(result, content=expected)
}

///|
/// Test tree_to_string with nested directory
/// 测试tree_to_string嵌套目录
test "tree_to_string nested directory" {
  let subtree = Directory("subdir", [File("nested.txt")])
  let tree = Directory("root", [File("root.txt"), subtree])
  let result = tree_to_string(tree)
  let expected = "root/\n├── root.txt\n└── subdir/\n    └── nested.txt\n"
  inspect(result, content=expected)
}
