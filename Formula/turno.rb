class Turno < Formula
  desc "One MCP gateway and per-folder accounts for coding agents"
  homepage "https://github.com/wimo-dev/turno"
  url "https://registry.npmjs.org/turno-cli/-/turno-cli-0.2.0.tgz"
  sha256 "02c67ef72f87267c90b55401bac25f3be63d30c3c14aaaebd2458a2d4bf2ca6a"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/turno-cli/latest"
    regex(/"version":\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      Upgrade with `brew upgrade turno` (`turno upgrade` runs it for you).
      Start with:
        turno doctor
    EOS
  end

  test do
    assert_match "turno #{version}", shell_output("#{bin}/turno --version")
    ENV["TURNO_NO_UPDATE_CHECK"] = "1"
    assert_match "turno", shell_output("#{bin}/turno doctor --json")
  end
end
