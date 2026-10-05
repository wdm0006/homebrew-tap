# typed: false
# frozen_string_literal: true

class Stargazers < Formula
  desc "CLI tool to fetch, analyze, and summarize GitHub stargazers and forkers"
  homepage "https://github.com/wdm0006/stargazers"
  url "https://github.com/wdm0006/stargazers/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "4ef7db2e8895a5ba89f2ba419fd466352e06dcabf118c423f843c619fe85a091"
  license "MIT"

  depends_on "python@3.13"
  depends_on "uv"

  def install
    ENV["UV_CACHE_DIR"] = buildpath/"uv-cache"
    system "uv", "venv", "--python", formula_opt_bin("python@3.13")/"python3.13", libexec
    system "uv", "pip", "install", "--python", libexec/"bin/python", "plotext<6", buildpath
    bin.install_symlink libexec/"bin/stargazers"
  end

  test do
    system bin/"stargazers", "--help"

    (testpath/"acct_account_stars_by_day.csv").write <<~CSV
      star_date,total_new_stars_on_day,total_cumulative_stars_up_to_day
      2024-01-01,2,2
      2024-01-02,3,5
      2024-01-03,1,6
    CSV

    system bin/"stargazers", "plot",
           "--file", testpath/"acct_account_stars_by_day.csv",
           "--type", "account-trend"
  end
end
