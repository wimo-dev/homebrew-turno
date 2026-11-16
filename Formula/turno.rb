class Turno < Formula
  desc "One MCP gateway and per-folder accounts for coding agents"
  homepage "https://github.com/wimo-dev/turno"
  url "https://registry.npmjs.org/turno-cli/-/turno-cli-0.1.1.tgz"
  sha256 "0e8b1fb14881b18c6ea7daab5cf46fa9f197639e2cf3d613a596c239306ac21b"
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
      Upgrade turno with brew, not with `turno upgrade`:
        brew upgrade turno
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
