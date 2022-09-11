require "slim"

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :directory_indexes

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

redirect "charging-curve/index.html", to: "/reference/#charging-curve"
redirect "paint/index.html", to: "/reference/#paint"
redirect "safety/index.html", to: "/reference/#safety"

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def site_title
    "Honda e Knowledge Base"
  end

  def page_title
    current_page.data.title
  end

  def og_description
    current_page.data.og_description || "Tips and resources for owners (and prospective owners!) of the Honda e."
  end

  def markdown(text)
    text = text.gsub(/\[\[manual (\d+)(?:–(\d+))?\]\]/) { link_to_manual($1.to_i.nonzero?, $2.to_i.nonzero?) }

    Kramdown::Document.new(text).to_html
  end

  def inline_markdown(text)
    markdown(text).strip.sub(%r{<p>(.*)</p>}m, '\1')
  end

  # Always link to the 2020 manual since the 2021 manual has some broken images, at least on some platforms.
  def link_to_manual(first_page, last_page = nil)
    text = "2020 manual, #{last_page ? "pp. #{first_page}–#{last_page}" : "p. #{first_page}"}"
    url = "https://www.honda.co.uk/cars/owners/manuals-and-guides/honda-owners-manuals/_jcr_content/par1/textcolumnwithimagem_2131108407/textColumn/richtextdownload_8ec/file.res/32TYF6010_web%20EN_compressed.pdf#page=#{first_page + 1}"

    link_to(text, url)
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
