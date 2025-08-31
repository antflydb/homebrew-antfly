class Antflycli < Formula
  desc "Command-line interface for interacting with AntflyDB"
  homepage "https://antfly.io"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/antflydb/antfly/releases/download/v#{version}/antfly_#{version}_Darwin_x86_64.tar.gz"
      sha256 ""
    end
    if Hardware::CPU.arm?
      url "https://github.com/antflydb/antfly/releases/download/v#{version}/antfly_#{version}_Darwin_arm64.tar.gz"
      sha256 ""
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/antflydb/antfly/releases/download/v#{version}/antfly_#{version}_Linux_x86_64.tar.gz"
      sha256 ""
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/antflydb/antfly/releases/download/v#{version}/antfly_#{version}_Linux_arm64.tar.gz"
      sha256 ""
    end
  end

  def install
    bin.install "antflycli"

    # Install shell completions
    generate_completions_from_executable(bin/"antflycli", "completion")
  end

  test do
    system "#{bin}/antflycli", "--version"
  end
end
