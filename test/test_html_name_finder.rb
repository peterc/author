require_relative 'helper'

describe HTMLNameFinder do
  before do
    @basic_doc = %{
      <html>
      <head>
        <meta property="og:site_name" content="SITE_NAME"/>
        <meta property="article:author" content="ARTICLE_AUTHOR"  />
        <meta name="author" itemprop="creator" content="AUTHOR_CREATOR"/>
        <meta name=author content="AUTHOR"/>
        <meta name="octolytics-dimension-user_login" content="GITHUB_LOGIN" />
        <meta property="og:article:author" content="OG_ARTICLE_AUTHOR" />
      </head>
      <body>
        <div class="authorname"><a href="">AUTHORNAME</a></div>
        <div class="author">AUTHOR</div>
        <div class="attribution">ATTRIBUTION</div>
        <div class="by-line"><a href="">BY_LINE_LINK</a></div>
        <div class="byline"><a class="fn" href="">BYLINE_LINK</a></div>
        <div class="blogger-description">BLOGGER_DESCRIPTION</div>
        <div class="by"><a href="">BY_LINK</a></div>
        <div class="author_name">AUTHOR_NAME</div>
        <div class="authorship"><img alt="IMG_ALT_NAME" /></div>
      </body>
      </html>
    }

    @finder = HTMLNameFinder.new(@basic_doc)
  end

  it "can find simple names" do
    %w{AUTHOR AUTHORNAME ATTRIBUTION BY_LINE_LINK BYLINE_LINK BLOGGER_DESCRIPTION BY_LINK AUTHOR_NAME IMG_ALT_NAME}.each do |name|
      @finder.names.must_include name
    end
  end
end
