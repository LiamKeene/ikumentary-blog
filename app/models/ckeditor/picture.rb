class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :hash_data => "pictures/:id/:style_:basename.:extension",
                    :hash_digest => Settings.paperclip_hash_digest,
                    :hash_secret => Settings.paperclip_picture_hash_secret,
                    :url  => "/ckeditor_assets/:hash",
                    :path => ":rails_root/public/:url",
                    :styles => { :content => '800>', :thumb => '118x100#' }

  validates_with AttachmentContentTypeValidator, attributes: :data, content_type: %w(image/jpeg image/jpg image/png)
  validates_with AttachmentPresenceValidator, attributes: :data
  validates_with AttachmentSizeValidator, attributes: :data, less_than: 2.megabytes

  def url_content
    url(:content)
  end
end
