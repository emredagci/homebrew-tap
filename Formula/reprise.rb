# typed: strict
# frozen_string_literal: true

# Written to emredagci/homebrew-tap by reprise's release workflow from packaging/homebrew/reprise.rb.in in
# emredagci/reprise; edit that file. Installed with `brew install emredagci/tap/reprise`.
class Reprise < Formula
  desc "Second brain for your coding agent"
  homepage "https://github.com/emredagci/reprise"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/emredagci/reprise/releases/download/0.2.0/reprise-0.2.0-macos-arm64.tar.gz"
      sha256 "bf475080ad020b51402b6097f0e699935cac5a60678b24ed86cc199ad62e5a0c"
    end
    on_intel do
      url "https://github.com/emredagci/reprise/releases/download/0.2.0/reprise-0.2.0-macos-x86_64.tar.gz"
      sha256 "f8a1b037bf29e7c935cbab963a4735adc576e18a43041c9a870aeb104fd106b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/emredagci/reprise/releases/download/0.2.0/reprise-0.2.0-linux-arm64.tar.gz"
      sha256 "0650e52a66d9d5bbb9527582239f105338d2505a08fb1cfb26f87eb234fa383a"
    end
    on_intel do
      url "https://github.com/emredagci/reprise/releases/download/0.2.0/reprise-0.2.0-linux-x86_64.tar.gz"
      sha256 "cb9cab8a87d8bdf44cd533e08ffbd3680802fdeb20bab6e1b92cf88f39322363"
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
