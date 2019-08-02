class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
    self
  end

  def self.create
    song = self.new
    song.save

  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = new_by_name(name)
    song.save
  end

  def self.find_by_name(name)
    self.all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create_by_name(name)
  end

  def self.alphabetical
    self.all.sort_by do |song|
      song.name
    end
  end

  def self.new_from_filename(filename)
    #"Thundercat - For Love I Come.mp3"
    song_name = filename.split(' - ')[1][0..-5]
    artist_name = filename.split(' - ')[0]
    song = new_by_name(song_name)
    song.artist_name = artist_name
    song
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end

  def self.destroy_all
    @@all.clear
  end
end



song = Song.new

importer_results = Importer.new.start  # ["Thundercat - For Love I come.mp3", ]


importer_results.each do |filename|
  Song.new_from_filename(filename)
end

new_song = Song.new

new_song.name = "My custom song"

new_song.artist_name = "Morgan"
