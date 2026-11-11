class Pahest < Formula
  desc "Local backup for AI apps: Claude Code and Codex sessions, readable offline"
  homepage "https://github.com/pahest/pahest"
  url "https://github.com/pahest/pahest/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "bb9e69b3f5d78e608e670ef6b1e95aeec53cfdd86ce56d345ba985afddb36d72"
  license "MIT"

  depends_on :macos
  depends_on "python@3.15"

  def install
    # Pahest uses only Python's standard library: the package is copied as it is.
    libexec.install "src/pahest"
    (bin/"pahest").write <<~SH
      #!/bin/sh
      PYTHONPATH="#{libexec}" exec "#{formula_opt_bin("python@3.15")}/python3.15" -m pahest "$@"
    SH
  end

  test do
    assert_match "pahest #{version}", shell_output("#{bin}/pahest --version")
    assert_path_exists libexec/"pahest/templates/page.html"
  end
end
