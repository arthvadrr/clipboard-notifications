@main
public struct macos {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(macos().text)
    }
}
