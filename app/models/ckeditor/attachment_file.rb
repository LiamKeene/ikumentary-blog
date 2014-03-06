class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :hash_data => "attachments/:id/:filename",
                    :hash_digest => Settings.paperclip_hash_digest,
                    :hash_secret => Settings.paperclip_attachment_hash_secret,
                    :url => "/ckeditor_assets/:hash",
                    :path => ":rails_root/public/:url"

  validates_with AttachmentContentTypeValidator, attributes: :data, content_type: %w(application/pdf)
  validates_with AttachmentPresenceValidator, attributes: :data
  validates_with AttachmentSizeValidator, attributes: :data, less_than: 100.megabytes

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
