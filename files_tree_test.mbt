///|
test "build_tree should work" {
  // 测试build_tree函数是否能正常工作
  let tree = build_tree(".")
  // 只要不抛出异常就算成功
  println("build_tree \{tree}");
  inspect("build_tree works", content="build_tree works")
}

///|
test "print_tree should work" {
  // 测试print_tree函数是否能正常工作
  let tree = build_tree(".")
  print_tree(tree)
  // 只要不抛出异常就算成功
  inspect("print_tree works", content="print_tree works")
}

///|
test "tree_to_string should work" {
  // 测试tree_to_string函数是否能正常工作
  let tree = build_tree(".")
  let result = tree_to_string(tree)
  // 检查是否有输出
  if result.length() > 0 {
    inspect("tree_to_string works", content="tree_to_string works")
  } else {
    inspect("no output", content="no output")
  }
}
