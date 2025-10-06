///|
/// Recursively build file tree from path
/// 从路径递归构建文件树
///
/// # Parameters
/// ## 参数
///
/// - `path`: The path string to traverse
/// - `path`: 要遍历的路径字符串
///
/// # Returns
/// ## 返回值
///
/// - `FileNode`: The file tree node
/// - `FileNode`: 文件树节点
///
/// # Errors
/// ## 错误
///
/// - Raises `@fs.IOError` if file system operations fail
/// - 如果文件系统操作失败则抛出 `@fs.IOError`
pub fn build_tree(path : String) -> FileNode raise @fs.IOError {
  let name = get_basename(path)
  if @fs.is_dir(path) {
    // 是目录，读取所有子项并递归构建
    let entries = @fs.read_dir(path)
    let children : Array[FileNode] = []
    for i = 0; i < entries.length(); i = i + 1 {
      let entry = entries[i]
      let full_path = join_path(path, entry)
      children.push(build_tree(full_path))
    }
    Directory(name, children)
  } else {
    // 是文件
    File(name)
  }
}

///|
/// Get the basename of a path (pure function implementation)
/// 获取路径的基本名称（纯函数实现）
fn get_basename(path : String) -> String {
  let parts = path.split("/").collect()
  let len = parts.length()
  if len == 0 {
    return path
  }
  let last = parts[len - 1].to_string()
  if last == "" {
    // 处理以"/"结尾的路径
    if len >= 2 {
      parts[len - 2].to_string()
    } else {
      path
    }
  } else if last.contains("\\") {
    let win_parts = last.split("\\").collect()
    let win_len = win_parts.length()
    if win_len > 0 {
      win_parts[win_len - 1].to_string()
    } else {
      last
    }
  } else {
    last
  }
}

///|
/// Join parent and child paths (cross-platform)
/// 连接父路径和子路径（跨平台）
fn join_path(parent : String, child : String) -> String {
  if parent.has_suffix("/") || parent.has_suffix("\\") {
    parent + child
    // 根据父路径的类型决定分隔符
  } else if parent.contains("\\") {
    parent + "\\" + child
  } else {
    parent + "/" + child
  }
}
