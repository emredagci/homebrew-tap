# typed: strict
# frozen_string_literal: true

# Written to emredagci/homebrew-tap by reprise's release workflow from packaging/homebrew/reprise.rb.in in
# emredagci/reprise; edit that file. Installed with `brew install emredagci/tap/reprise`.
class Reprise < Formula
  desc "Second brain for your coding agent"
  homepage "https://github.com/emredagci/reprise"
  version "0.2.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/emredagci/reprise/releases/download/0.2.2/reprise-0.2.2-macos-arm64.tar.gz"
      sha256 "e0612d03c843109cea43922b2972ddd475ba30ccf60094a5397c37b51e945ea8"
    end
    on_intel do
      url "https://github.com/emredagci/reprise/releases/download/0.2.2/reprise-0.2.2-macos-x86_64.tar.gz"
      sha256 "2704aa93e7f6806f60b72d5ddca1bdcca074d81c6824690251afc0b2bc28fe8b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/emredagci/reprise/releases/download/0.2.2/reprise-0.2.2-linux-arm64.tar.gz"
      sha256 "d91b8c0fae256ac7f8f93e2d7d8cedfcee889de6aab4360d79fff46614f7ff22"
    end
    on_intel do
      url "https://github.com/emredagci/reprise/releases/download/0.2.2/reprise-0.2.2-linux-x86_64.tar.gz"
      sha256 "4e2861485fbd39a24560b29e26935541f7fd4e57873dccbab83fadc905396ca6"
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
