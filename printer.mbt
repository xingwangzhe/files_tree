///|
/// Print a single file tree node (recursive helper function)
/// 打印单个文件树节点（递归辅助函数）
fn print_node(node : FileNode, prefix : String, is_last : Bool) -> Unit {
  // 选择分支符号
  let branch = if is_last { "└── " } else { "├── " }
  match node {
    File(name) =>
      // 打印文件
      println(prefix + branch + name)
    Directory(name, children) => {
      // 打印目录
      println(prefix + branch + name + "/")

      // 计算子节点的新前缀
      let new_prefix = if is_last { prefix + "    " } else { prefix + "│   " }

      // 递归打印所有子节点
      let len = children.length()
      for i = 0; i < len; i = i + 1 {
        print_node(children[i], new_prefix, i == len - 1)
      }
    }
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
    File(name) =>
      // 如果根节点是文件，直接打印
      println(name)
    Directory(name, children) => {
      // 打印根目录名
      println(name + "/")

      // 打印所有子节点
      let len = children.length()
      for i = 0; i < len; i = i + 1 {
        print_node(children[i], "", i == len - 1)
      }
    }
  }
}
