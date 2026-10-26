# typed: strict
# frozen_string_literal: true

# Written to emredagci/homebrew-tap by sbrain's release workflow from packaging/homebrew/sbrain.rb.in in
# emredagci/sbrain; edit that file. Installed with `brew install emredagci/tap/sbrain`.
class Sbrain < Formula
  desc "Second brain for your coding agent"
  homepage "https://github.com/emredagci/sbrain"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "a002ccc6a5f91e034ee8d4e4c05243027adccfb97f17459456a3adcbf7fa2256"
    end
    on_intel do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "e6cf0bb426d031684708ab39b812f18193aeaf422f8758987d424f8b1ee021e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6ab90086ba956e5733cb5ecc2a4d013775c45b7ed963fd2222b805d1cc4e1920"
    end
    on_intel do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6a70aed0d9be0e6ad9a8eee9d9acab26e0588bae2e7bdfacc609d4c31e14ee1"
    end
  end

  def install
    bin.install "sbrain"
  end

  def caveats
    <<~EOS
      Choose the vault and the folders sbrain may read, then connect Claude Code:
        sbrain setup set --vault <folder> --auto
        sbrain connect claude --yes
      To have this computer distill finished sessions by itself:
        sbrain sweep schedule
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sbrain --version")
    ENV["SBRAIN_SETTINGS"] = (testpath/"settings.json").to_s
    (testpath/"vault").mkpath
    system bin/"sbrain", "setup", "set", "--vault", testpath/"vault", "--auto"
    assert_path_exists testpath/"vault/.sbrain/vault.toml"
  end
end
