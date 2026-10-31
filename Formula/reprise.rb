# typed: strict
# frozen_string_literal: true

# Written to emredagci/homebrew-tap by reprise's release workflow from packaging/homebrew/reprise.rb.in in
# emredagci/reprise; edit that file. Installed with `brew install emredagci/tap/reprise`.
class Reprise < Formula
  desc "Second brain for your coding agent"
  homepage "https://github.com/emredagci/reprise"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/emredagci/reprise/releases/download/0.3.0/reprise-0.3.0-macos-arm64.tar.gz"
      sha256 "32c1c7685b68f645bb758bd22c237b6b3faa9435faa3048c65f51f92a507e899"
    end
    on_intel do
      url "https://github.com/emredagci/reprise/releases/download/0.3.0/reprise-0.3.0-macos-x86_64.tar.gz"
      sha256 "537a465c88735c4823e71f6d06e2313348f15aa55447bc3d80aff87cc846129f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/emredagci/reprise/releases/download/0.3.0/reprise-0.3.0-linux-arm64.tar.gz"
      sha256 "220e005ef0983cba15dfb27e5b6488f82a2ae988be20c18a5cfc2d664af096d2"
    end
    on_intel do
      url "https://github.com/emredagci/reprise/releases/download/0.3.0/reprise-0.3.0-linux-x86_64.tar.gz"
      sha256 "cb2174c23e986728e20e9dcbea065551473b3be64e921477d32c68f667992943"
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
