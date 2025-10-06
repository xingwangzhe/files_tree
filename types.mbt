///|
/// File tree node representation
/// 文件树节点表示
///
/// This enum represents either a file or a directory in the file system tree.
/// 此枚举表示文件系统树中的文件或目录。
///
/// # Variants
/// 
///
/// - `File(String)`: Represents a file with its name
/// - `Directory(String, Array[FileNode])`: Represents a directory with its name and child nodes
/// - `File(String)`: 表示具有名称的文件
/// - `Directory(String, Array[FileNode])`: 表示具有名称和子节点列表的目录
pub enum FileNode {
  File(String) // File node, stores filename / 文件节点，存储文件名
  Directory(String, Array[FileNode]) // Directory node, stores directory name and children / 目录节点，存储目录名和子节点
}

///|
/// Show implementation for FileNode
/// FileNode 的 Show 实现
///
/// Provides a string representation of FileNode for debugging and display.
/// 为 FileNode 提供字符串表示，用于调试和显示。
pub impl Show for FileNode with output(self, logger) {
  match self {
    File(name) => logger.write_string("File(\{name})")
    Directory(name, children) =>
      logger.write_string("Directory(\{name}, [\{children.length()} children])")
  }
}
