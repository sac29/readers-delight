require 'openssl'
class ArticlesService

  def fetch_data(tag)
    url = "https://medium.com/tag/#{tag}"
    posts = Nokogiri::HTML(open(url));''

    posts.search(".postArticle-readMore a").each do |link|
      url = link.attr('href')
      medium_in_url(url)
    end
  end

  private

  def medium_in_url(url)
    nokogiri_resp = nokogiri_response(url)

    author_name = nokogiri_resp.css('a.ds-link.ds-link--styleSubtle.ui-captionStrong.u-inlineBlock.link.link--darken.link--darker').text
    author_name = nokogiri_resp.css('a.postMetaInline--author').text if author_name.blank?
    if nokogiri_resp.css('.postMetaInline').text.present?
      author_title = nokogiri_resp.css('.postMetaInline').text
    else
      author_title = nokogiri_resp.css('.ui-summary').text
    end

    author = create_author(author_name, author_title)
    if nokogiri_resp.css('h1.graf--title').text.present?
      title = nokogiri_resp.css('h1.graf--title').text
    else
      title = nokogiri_resp.css('h1.elevate-h1').text
    end
    title = "An article from medium" if title.blank?
    contentParagraphs = nokogiri_resp.css('.graf--p') # array containing all the paragraph
    contentArray =  contentParagraphs.map{|paragraph| paragraph.text}
    content = contentArray.inject("") {|result, line| result += line}
    posted_at = nokogiri_resp.css('time[datetime]').text
    read_time = nokogiri_resp.at('span[title]')
    read_time = read_time.attributes.values[1].value[0..1] if read_time.present?
    tags = []
    nokogiri_resp.css('li a.u-baseColor--link').each do |tag|
      tags << tag.text if !tag.text.empty?
    end
    create_article(title, content, posted_at, read_time, author, tags)
  end

  def nokogiri_response(url)
    nokogiri_resp = Nokogiri::HTML(open(url));''
    return nokogiri_resp
  end

  def create_author(author_name, author_title)
    creator = Creator.find_or_create_by(name: author_name)
    creator.profile_title = author_title
    creator.save!
    return creator
  end

  def create_article(title, content, posted_at, read_time, author, tags)
    post = Post.find_or_create_by(title: title)
    post.content = content
    post.posted_at = posted_at
    post.read_time = read_time
    post.creator_id = author.id
    post.tags = tags
    post.save!
  end


end
