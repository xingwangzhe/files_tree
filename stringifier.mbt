///|
/// Convert a single file tree node to string (recursive helper function)
/// 将单个文件树节点转换为字符串（递归辅助函数）
fn node_to_string(node : FileNode, prefix : String, is_last : Bool) -> String {
  let branch = get_branch_symbol(is_last)
  match node {
    File(name) => format_file_line(prefix, branch, name)
    Directory(name, children) =>
      format_directory_tree(prefix, branch, name, children, is_last)
  }
}

///|
/// Get the appropriate branch symbol
/// 获取适当的分支符号
fn get_branch_symbol(is_last : Bool) -> String {
  if is_last {
    "└── "
  } else {
    "├── "
  }
}

///|
/// Format a file line
/// 格式化文件行
fn format_file_line(prefix : String, branch : String, name : String) -> String {
  prefix + branch + name + "\n"
}

///|
/// Format a directory tree
/// 格式化目录树
fn format_directory_tree(
  prefix : String,
  branch : String,
  name : String,
  children : Array[FileNode],
  is_last : Bool,
) -> String {
  let mut result = format_directory_line(prefix, branch, name)
  let new_prefix = calculate_child_prefix(prefix, is_last)
  result = result + format_children_string(children, new_prefix)
  result
}

///|
/// Format a directory line
/// 格式化目录行
fn format_directory_line(
  prefix : String,
  branch : String,
  name : String,
) -> String {
  prefix + branch + name + "/\n"
}

///|
/// Calculate prefix for child nodes
/// 计算子节点的前缀
fn calculate_child_prefix(prefix : String, is_last : Bool) -> String {
  if is_last {
    prefix + "    "
  } else {
    prefix + "│   "
  }
}

///|
/// Format all children to string
/// 将所有子节点格式化为字符串
fn format_children_string(
  children : Array[FileNode],
  prefix : String,
) -> String {
  let mut result = ""
  let len = children.length()
  for i = 0; i < len; i = i + 1 {
    result = result + node_to_string(children[i], prefix, i == len - 1)
  }
  result
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
    File(name) => format_root_file(name)
    Directory(name, children) => format_root_directory(name, children)
  }
}

///|
/// Format root file node
/// 格式化根文件节点
fn format_root_file(name : String) -> String {
  name + "\n"
}

///|
/// Format root directory node
/// 格式化根目录节点
fn format_root_directory(name : String, children : Array[FileNode]) -> String {
  let mut result = name + "/\n"
  result = result + format_children_string(children, "")
  result
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
