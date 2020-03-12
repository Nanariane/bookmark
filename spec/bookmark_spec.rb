require 'bookmark'
require 'database_helpers'

describe Bookmark do

  describe '.all' do
    it 'returns all bookmarks' do
      # bookmarks = Bookmark.all
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      # Change a partir du chapitre 11
      # connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
      # connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
      # connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")
      bookmark = Bookmark.create(url: "http://www.makersacdemy.com", title: "Makers Academy")
      Bookmark.create(url: "http://destroyallsoftware.com", title: "Destroy All Software")
      Bookmark.create(url: "http://google.com", title: "Google")

      bookmarks = Bookmark.all

      # Change a partir du chapitre 11
      # expect(bookmarks).to include("http://www.makersacademy.com")
      # expect(bookmarks).to include("http://www.destroyallsoftware.com")
      # expect(bookmarks).to include("http://www.google.com")
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacdemy.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      # Change cette ligne parce que on a creer le fichier database_helpers et mets a la place :
      # persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
      persisted_data = persisted_data(id: bookmark.id)

      # Change au milieu du chapitre 11
      # expect(bookmark['url']).to eq 'http://www.testbookmark.com'
      # expect(bookmark['title']).to eq 'Test Bookmark'
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end
  end
end
