int LineCount = 0;
def count_clos = { file ->
    int lines = 0;
    if (file.path.indexOf('.git') >= 0 || file.isDirectory()) {
        return
    }
    if (!(
    file.path.endsWith('.cpp') || file.path.endsWith('.h') ||
    file.path.endsWith('.rb') || file.path.endsWith('.racc') ||
    file.path.endsWith('.asm')
    )) {
        return
    }
    file.eachLine {
        lines++;
    }
    println("${file.path}: ${lines}");
    LineCount += lines;
}
(new File('.')).eachFileRecurse(count_clos)

println("Total: ${LineCount} lines")
