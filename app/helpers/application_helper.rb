module ApplicationHelper

  #Meta tags helper methods
  def meta_title(title)
    content_for(:title, title)
  end

  def meta_description(description)
    puts "description" + description
    content_for(:meta_description, description)
  end

  def meta_keywords(keywords)
    content_for(:meta_keywords, keywords)
  end

  def meta_author(author)
    content_for(:meta_author, author)
  end

end
