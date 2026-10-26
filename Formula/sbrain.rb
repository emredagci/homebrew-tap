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
      sha256 "1702b7814e7c879953613c75bd001f21fba1566fea48729dd9334e8336ca1918"
    end
    on_intel do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "632cd14f19c1937ae07b21f07cfd93b2145731b005a08dc55ac716aaf5607e46"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5d2428df4d13fe61fabd64e6d5468d5f4ccc1a698d015a392c0b85b19d06657"
    end
    on_intel do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eff440e96749d04c3cb017e5575761267122d28aa988f946583fc2cbe4cd5108"
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
