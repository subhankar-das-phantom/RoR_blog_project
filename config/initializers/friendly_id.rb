FriendlyId.defaults do |config|
  config.use :reserved
  config.use :finders
  config.use :slugged
  config.slug_column = 'slug'
  config.sequence_separator = '-'
  
  config.reserved_words = %w(new edit index session login logout users admin 
    posts comments search api app www mail ftp localhost)
end