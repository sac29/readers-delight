
class ArticlesService


  def fetch_data(tag)
    require 'openssl'
    url = "https://medium.com/tag/#{tag}"


    posts = Nokogiri::HTML(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE));''

    posts.search(".postArticle-readMore a").each do |link|
      url = "#{link.attr('href')}"
      if url.include?("medium") && !url.include?("@")
        html_doc = Nokogiri::HTML(open(url));''
        binding.pry
        html_doc.css('a[data-user-id]').each do |doc|
          author = doc.text if doc.text.present?
        end
        if html_doc.css('.postMetaInline').text.present?
          author_title = html_doc.css('.postMetaInline').text
        else
          author_title = html_doc.css('.ui-summary').text
        end

        author = Creator.find_or_create_by(name: author)
        author.profile_title = author_title
        author.save!

        if html_doc.css('h1.graf--title').text.present?
          title = html_doc.css('h1.graf--title').text
        else
          title = html_doc.css('h1.elevate-h1').text
        end

        contentParagraphs = html_doc.css('.graf--p') # array containing all the paragraph
        contentArray =  contentParagraphs.map{|paragraph| paragraph.text}
        content = ""
        contentArray.each do |line|
          content += line
        end
        post = Post.find_or_create_by(title: title)
        post.content = content
        post.posted_at = html_doc.css('.u-inlineBlock').text
        read_time = html_doc.at('span[title]')
        post.read_time = read_time.attributes.values[1].value[0..1] if read_time.present?
        post.creator_id = author.id
        post.save!
      elsif url.include?("medium") && url.include?("@")
        html_doc = Nokogiri::HTML(open(url));''
        html_doc.css('a[data-user-id]').each do |doc|
          author = doc.text if doc.text.present?
        end
        author_title = html_doc.css('div.postMetaInline.ui-xs-clamp2').text
        author = Creator.find_or_create_by(name: author)
        author.profile_title = author_title
        author.save!
        if html_doc.css('h1.graf--title').text.present?
          title = html_doc.css('h1.graf--title').text
        else
          title = html_doc.css('h1.elevate-h1').text
        end

        title = "An article from medium" if title.blank?

        contentParagraphs = html_doc.css('.graf-after--p') # array containing all the paragraph
        contentArray =  contentParagraphs.map{|paragraph| paragraph.text}
        content = ""
        contentArray.each do |line|
          content += line
        end
        post = Post.find_or_create_by(title: title)
        post.content = content
        post.posted_at = html_doc.css('.postMetaInline time').text
        read_time = html_doc.at('span[title]')
        post.read_time = read_time.attributes.values[1].value[0..1] if read_time.present?
        post.creator_id = author.id
        post.save!

      else
        html_doc = Nokogiri::HTML(open(url));''
        html_doc.css('a[data-user-id]').each do |doc|
          author = doc.text if doc.text.present?
        end
        author_title = html_doc.css('.postMetaInline').text
        author = Creator.find_or_create_by(name: author)
        author.profile_title = author_title
        author.save!

        title = html_doc.css('h1.elevate-h1').text
        title = "An article from medium" if title.blank?
        contentParagraphs = html_doc.css('.graf--p')
        contentArray =  contentParagraphs.map{|paragraph| paragraph.text}
        content = ""
        contentArray.each do |line|
          content += line
        end
        post = Post.find_or_create_by(title: title)
        post.content = content
        post.posted_at = html_doc.css('.postMetaInline time').text
        read_time = html_doc.at('span[title]')
        post.read_time = read_time.attributes.values[1].value[0..1] if read_time.present?
        post.creator_id = author.id
        post.save!
      end

    end
  end

end
