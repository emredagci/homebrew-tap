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
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-macos-arm64.tar.gz"
      sha256 "8f91bd6699440ef1629d5ac59a578243997c7ccbac2a021f95574506aed73c15"
    end
    on_intel do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-macos-x86_64.tar.gz"
      sha256 "a9622665daf05e4a8b2b5758d5896348ef55e319cead74d7992c0e3ba48124e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-linux-arm64.tar.gz"
      sha256 "353cc99c15e87c7eb60923ff62dbe3a5a3bb97f9897efa1948da4c9144c61977"
    end
    on_intel do
      url "https://github.com/emredagci/sbrain/releases/download/0.1.0/sbrain-0.1.0-linux-x86_64.tar.gz"
      sha256 "dc8914af975af9f499277451233e11735c20003f001cc73c8f2e8e03ccae8c8c"
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
