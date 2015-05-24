class Page

  include Mongoid::Document

  field :page_id, :type => Integer
  field :title, :type => String
  field :rank, :type => Float
  field :hatebu, :type => Integer

  index(
    { :page_id => 1, },
    { :unique => true },
  )

  def as_json(options = {})
    attrs = super(options)
    attrs.delete "_id"
    attrs
  end

end
