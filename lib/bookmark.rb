require 'pg'

class Bookmark
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
# Au lieu de bookmarks ici on peut mettre result.map. Ceci va envoyer l'info du model au controller, ce qui va etre renvoyer au view avec a variable
    bookmarks = connection.exec("SELECT * FROM bookmarks")
    # Change a partir du chapitre 11
    # bookmarks.map { |bookmark| bookmark['url'] }
    bookmarks.map do |bookmark|
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
  end

  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection,exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

    # connection.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
      @id = id
      @title = title
      @url = url
  end

end
end
