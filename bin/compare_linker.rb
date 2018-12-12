require 'compare_linker'

repo_full_name = ENV['REPO_FULL_NAME']
pr_number      = ENV['PR_NUMBER']

compare_linker = CompareLinker.new(repo_full_name, pr_number)
compare_linker.formatter = CompareLinker::Formatter::Markdown.new

comment = <<~COMMENT
  **Updated RubyGems:**

  #{compare_linker.make_compare_links.to_a.join("\n")}

  Powered by [compare_linker](https://rubygems.org/gems/compare_linker)
COMMENT

compare_linker.add_comment(repo_full_name, pr_number, comment)
puts comment
