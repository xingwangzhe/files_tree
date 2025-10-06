///|
pub enum FileNode {
  File(String) // 文件节点，存储文件名
  Directory(String, Array[FileNode]) // 目录节点，存储目录名和子节点
}
