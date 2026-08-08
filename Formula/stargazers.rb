# typed: false
# frozen_string_literal: true

class Stargazers < Formula
  desc "CLI tool to fetch, analyze, and summarize GitHub stargazers and forkers"
  homepage "https://github.com/wdm0006/stargazers"
  url "https://github.com/wdm0006/stargazers/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "fa090d3759f70a113ba3ea31d9e42697e1332bdc5c26f18d32417345c4544c60"
  license "MIT"

  depends_on "python@3.13"
  depends_on "uv"

  def install
    ENV["UV_CACHE_DIR"] = buildpath/"uv-cache"
    system "uv", "venv", "--python", Formula["python@3.13"].opt_bin/"python3.13", libexec
    system "uv", "pip", "install", "--python", libexec/"bin/python", buildpath
    bin.install_symlink libexec/"bin/stargazers"
  end

  test do
    system bin/"stargazers", "--help"
  end
end
