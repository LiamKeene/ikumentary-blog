class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :url => "/ckeditor_assets/attachments/:id/:filename",
                    :path => ":rails_root/public/ckeditor_assets/attachments/:id/:filename"

  validates_with AttachmentContentTypeValidator, attributes: :data, content_type: %w(application/pdf)
  validates_with AttachmentPresenceValidator, attributes: :data
  validates_with AttachmentSizeValidator, attributes: :data, less_than: 100.megabytes

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
