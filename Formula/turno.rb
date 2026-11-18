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
    # Exactly the dependency tree that was tested: `npm ci` installs the npm-shrinkwrap.json the
    # package ships and fails instead of resolving anything else. No install scripts run (the
    # package has none). The devDependencies are build tools the shrinkwrap leaves out, and
    # `npm ci` checks them even with --omit=dev, so they go first.
    manifest = JSON.parse(File.read("package.json"))
    manifest.delete("devDependencies")
    File.write("package.json", JSON.pretty_generate(manifest))

    # The npm layout, so `turno upgrade` and `turno version` still see a Homebrew install.
    package = libexec/"lib/node_modules/turno-cli"
    package.install Dir["*"]
    cd package do
      system "npm", "ci", "--omit=dev", "--ignore-scripts", "--no-audit", "--no-fund",
             "--cache=#{HOMEBREW_CACHE}/npm_cache"
    end
    chmod 0755, package/"dist/cli/main.js"
    bin.install_symlink package/"dist/cli/main.js" => "turno"
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
    # The installed tree is the shipped shrinkwrap, nothing more and nothing less.
    cd libexec/"lib/node_modules/turno-cli" do
      system "npm", "ls", "--omit=dev", "--all"
    end
  end
end
