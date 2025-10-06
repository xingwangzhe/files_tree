///|
/// Print a single file tree node (recursive helper function)
/// 打印单个文件树节点（递归辅助函数）
fn print_node(node : FileNode, prefix : String, is_last : Bool) -> Unit {
  let branch = get_print_branch_symbol(is_last)
  match node {
    File(name) => print_file_node(prefix, branch, name)
    Directory(name, children) =>
      print_directory_node(prefix, branch, name, children, is_last)
  }
}

///|
/// Get the appropriate branch symbol for printing
/// 获取适当的打印分支符号
fn get_print_branch_symbol(is_last : Bool) -> String {
  if is_last {
    "└── "
  } else {
    "├── "
  }
}

///|
/// Print a file node
/// 打印文件节点
fn print_file_node(prefix : String, branch : String, name : String) -> Unit {
  println(prefix + branch + name)
}

///|
/// Print a directory node and its children
/// 打印目录节点及其子节点
fn print_directory_node(
  prefix : String,
  branch : String,
  name : String,
  children : Array[FileNode],
  is_last : Bool,
) -> Unit {
  println(prefix + branch + name + "/")
  let new_prefix = calculate_print_child_prefix(prefix, is_last)
  print_all_children(children, new_prefix)
}

///|
/// Calculate prefix for child nodes in printing
/// 计算打印中子节点的前缀
fn calculate_print_child_prefix(prefix : String, is_last : Bool) -> String {
  if is_last {
    prefix + "    "
  } else {
    prefix + "│   "
  }
}

///|
/// Print all children nodes
/// 打印所有子节点
fn print_all_children(children : Array[FileNode], prefix : String) -> Unit {
  let len = children.length()
  for i = 0; i < len; i = i + 1 {
    print_node(children[i], prefix, i == len - 1)
  }
}

///|
/// Print the complete ASCII file tree
/// 打印完整的 ASCII 文件树
///
/// # Parameters
/// ## 参数
///
/// - `node`: The root node of the file tree
/// - `node`: 文件树的根节点
///
/// # Examples
/// ## 示例
///
/// ```moonbit
/// let tree = build_tree(".")
/// print_tree(tree)
/// // Output:
/// // .
/// // ├── src/
/// // │   └── main.mbt
/// // └── README.md
/// ```
pub fn print_tree(node : FileNode) -> Unit {
  match node {
    File(name) => print_root_file(name)
    Directory(name, children) => print_root_directory(name, children)
  }
}

///|
/// Print root file node
/// 打印根文件节点
fn print_root_file(name : String) -> Unit {
  println(name)
}

///|
/// Print root directory node and its children
/// 打印根目录节点及其子节点
fn print_root_directory(name : String, children : Array[FileNode]) -> Unit {
  println(name + "/")
  print_all_children(children, "")
}
