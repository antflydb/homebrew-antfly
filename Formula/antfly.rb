# typed: false
# frozen_string_literal: true

class Antfly < Formula
  desc "Native Zig AntflyDB runtime"
  homepage "https://docs.antfly.io"
  license "Elastic-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://releases.antfly.io/antfly/v0.2.0/antfly_0.2.0_Darwin_arm64.tar.gz"
      sha256 "82690d5c7e7cac5f7cd56c46ced8f4dd9acace577fb7982060667bcdb2632db6"
    else
      odie "antfly supports Apple Silicon macOS only"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://releases.antfly.io/antfly/v0.2.0/antfly_0.2.0_Linux_arm64.tar.gz"
      sha256 "a4993e854f4c7676708602b2765113f0caad8b8b1097e6c12fac5f562be16ac6"
    else
      url "https://releases.antfly.io/antfly/v0.2.0/antfly_0.2.0_Linux_x86_64.tar.gz"
      sha256 "1eb63abba8d0608355a075e3a39586ee72d9c8a4870ba2365558cea2b7d3defe"
    end
  end

  def install
    bin.install "antfly"
    include.install Dir["include/*"] if Dir.exist?("include")
    lib.install Dir["lib/*"] if Dir.exist?("lib")
    (share/"antfly").install Dir["share/antfly/*"] if Dir.exist?("share/antfly")
  end

  service do
    run [opt_bin/"antfly", "standalone", "--data-dir", var/"lib/antfly"]
    keep_alive true
    working_dir var/"lib/antfly"
    log_path var/"log/antfly.log"
    error_log_path var/"log/antfly.err.log"
  end

  def post_install
    (var/"lib/antfly").mkpath
  end

  test do
    system "#{bin}/antfly", "--help"
  end

  def caveats
    <<~EOS
      antfly is now the native Zig runtime.

      Existing data directories created by the Go/omni runtime are not opened
      in place. Create a portable backup with the previous Go/omni runtime,
      start the Zig runtime with a fresh data directory, then restore the backup.

      The Go/omni runtime remains available as:
        brew install antflydb/taps/antfly-go

      Start the local single-node service with:
        brew services start antflydb/taps/antfly
    EOS
  end
end
