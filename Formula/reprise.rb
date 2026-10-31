# typed: strict
# frozen_string_literal: true

# Written to emredagci/homebrew-tap by reprise's release workflow from packaging/homebrew/reprise.rb.in in
# emredagci/reprise; edit that file. Installed with `brew install emredagci/tap/reprise`.
class Reprise < Formula
  desc "Second brain for your coding agent"
  homepage "https://github.com/emredagci/reprise"
  version "0.2.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/emredagci/reprise/releases/download/0.2.1/reprise-0.2.1-macos-arm64.tar.gz"
      sha256 "7928d351968801cb90a11063daacc9031a7d7fd575149c0a49239c896463f8f5"
    end
    on_intel do
      url "https://github.com/emredagci/reprise/releases/download/0.2.1/reprise-0.2.1-macos-x86_64.tar.gz"
      sha256 "b99f10bee69ac17a92b741a8f895fbc6a2d4196777b61c2c4eae3c1650f5c664"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/emredagci/reprise/releases/download/0.2.1/reprise-0.2.1-linux-arm64.tar.gz"
      sha256 "acd041a7665fd760f50fc4ee8e46d5ebfca41a513e185eb749f8ab6725f77651"
    end
    on_intel do
      url "https://github.com/emredagci/reprise/releases/download/0.2.1/reprise-0.2.1-linux-x86_64.tar.gz"
      sha256 "0a717c1ce5b52529b1c2ed486a187c463266add90aaff31d23afd75f376ede26"
    end
  end

  def install
    bin.install "reprise"
  end

  def caveats
    <<~EOS
      Choose the vault and the folders reprise may read, then connect Claude Code:
        reprise setup set --vault <folder> --auto
        reprise connect claude --yes
      To have this computer distill finished sessions by itself:
        reprise sweep schedule
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/reprise --version")
    ENV["REPRISE_SETTINGS"] = (testpath/"settings.json").to_s
    (testpath/"vault").mkpath
    system bin/"reprise", "setup", "set", "--vault", testpath/"vault", "--auto"
    assert_path_exists testpath/"vault/.reprise/vault.toml"
  end
end
