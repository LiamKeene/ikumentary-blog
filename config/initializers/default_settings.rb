# Blog settings - title, about, etc
Settings.defaults['blog.title'] = 'ikumentary'
Settings.defaults['blog.subtitle'] = 'parenting in japanese in australia'
Settings.defaults['blog.about'] = 'Ikumentary is a blog that documents a new 
father\'s attempt to raise his children using the Japanese language, while 
living in Australia.<br />
Oh, did I mention he is not Japanese?'

# Model Settings
Settings.defaults['articles.limit'] = 5

# Feed Settings
Settings.defaults['articles.feed.limit'] = 15
Settings.defaults['articles.feed.title'] = 'Ikumentary Blog'

# Hash for Paperclip - change this to something secure and don't change it again
Settings.paperclip_hash_digest = "SHA256"
Settings.paperclip_attachment_hash_secret = "some_secret_string"
Settings.paperclip_picture_hash_secret = "some_secret_string"