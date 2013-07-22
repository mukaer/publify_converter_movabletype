root = File.expand_path "../" , __FILE__

require "#{root}/mt5/author"
require "#{root}/mt5/entry"
require "#{root}/mt5/tag"
require "#{root}/mt5/objecttag"
require "#{root}/mt5/category"
require "#{root}/mt5/placement"


class Mt5Converter < BaseConverter
  def self.convert(options = {})
    converter = new(options)
    
    puts 'Starting convert'


    converter.import_users do |mt_user|
      ::User.new \
        :name     => mt_user.author_nickname,
        :email    => mt_user.author_email || "#{mt_user.author_name}@notfound.com",
        :login    => mt_user.author_name,
        :password              => new_user_password,
        :password_confirmation => new_user_password
    end
 
    converter.import_articles do |mt_article|
      unless mt_article.entry_title.blank? 
 
        if mt_article.entry_author_id.nil?
          user = nil
        else
          user = converter.users[MT5::Author.find(mt_article.entry_author_id.to_i).author_name]
        end
 
         extended,body  = !mt_article.entry_text_more.blank? ?
          [mt_article.entry_text_more, mt_article.entry_text] :
          [nil,                        mt_article.entry_text]
 
        a = ::Article.new \
          :title        => mt_article.entry_title,
          :body         => body,
          :extended     => extended,
          :created_at   => mt_article.entry_created_on,
          :published_at => mt_article.entry_authored_on,
          :updated_at   => mt_article.entry_modified_on,
          :user         => user,
          :author       => user.login,
          :permalink    => mt_article.entry_basename,
          :text_filter_id => converter.find_text_filter(mt_article.entry_convert_breaks),
          :allow_pings    => mt_article.entry_allow_pings,
          :allow_comments => mt_article.entry_allow_comments,
          :keywords       => mt_article.tags.join(',')
        [a, converter.find_or_create_categories(mt_article)]
      end
    end

    
  end



  def old_articles
     @old_article ||= MT5::Entry.find :all,
        :conditions => { :entry_status => '2' ,:entry_class => 'entry'}
  end

  def old_pages
  end

  def old_users
    @old_users ||= MT5::Author.find(:all).index_by &:author_id
  end


  def get_login(mt_user)
    mt_user.author_name
  end



  def find_or_create_categories(mt_article)
    mt_categories = mt_article.category
    categories_post = []
    mt_categories.each { |mt_categorie|
      create_categories(mt_categorie.category_label) if categories[mt_categorie.category_label].nil?
      categories_post << categories[mt_categorie.category_label]
    }
    categories_post
  end

  def find_text_filter(breaks)


    case breaks

    when "0"
      text_filter = 5

    when "__default__"
      text_filter = 5

    when "markdown"
      text_filter = 2

    when  "markdown_with_smartypants"
      text_filter = 4
      
    when "textile_2"
      text_filter = 5
      
    when "richtext"
      text_filter = 1

    else
      text_filter = 1
    end
    
    text_filter
  end
  
end
