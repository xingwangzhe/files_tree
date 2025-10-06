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
    build_directory_node(path, name)
  } else {
    build_file_node(name)
  }
}

///|
/// Build a file node
/// 构建文件节点
fn build_file_node(name : String) -> FileNode {
  File(name)
}

///|
/// Build a directory node with its children
/// 构建包含子节点的目录节点
fn build_directory_node(
  path : String,
  name : String,
) -> FileNode raise @fs.IOError {
  let children = read_and_build_children(path)
  Directory(name, children)
}

///|
/// Read directory entries and build child nodes
/// 读取目录条目并构建子节点
fn read_and_build_children(path : String) -> Array[FileNode] raise @fs.IOError {
  let entries = @fs.read_dir(path)
  let children : Array[FileNode] = []
  for i = 0; i < entries.length(); i = i + 1 {
    let child_node = build_child_node(path, entries[i])
    children.push(child_node)
  }
  children
}

///|
/// Build a single child node
/// 构建单个子节点
fn build_child_node(
  parent_path : String,
  entry_name : String,
) -> FileNode raise @fs.IOError {
  let full_path = join_path(parent_path, entry_name)
  build_tree(full_path)
}

///|
/// Get the basename of a path (pure function implementation)
/// 获取路径的基本名称（纯函数实现）
fn get_basename(path : String) -> String {
  let parts = split_path_by_unix_separator(path)
  extract_basename_from_parts(parts, path)
}

///|
/// Split path by Unix separator
/// 按 Unix 分隔符分割路径
fn split_path_by_unix_separator(path : String) -> Array[String] {
  path.split("/").map(fn(s) { s.to_string() }).collect()
}

///|
/// Extract basename from path parts
/// 从路径部分提取基本名称
fn extract_basename_from_parts(
  parts : Array[String],
  original_path : String,
) -> String {
  let len = parts.length()
  if len == 0 {
    return original_path
  }
  let last = parts[len - 1].to_string()
  if is_empty_string(last) {
    handle_trailing_slash(parts, len, original_path)
  } else if contains_windows_separator(last) {
    extract_windows_basename(last)
  } else {
    last
  }
}

///|
/// Check if string is empty
/// 检查字符串是否为空
fn is_empty_string(s : String) -> Bool {
  s == ""
}

///|
/// Handle path with trailing slash
/// 处理带尾部斜杠的路径
fn handle_trailing_slash(
  parts : Array[String],
  len : Int,
  fallback : String,
) -> String {
  if len >= 2 {
    parts[len - 2].to_string()
  } else {
    fallback
  }
}

///|
/// Check if path contains Windows separator
/// 检查路径是否包含 Windows 分隔符
fn contains_windows_separator(s : String) -> Bool {
  s.contains("\\")
}

///|
/// Extract basename from Windows path
/// 从 Windows 路径提取基本名称
fn extract_windows_basename(path : String) -> String {
  let win_parts = path.split("\\").collect()
  let win_len = win_parts.length()
  if win_len > 0 {
    win_parts[win_len - 1].to_string()
  } else {
    path
  }
}

///|
/// Join parent and child paths (cross-platform)
/// 连接父路径和子路径（跨平台）
fn join_path(parent : String, child : String) -> String {
  if has_trailing_separator(parent) {
    parent + child
  } else {
    let separator = detect_path_separator(parent)
    parent + separator + child
  }
}

///|
/// Check if path has trailing separator
/// 检查路径是否有尾部分隔符
fn has_trailing_separator(path : String) -> Bool {
  path.has_suffix("/") || path.has_suffix("\\")
}

///|
/// Detect the appropriate path separator for a given path
/// 检测给定路径的适当路径分隔符
fn detect_path_separator(path : String) -> String {
  if path.contains("\\") {
    "\\"
  } else {
    "/"
  }
}
