class Md2pdf < Formula
  desc "Convert Markdown files with Mermaid diagrams to PDF"
  homepage "https://github.com/Cpicon/md2pdf"
  head "https://github.com/Cpicon/md2pdf.git", branch: "main"

  depends_on "node"
  depends_on "python@3"

  def install
    bin.install "bin/md2pdf"
  end

  def post_install
    ohai "Installing npm dependencies..."

    system "npm", "install", *std_npm_args(global: true), "md-to-pdf@5.2.4" unless which("md-to-pdf")
    system "npm", "install", *std_npm_args(global: true), "@mermaid-js/mermaid-cli@11.9.0" unless which("mmdc")
  end

  def caveats
    <<~EOS
      md2pdf has been installed!

      Dependencies:
        - md-to-pdf (npm package)
        - @mermaid-js/mermaid-cli (npm package)

      If you encounter issues, ensure npm packages are installed:
        npm install -g md-to-pdf @mermaid-js/mermaid-cli

      Usage:
        md2pdf document.md
        md2pdf document.md output.pdf
    EOS
  end

  test do
    # Test that the command exists
    assert_match "Usage:", shell_output("#{bin}/md2pdf 2>&1", 1)
  end
end
